import 'package:flutter/material.dart';
import 'package:pvvd_app/components/navbar.dart';
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
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/profile-placeholder.png',
                        width: 70,
                        height: 70,
                      ),
                      const Center(
                        child: SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Nama Lengkap'),
                              Text('Nomor Telepon'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Lahir'),
                          Text(''),
                          Divider(),
                          Text('Golongan Darah'),
                          Text(''),
                          Divider(),
                          Text('Alamat E-mail'),
                          Text(''),
                          Divider(),
                          Text('Alamat Domisili'),
                          Text(''),
                          Divider(),
                          Text('Kabupaten/Kota'),
                          Text(''),
                          Divider(),
                          Text('Provinsi'),
                          Text(''),
                          Divider(),
                          Text('Asal Instansi'),
                          Text(''),
                          Divider(),
                          Text('Bidang/Jurusan'),
                          Text(''),
                          Divider(),
                          Text('Jenjang Pendidikan'),
                          Text(''),
                        ],
                      ),
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
}
