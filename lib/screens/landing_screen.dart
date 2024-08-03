import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:pvvd_app/screens/presence_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  static String id = 'landing_screen';

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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width * 0.7,
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
                            const Text('Hi, Nama',
                                style:
                                    TextStyle(fontSize: 26, fontWeight: bold)),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 4, bottom: 8, right: 32),
                              child: Text('Nomor Telepon'),
                            ),
                            SizedBox(
                              height: 36,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: kGreyishTeal),
                                onPressed: null,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Role",
                                      style: TextStyle(color: Colors.white),
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
            Column(
              children: [
                SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) => functionCard(
                            context,
                            title: "Presensi",
                            desc: "Tandai kehadiran Anda di sini",
                            icon: Icons.qr_code_scanner,
                            screenId: PresenceScreen.id,
                          ),
                        ),
                        Builder(
                          builder: (context) => functionCard(
                            context,
                            title: "Riwayat Presensi",
                            desc: "Lihat riwayat kehadiran Anda di sini",
                            icon: Icons.history,
                            screenId: PresenceScreen.id,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Announcement"),
                        const Divider(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 534,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Builder(
                                  builder: (context) => announcementCard(
                                    context,
                                    title: "Jadwal Kebaktian",
                                    desc: "Hari Minggu, Jam 8 Pagi",
                                  ),
                                ),
                                Builder(
                                  builder: (context) => announcementCard(
                                    context,
                                    title: "Donasi Anak Asuh",
                                    desc:
                                        "Donasi anak asuh dapat dilakukan dengan menghubungi maling",
                                  ),
                                ),
                                Builder(
                                  builder: (context) => announcementCard(
                                    context,
                                    title: "Grup LINE PVVD Sports",
                                    desc:
                                        "PVVD mengadakan olahraga tiap hari sampai mati",
                                  ),
                                ),
                                Builder(
                                  builder: (context) => announcementCard(
                                    context,
                                    title: "Malam Keakraban",
                                    desc: "Paginya ga akrab",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget functionCard(
  BuildContext context, {
  required String title,
  required String desc,
  required String screenId,
  IconData? icon,
}) {
  double iconSize = MediaQuery.of(context).size.width * 0.2;
  double titleFontSize = MediaQuery.of(context).size.width * 0.05;
  double descFontSize = MediaQuery.of(context).size.width * 0.035;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: titleFontSize)),
                        Text(desc,
                            style: TextStyle(
                                color: Colors.black, fontSize: descFontSize)),
                      ],
                    ),
                  ),
                  if (icon != null) Icon(icon, size: iconSize),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kGreyishTeal)),
                  onPressed: () {
                    Navigator.pushNamed(context, screenId);
                  },
                  child: const Text("Tes"),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget announcementCard(
  BuildContext context, {
  required String title,
  required String desc,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    child: Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w800)),
            Text(desc, style: const TextStyle(color: Colors.black)),
            const TextButton(onPressed: null, child: Text("Read More >>"))
          ],
        ),
      ),
    ),
  );
}
