import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvvd_app/components/navbar.dart';
import 'package:pvvd_app/screens/user_presence_data_screen.dart';
import 'package:pvvd_app/screens/welcome_screen.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:pvvd_app/screens/presence_screen.dart';
import 'package:pvvd_app/utils/profile.dart';
import 'package:pvvd_app/utils/services.dart';
import 'package:pvvd_app/utils/announcements.dart';
import 'package:intl/intl.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  static String id = 'landing_screen';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Profile? profile = Profile.instance;
  List<Services>? services = Services.instances;
  List<Announcements>? announcements = Announcements.instances;

  @override
  void initState() {
    super.  initState();
    isLoggedIn();
    fetchProfile();
    fetchServices();
    fetchAnnouncements();
  }

  Future<void> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      return;
    }
  }

  Future<void> fetchProfile() async {
    await Profile.getProfile();
    setState(() {
      profile = Profile.instance!;
    });
  }

  Future<void> fetchServices() async {
    await Services.getServices(06, 2024);
    setState(() {
      services = Services.instances!;
    });
  }

  Future<void> fetchAnnouncements() async {
    await Announcements.getAnnouncements();
    setState(() {
      announcements = Announcements.instances!;
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
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
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
                      profile?.image != null
                          ? Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: MemoryImage(
                                    base64Decode(profile?.image ?? ''),
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
                              Text('Hi, ${profile?.firstname ?? 'User'}',
                                  style: const TextStyle(
                                      fontSize: 26, fontWeight: bold)),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 8, right: 32),
                                child: Text(profile?.phone ?? '08123456789'),
                              ),
                              SizedBox(
                                height: 36,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: kGreyishTeal),
                                  onPressed: null,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        profile?.role ?? 'Guest',
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
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) => functionCard(
                            context,
                            title: "Scan QR",
                            desc: "Tandai kehadiran Anda di sini",
                            icon: Icons.qr_code_scanner,
                            buttonText: "Tandai Hadir",
                            screenId: PresenceScreen.id,
                          ),
                        ),
                        Builder(
                          builder: (context) => functionCard(
                            context,
                            title: "Jadwal Kebaktian",
                            desc: "Lihat Jadwal Kebaktian di sini",
                            icon: Icons.date_range,
                            buttonText: "Lihat Jadwal",
                            screenId: "scheduleBottomSheet",
                          ),
                        ),
                        Builder(
                          builder: (context) => functionCard(
                            context,
                            title: "Riwayat Presensi",
                            desc: "Lihat riwayat kehadiran Anda di sini",
                            icon: Icons.history,
                            buttonText: "Lihat Presensi",
                            screenId: UserPresenceDataScreen.id,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Pengumuman"),
                        const Divider(),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: (announcements?.length ?? 0) * MediaQuery.of(context).size.height * 0.21,
                              child: ListView.builder(
                                  itemCount: announcements?.length ?? 0,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => announcementCard(
                                  context,
                                  title: announcements?[index].title ?? '',
                                  desc: announcements?[index].desc ?? '',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(
        currentIndex: 0,
      ),
    );
  }

  void scheduleBottomSheet(BuildContext context) {
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
                          Text("Jadwal Kebaktian", style: TextStyle(color: Colors.black),),
                          
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: (services?.length ?? 0) * MediaQuery.of(context).size.height * 0.21,
                            child: ListView.builder(
                              itemCount: services?.length ?? 0,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => serviceCard(
                                context,
                                date: services?[index].date ?? DateTime(2024, 01, 01),
                                leader: services?[index].leader ?? '',
                                translator: services?[index].translator ?? '',
                                speaker: services?[index].speaker ?? '',
                                topic: services?[index].topic ?? '',
                              ),
                            ),
                          ),
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

  Widget functionCard(
      BuildContext context, {
        required String title,
        required String desc,
        required String buttonText,
        required String screenId,
        IconData? icon,
      }) {
    final double iconSize = MediaQuery.of(context).size.width * 0.2;
    final double titleFontSize = MediaQuery.of(context).size.width * 0.05;
    final double descFontSize = MediaQuery.of(context).size.width * 0.035;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.45,
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
                      if (screenId == "scheduleBottomSheet") {
                        scheduleBottomSheet(context);
                      } else {
                        Navigator.pushNamed(context, screenId);
                      }
                    },
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceCard(
      BuildContext context, {
        required DateTime date,
        required String leader,
        required String translator,
        required String speaker,
        required String topic,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(topic,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w800)),
              Text(speaker, style: const TextStyle(color: Colors.black)),
              Text(DateFormat('dd/MM/yyyy').format(date), style: const TextStyle(color: Colors.black)),
              Text(leader, style: const TextStyle(color: Colors.black)),
              Text(translator, style: const TextStyle(color: Colors.black)),
              Divider(),
            ],
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
        height: 180,
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
}