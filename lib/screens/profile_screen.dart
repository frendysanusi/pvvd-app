// import 'dart:ui';
// import 'package:flutter/services.dart';
// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
import 'package:pvvd_app/components/navbar.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:pvvd_app/utils/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String id = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstnameController = TextEditingController();
  late TextEditingController _lastnameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _birthdayController = TextEditingController();
  late TextEditingController _bloodController = TextEditingController();
  late TextEditingController _domicileController = TextEditingController();
  late TextEditingController _districtController = TextEditingController();
  late TextEditingController _subdistrictController = TextEditingController();
  late TextEditingController _provinceController = TextEditingController();
  late TextEditingController _schoolController = TextEditingController();
  late TextEditingController _majorController = TextEditingController();
  late TextEditingController _educationController = TextEditingController();

  late Profile profile = Profile.instance!;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: profile.firstname);
    _lastnameController = TextEditingController(text: profile.lastname);
    _phoneController = TextEditingController(text: profile.phone);
    _emailController = TextEditingController(text: profile.email);
    _birthdayController = TextEditingController(text: profile.birthdate);
    _bloodController = TextEditingController(text: profile.bloodtype);
    _domicileController = TextEditingController(text: profile.domicile);
    _districtController = TextEditingController(text: profile.district);
    _subdistrictController = TextEditingController(text: profile.subdistrict);
    _provinceController = TextEditingController(text: profile.province);
    _schoolController = TextEditingController(text: profile.school);
    _majorController = TextEditingController(text: profile.major);
    _educationController = TextEditingController(text: profile.educationlevel);
    fetchProfile();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _bloodController.dispose();
    _domicileController.dispose();
    _districtController.dispose();
    _provinceController.dispose();
    _schoolController.dispose();
    _majorController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  Future<void> fetchProfile() async {
    await Profile.getProfile();
    setState(() {
      profile = Profile.instance!;
    });
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  child: SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profile.image != null
                            ? Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(profile.image!),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Image.asset(
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
                                Text('Hi, ${profile.firstname}',
                                    style: const TextStyle(
                                        fontSize: 26, fontWeight: bold)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4, bottom: 8, right: 32),
                                  child: Text(profile.phone),
                                ),
                                SizedBox(
                                  height: 36,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: kGreyishTeal),
                                    onPressed: null,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          profile.role,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
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
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight:
                            Radius.circular(25)), // Rounded corners radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileRow('Nama Lengkap',
                            '${profile.firstname} ${profile.lastname}'),
                        buildProfileRow('Tanggal Lahir', profile.birthdate),
                        buildProfileRow('Golongan Darah', profile.bloodtype),
                        buildProfileRow('Alamat E-mail', profile.email),
                        buildProfileRow('Alamat Domisili', profile.domicile),
                        buildProfileRow('Kabupaten/Kota', profile.district),
                        buildProfileRow('Kecamatan', profile.subdistrict),
                        buildProfileRow('Provinsi', profile.province),
                        buildProfileRow('Asal Instansi', profile.school),
                        buildProfileRow('Bidang/Jurusan', profile.major),
                        buildProfileRow(
                            'Jenjang Pendidikan', profile.educationlevel),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(
        currentIndex: 3,
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
            height: MediaQuery.of(context).size.height *
                0.8, // Adjust the height as needed
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildProfileEditRow(
                              title: 'Nomor Telepon',
                              controller:
                                  _phoneController), //Perlu ada tahap verifikasi
                          buildProfileEditRow(
                              title: 'Nama Depan',
                              controller: _firstnameController),
                          buildProfileEditRow(
                              title: 'Nama Belakang',
                              controller: _lastnameController),
                          buildProfileEditRow(
                              title: 'Tanggal Lahir',
                              controller: _birthdayController),
                          buildProfileEditRow(
                              title: 'Golongan Darah',
                              controller: _bloodController),
                          buildProfileEditRow(
                              title: 'Alamat E-mail',
                              controller: _emailController),
                          buildProfileEditRow(
                              title: 'Alamat Domisili',
                              controller: _domicileController),
                          buildProfileEditRow(
                              title: 'Kabupaten/Kota',
                              controller: _districtController),
                          buildProfileEditRow(
                              title: 'Kecamatan',
                              controller: _subdistrictController),
                          buildProfileEditRow(
                              title: 'Provinsi',
                              controller: _provinceController),
                          buildProfileEditRow(
                              title: 'Asal Instansi',
                              controller: _schoolController),
                          buildProfileEditRow(
                              title: 'Bidang/Jurusan',
                              controller: _majorController),
                          buildProfileEditRow(
                              title: 'Jenjang Pendidikan',
                              controller: _educationController),
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

Widget buildProfileRow(String title, String? data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      Text(
        data ?? '-',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
      const Divider(),
    ],
  );
}

Widget buildProfileEditRow(
    {required String title, required TextEditingController controller}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: title,
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
