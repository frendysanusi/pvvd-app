import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:pvvd_app/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _domicileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _instanceController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _bloodController.dispose();
    _domicileController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _instanceController.dispose();
    _fieldController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCasal,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          leading: const BackButton(
            color: Colors.white,
          ),
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                profileEditBottomSheet(context);
              },
              icon: const Icon(Icons.edit),
            ),
          ]),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  child: SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/profile-placeholder.png',
                          width: 80,
                          height: 80,
                        ),
                        Center(
                          child: SizedBox(
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Hi, Nama', style: TextStyle(fontSize: 26, fontWeight: bold)),
                                const Padding(
                                  padding:EdgeInsets.only(top: 4, bottom: 8, right: 32),
                                  child: Text('Nomor Telepon'),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextButton(
                                    style: TextButton.styleFrom(backgroundColor: kGreyishTeal),
                                    onPressed: null,
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Role", style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), // Rounded corners radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 32
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileRow('Nama Lengkap'),
                        buildProfileRow('Tanggal Lahir'),
                        buildProfileRow('Golongan Darah'),
                        buildProfileRow('Alamat E-mail'),
                        buildProfileRow('Alamat Domisili'),
                        buildProfileRow('Kabupaten/Kota'),
                        buildProfileRow('Provinsi'),
                        buildProfileRow('Asal Instansi'),
                        buildProfileRow('Bidang/Jurusan'),
                        buildProfileRow('Jenjang Pendidikan'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void profileEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.65,
          child: Container(
            height: MediaQuery.of(context).size.height*0.8, // Adjust the height as needed
            decoration: const BoxDecoration(
              color: kGreyishTeal,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildProfileEditRow(title: 'Nomor Telepon', controller: _phoneController), //Perlu ada tahap verifikasi
                          buildProfileEditRow(title: 'Nama Lengkap', controller: _nameController),
                          buildProfileEditRow(title: 'Tanggal Lahir', controller: _birthdayController),
                          buildProfileEditRow(title: 'Golongan Darah', controller: _bloodController),
                          buildProfileEditRow(title: 'Alamat E-mail', controller: _emailController),
                          buildProfileEditRow(title: 'Alamat Domisili', controller: _domicileController),
                          buildProfileEditRow(title: 'Kabupaten/Kota', controller: _cityController),
                          buildProfileEditRow(title: 'Provinsi', controller: _provinceController),
                          buildProfileEditRow(title: 'Asal Instansi', controller: _instanceController),
                          buildProfileEditRow(title: 'Bidang/Jurusan', controller: _fieldController),
                          buildProfileEditRow(title: 'Jenjang Pendidikan', controller: _educationController),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildProfileRow(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        child: Text(title, style: const TextStyle(color: Colors.black),),
      ),
      const Text('Data'),
      const Divider(),
    ],
  );
}

Widget buildProfileEditRow({required String title, required TextEditingController controller}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              labelText: title,
              hintText: "data",
              hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
    ],
  );
}


// Widget buildProfileEditRow({required String title, required TextEditingController controller}) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(bottom: 12),
//         child: EditableText(
//           controller: controller,
//           focusNode: FocusNode(),
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 16.0,
//           ),
//           decoration: InputDecoration(
// //               labelText: title,
// //               hintText: "data",
// //               hintStyle: const TextStyle(fontWeight: FontWeight.normal),
// //           ),
//           cursorColor: Colors.blue,
//           backgroundCursorColor: Colors.grey,
//           keyboardType: TextInputType.text,
//           inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
//           onChanged: (value) {
//             print('Text changed: $value');
//           },
//           onSubmitted: (value) {
//             print('Text submitted: $value');
//           },
//         ),
//       ),
//       Text(title, style: const TextStyle(fontWeight: FontWeight.normal)),
//     ],
//   );
// }
