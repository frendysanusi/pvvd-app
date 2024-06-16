import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pvvd_app/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyishTeal,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 85,
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/profile-placeholder.png',
                          width: 75,
                          height: 75,
                        ),
                        const Center(
                          child: SizedBox(
                            height: 85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Hi, Nama', style: TextStyle(fontSize: 26)),
                                Padding(
                                  padding:EdgeInsets.only(top: 14, bottom: 14, right: 48),
                                  child: Text('Nomor Telepon'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
        heightFactor: 0.7,
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
              backgroundColor: kGreyishTeal,
              resizeToAvoidBottomInset: true,
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileEditRow('Nomor Telepon'), //Perlu ada tahap verifikasi
                        buildProfileEditRow('Nama Lengkap'),
                        buildProfileEditRow('Tanggal Lahir'),
                        buildProfileEditRow('Golongan Darah'),
                        buildProfileEditRow('Alamat E-mail'),
                        buildProfileEditRow('Alamat Domisili'),
                        buildProfileEditRow('Kabupaten/Kota'),
                        buildProfileEditRow('Provinsi'),
                        buildProfileEditRow('Asal Instansi'),
                        buildProfileEditRow('Bidang/Jurusan'),
                        buildProfileEditRow('Jenjang Pendidikan'),
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

Widget buildProfileRow(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        child: Text(title),
      ),
      const Text('Data'),
      const Divider(),
    ],
  );
}

Widget buildProfileEditRow(String title) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: title,
              labelStyle: const TextStyle(color: Colors.white),
              hintText: "data",
              hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
          ),
        ),
      ),
    ],
  );
}