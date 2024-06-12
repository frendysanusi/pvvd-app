import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pvvd_app/auth.dart';
import 'package:pvvd_app/components/components.dart';
import 'package:pvvd_app/screens/presence_screen.dart';
import 'package:pvvd_app/screens/register_screen.dart';
import 'package:pvvd_app/utils/app_regex.dart';
import 'package:pvvd_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListeners);

    passwordController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void controllerListeners() {
    final email = emailController.text;
    final password = passwordController.text;

    errorMessage = '';

    bool fieldIsEmpty = email.isEmpty || password.isEmpty;

    if (!fieldIsEmpty) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _formKey.currentState?.validate();
    }
  }

  // get email with phone number
  Future<void> signInWithPhone() async {
    try {
      String phone = '+62${emailController.text.substring(1)}';
      final Query phoneQuery;
      phoneQuery = FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phone);

      QuerySnapshot notificationSnapshot = await phoneQuery.get();
      List<QueryDocumentSnapshot> emailDocuments = notificationSnapshot.docs;

      for (QueryDocumentSnapshot document in emailDocuments) {
        emailController.text =
            (document.data() as Map<String, dynamic>)['email'];
      }
      await signInWithEmailAndPassword();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _formKey.currentState?.validate();
    }
  }

  Future<void> signInWithEmailorPhone() async {
    try {
      if (AppRegex.emailRegex.hasMatch(emailController.text)) {
        await signInWithEmailAndPassword();
      } else {
        await signInWithPhone();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _formKey.currentState?.validate();
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGunmetal,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Column(
              children: [
                const SizedBox(height: 211),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/logo_pvvd.png',
                    width: 32,
                    height: 31,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: kBM1.copyWith(color: kWhite),
                  ),
                ),
                const SizedBox(height: 52),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: emailController,
                        fieldText: "E-mail atau No. Telepon",
                        labelText: "Masukkan e-mail atau nomor telepon Anda",
                        required: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return errorMessage!.isNotEmpty
                              ? "E-mail atau nomor telepon Anda salah"
                              : AppRegex.emailRegex.hasMatch(value!) ||
                                      value.length == 11 ||
                                      value.length == 12
                                  ? null
                                  : "E-mail atau nomor telepon Anda invalid";
                        },
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<bool>(
                        valueListenable: passwordNotifier,
                        builder: (_, passwordObscure, __) {
                          return AppTextFormField(
                            controller: passwordController,
                            fieldText: "Password",
                            labelText: "Masukkan password Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: passwordObscure,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return errorMessage!.isNotEmpty
                                  ? "Password Anda salah"
                                  : null;
                            },
                            suffixIcon: Focus(
                              descendantsAreFocusable: false,
                              child: IconButton(
                                onPressed: () =>
                                    passwordNotifier.value = !passwordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  passwordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: kBlack,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 9),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Lupa Password?',
                            style: kBR6.copyWith(
                              color: kSilverSand,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      ValueListenableBuilder(
                        valueListenable: fieldValidNotifier,
                        builder: (_, isValid, __) {
                          return CustomButton(
                            buttonText: 'LOGIN',
                            width: 321,
                            height: 61,
                            buttonColor: kGreyishTeal,
                            textColor: Colors.white,
                            isDisabled: !isValid,
                            onPressed: () async {
                              await signInWithEmailorPhone();
                              Navigator.pushNamed(context, PresenceScreen.id);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: kSilverSand,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Belum memiliki akun? ',
                            ),
                            TextSpan(
                              text: 'Register',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.id);
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 222),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
