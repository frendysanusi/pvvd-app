import 'package:flutter/material.dart';
import 'package:pvvd_app/components/table.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:pvvd_app/utils/services.dart';

class UserPresenceDataScreen extends StatefulWidget {
  const UserPresenceDataScreen({super.key});
  static String id = 'user_presence_screen';

  @override
  State<UserPresenceDataScreen> createState() => _UserPresenceDataScreenState();
}

class _UserPresenceDataScreenState extends State<UserPresenceDataScreen> {
  late int currMonth;
  List<Services>? services;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    currMonth = now.month;
    fetchServices();
  }

  Future<void> fetchServices() async {
    await Services.getServices();
    setState(() {
      services = Services.instances;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (services != null && services!.isNotEmpty) {
      for (var service in services!) {
        print(service);
      }
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kShadedSpruce,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: kWhite,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Data Kehadiran',
            style: kBB2.copyWith(color: kWhite),
          )),
      backgroundColor: kGreyishTeal,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Bulan',
                  style: kBR5.copyWith(color: kGunmetal),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF636363)),
                  ),
                  child: DropdownButton<int>(
                    isExpanded: true,
                    style: kBR4.copyWith(color: kCasal),
                    value: currMonth,
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        currMonth = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  '/  12',
                  style: kBR5.copyWith(color: kGunmetal),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              border: TableBorder.all(),
              children: const [
                TableRow(
                  children: [
                    Column(
                      children: [
                        Cell(
                          text: 'Tanggal Kebaktian',
                          type: 'header',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Cell(
                          text: 'Detail',
                          type: 'header',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Cell(
                          text: 'Kehadiran',
                          type: 'header',
                        ),
                      ],
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Column(
                      children: [
                        Cell(
                          text: '16/06/2024',
                        ),
                      ],
                    ),
                    Column(
                      children: [],
                    ),
                    Column(
                      children: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
