import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvvd_app/auth.dart';
import 'package:pvvd_app/components/components.dart';
import 'package:pvvd_app/screens/welcome_screen.dart';
import 'package:pvvd_app/utils/app_regex.dart';
import 'package:pvvd_app/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController firstnameController;
  late final TextEditingController lastnameController;
  late final TextEditingController nicknameController;
  late final TextEditingController birthdateController;
  late final TextEditingController phoneController;
  late final TextEditingController idlineController;
  late final TextEditingController schoolController;
  late final TextEditingController educationlevelController;
  late final TextEditingController majorController;
  late final TextEditingController bloodtypeController;
  late final TextEditingController domicileController;
  late final TextEditingController subdistrictController;
  late final TextEditingController districtController;
  late final TextEditingController provinceController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);

  DateTime temp = DateTime.now();

  final pageController = PageController(
    initialPage: 1,
  );
  int currentPage = 1;

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListeners);
    firstnameController = TextEditingController()
      ..addListener(controllerListeners);
    lastnameController = TextEditingController()
      ..addListener(controllerListeners);
    nicknameController = TextEditingController()
      ..addListener(controllerListeners);
    birthdateController = TextEditingController()
      ..addListener(controllerListeners);
    phoneController = TextEditingController()..addListener(controllerListeners);
    idlineController = TextEditingController()
      ..addListener(controllerListeners);
    schoolController = TextEditingController()
      ..addListener(controllerListeners);
    educationlevelController = TextEditingController()
      ..addListener(controllerListeners);
    majorController = TextEditingController()..addListener(controllerListeners);
    bloodtypeController = TextEditingController()
      ..addListener(controllerListeners);
    domicileController = TextEditingController()
      ..addListener(controllerListeners);
    subdistrictController = TextEditingController()
      ..addListener(controllerListeners);
    districtController = TextEditingController()
      ..addListener(controllerListeners);
    provinceController = TextEditingController()
      ..addListener(controllerListeners);
    passwordController = TextEditingController()
      ..addListener(controllerListeners);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListeners);
  }

  void disposeControllers() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    nicknameController.dispose();
    birthdateController.dispose();
    phoneController.dispose();
    idlineController.dispose();
    schoolController.dispose();
    educationlevelController.dispose();
    majorController.dispose();
    bloodtypeController.dispose();
    domicileController.dispose();
    subdistrictController.dispose();
    districtController.dispose();
    provinceController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListeners() {
    final email = emailController.text;
    final firstname = firstnameController.text;
    final lastname = lastnameController.text;
    final nickname = nicknameController.text;
    final birthdate = birthdateController.text;
    final phone = phoneController.text;
    final idline = idlineController.text;
    final school = schoolController.text;
    final educationlevel = educationlevelController.text;
    final major = majorController.text;
    final bloodtype = bloodtypeController.text;
    final domicile = domicileController.text;
    final subdistrict = subdistrictController.text;
    final district = districtController.text;
    final province = provinceController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    errorMessage = '';

    bool fieldIsEmpty = email.isEmpty ||
        firstname.isEmpty ||
        lastname.isEmpty ||
        nickname.isEmpty ||
        birthdate.isEmpty ||
        phone.isEmpty ||
        idline.isEmpty ||
        school.isEmpty ||
        educationlevel.isEmpty ||
        major.isEmpty ||
        bloodtype.isEmpty ||
        domicile.isEmpty ||
        subdistrict.isEmpty ||
        district.isEmpty ||
        province.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty;

    if (AppRegex.emailRegex.hasMatch(email) &&
        password == confirmPassword &&
        !fieldIsEmpty) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await addUserDetails(
          FirebaseAuth.instance.currentUser!.uid,
          emailController.text,
          firstnameController.text,
          lastnameController.text,
          nicknameController.text,
          birthdateController.text,
          phoneController.text,
          idlineController.text,
          schoolController.text,
          educationlevelController.text,
          majorController.text,
          bloodtypeController.text,
          domicileController.text,
          subdistrictController.text,
          districtController.text,
          provinceController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });

      _formKey.currentState?.validate();
    }
  }

  Future<void> addUserDetails(
    String uid,
    String email,
    String firstname,
    String lastname,
    String nickname,
    String birthdate,
    String phone,
    String idline,
    String school,
    String educationlevel,
    String major,
    String bloodtype,
    String domicile,
    String subdistrict,
    String district,
    String province,
  ) async {
    try {
      final users = FirebaseFirestore.instance.collection('users');
      final docRef = users.doc(uid);
      docRef.set({
        'id': uid,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'nickname': nickname,
        'birthdate': birthdate,
        'phone': '+62$phone',
        'idline': idline,
        'school': school,
        'educationlevel': educationlevel,
        'major': major,
        'bloodtype': bloodtype,
        'domicile': domicile,
        'subdistrict': subdistrict,
        'district': district,
        'province': province,
      });
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
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
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/logo_pvvd.png',
                        width: 32,
                        height: 31,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Register',
                        style: kBM1.copyWith(color: kWhite),
                      ),
                    ),
                    const SizedBox(height: 57),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: emailController,
                            fieldText: "E-mail",
                            labelText: "Masukkan e-mail Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return errorMessage!.isNotEmpty
                                  ? "E-mail Anda sudah digunakan"
                                  : value!.isEmpty
                                      ? null
                                      : AppRegex.emailRegex.hasMatch(value)
                                          ? null
                                          : "E-mail Anda invalid";
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
                                onChanged: (_) =>
                                    _formKey.currentState?.validate(),
                                validator: (value) {
                                  return value!.isEmpty
                                      ? null
                                      : value.length >= 6
                                          ? null
                                          : "Password minimal 6 karakter";
                                },
                                suffixIcon: Focus(
                                  descendantsAreFocusable: false,
                                  child: IconButton(
                                    onPressed: () => passwordNotifier.value =
                                        !passwordObscure,
                                    style: IconButton.styleFrom(
                                      minimumSize: const Size.square(48),
                                    ),
                                    icon: Icon(
                                      passwordObscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          ValueListenableBuilder(
                            valueListenable: confirmPasswordNotifier,
                            builder: (_, confirmPasswordObscure, __) {
                              return AppTextFormField(
                                controller: confirmPasswordController,
                                fieldText: "Konfirmasi Password",
                                labelText: "Masukkan kembali password Anda",
                                required: true,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.visiblePassword,
                                obscureText: confirmPasswordObscure,
                                onChanged: (_) =>
                                    _formKey.currentState?.validate(),
                                validator: (value) {
                                  return passwordController.text ==
                                          confirmPasswordController.text
                                      ? null
                                      : "Password tidak sama";
                                },
                                suffixIcon: Focus(
                                  descendantsAreFocusable: false,
                                  child: IconButton(
                                    onPressed: () => confirmPasswordNotifier
                                        .value = !confirmPasswordObscure,
                                    style: IconButton.styleFrom(
                                      minimumSize: const Size.square(48),
                                    ),
                                    icon: Icon(
                                      confirmPasswordObscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: firstnameController,
                            fieldText: "Nama Depan",
                            labelText: "Masukkan nama depan Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: lastnameController,
                            fieldText: "Nama Belakang",
                            labelText: "Masukkan nama belakang Anda",
                            required: false,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: nicknameController,
                            fieldText: "Nama Panggilan",
                            labelText: "Masukkan nama panggilan Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: birthdateController,
                            fieldText: "Tanggal Lahir",
                            labelText: "Masukkan nama tanggal lahir Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.datetime,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            onTap: () async {
                              DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());

                              date = await showDatePicker(
                                  context: context,
                                  initialDate: temp,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));

                              if (date != null) {
                                temp = date;
                              }

                              if (date == null &&
                                  birthdateController.text.isEmpty) {
                                return;
                              }

                              date ??= temp;

                              String month = date.month.toString();
                              if (month.length == 1) {
                                month = '0$month';
                              }

                              birthdateController.text =
                                  '${date.day}/$month/${date.year}';
                            },
                          ),
                          const SizedBox(height: 16),
                          AppPhoneFormField(
                            controller: phoneController,
                            fieldText: "Nomor Telepon",
                            labelText: "Masukkan nomor telepon Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.phone,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? null
                                  : value.length == 11 || value.length == 12
                                      ? null
                                      : "Nomor telepon invalid";
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: idlineController,
                            fieldText: "ID LINE",
                            labelText: "Masukkan ID LINE Anda",
                            required: false,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: schoolController,
                            fieldText: "Asal Sekolah/Universitas",
                            labelText: "Masukkan asal sekolah/universitas Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: educationlevelController,
                            fieldText: "Jenjang Pendidikan",
                            labelText: "Masukkan jenjang pendidikan Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: majorController,
                            fieldText: "Jurusan",
                            labelText: "Masukkan jurusan Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: bloodtypeController,
                            fieldText: "Golongan Darah",
                            labelText: "Masukkan golongan darah Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: domicileController,
                            fieldText: "Alamat Domisili",
                            labelText: "Masukkan alamat domisili Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: subdistrictController,
                            fieldText: "Kecamatan",
                            labelText: "Masukkan kecamatan alamat Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: districtController,
                            fieldText: "Kabupaten/Kota",
                            labelText: "Masukkan kabupaten/kota alamat Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 16),
                          AppTextFormField(
                            controller: provinceController,
                            fieldText: "Provinsi",
                            labelText: "Masukkan provinsi alamat Anda",
                            required: true,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                          ),
                          const SizedBox(height: 29),
                          ValueListenableBuilder(
                            valueListenable: fieldValidNotifier,
                            builder: (_, isValid, __) {
                              return CustomButton(
                                buttonText: 'REGISTER',
                                width: 187,
                                height: 38,
                                buttonColor: kGreyishTeal,
                                textColor: Colors.white,
                                isDisabled: !isValid,
                                onPressed: () async {
                                  await createUserWithEmailAndPassword();
                                  Navigator.pushNamed(
                                      context, WelcomeScreen.id);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 53.5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
