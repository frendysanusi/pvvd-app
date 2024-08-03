import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pvvd_app/components/detail_service.dart';
import 'package:pvvd_app/components/navbar.dart';
import 'package:pvvd_app/components/presence_button.dart';
import 'package:pvvd_app/components/detail_button.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:pvvd_app/utils/presences.dart';
import 'package:pvvd_app/utils/services.dart';

class UserPresenceDataScreen extends StatefulWidget {
  const UserPresenceDataScreen({super.key});
  static String id = 'user_presence_screen';

  @override
  State<UserPresenceDataScreen> createState() => _UserPresenceDataScreenState();
}

class _UserPresenceDataScreenState extends State<UserPresenceDataScreen> {
  late int currMonth;
  late int currYear;
  List<Services>? services;
  List<Presences>? presences;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    currMonth = now.month;
    currYear = now.year;
    fetchServices(currMonth, currYear);
    fetchPresences();
  }

  Future<void> fetchServices(int currMonth, int currYear) async {
    await Services.getServices(currMonth, currYear);
    setState(() {
      services = Services.instances;
    });
  }

  Future<void> fetchPresences() async {
    await Presences.getPresencesByUserId(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      presences = Presences.instances;
    });
  }

  Widget generateServiceTable(double screenWidth, double screenHeight) {
    if (services == null || services!.isEmpty) {
      return SizedBox(
        height: screenHeight * 0.4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'Tidak ada data',
              style: kBM5.copyWith(color: kBlack),
            ),
            Positioned(
              child: Image.asset(
                'assets/images/logo-pvvd-transparent-15%.png',
                width: screenWidth * 0.5964,
                height: screenHeight * 0.2892,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      );
    }
    return DataTableTheme(
      data: DataTableThemeData(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => kShadedSpruce),
        headingTextStyle: kBR7.copyWith(color: kBlack),
        dataRowColor: MaterialStateColor.resolveWith((states) => kGreyishTeal),
        dataTextStyle: kBS6.copyWith(
          color: kBlack,
        ),
      ),
      child: PaginatedDataTable(
        onRowsPerPageChanged: (perPage) {},
        availableRowsPerPage:
            services!.length >= 10 ? const [5, 10, 15] : [services!.length],
        rowsPerPage: services!.length >= 10 ? 10 : services!.length,
        showEmptyRows: false,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Tanggal Kebaktian'),
          ),
          DataColumn(
            label: Text('Detail'),
          ),
          DataColumn(
            label: Text('Kehadiran'),
          ),
        ],
        source: ServicesDataSource(
            services!, presences!, screenWidth, screenHeight, context),
        columnSpacing: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.057),
              Row(
                children: [
                  Text(
                    'Bulan',
                    style: kBR5.copyWith(color: kGunmetal),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
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
                          fetchServices(currMonth, currYear);
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
              Row(
                children: [
                  Text(
                    'Tahun',
                    style: kBR5.copyWith(color: kGunmetal),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF636363)),
                    ),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      style: kBR4.copyWith(color: kCasal),
                      value: currYear,
                      items: List.generate(5, (index) {
                        int year = currYear - 2 + index;
                        return DropdownMenuItem(
                          value: year,
                          child: Text('$year'),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          currYear = value!;
                          fetchServices(currMonth, currYear);
                        });
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    '/  ${currYear + 2}',
                    style: kBR5.copyWith(color: kGunmetal),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              generateServiceTable(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.18),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(
        currentIndex: 2,
      ),
    );
  }
}

class ServicesDataSource extends DataTableSource {
  final List<Services> services;
  final List<Presences> presences;
  final double screenWidth;
  final double screenHeight;
  final BuildContext context;

  ServicesDataSource(
    this.services,
    this.presences,
    this.screenWidth,
    this.screenHeight,
    this.context,
  );

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= services.length) {
      return null;
    }
    final service = services[index];
    String status = 'Tidak Hadir';
    for (Presences presence in presences) {
      if (presence.serviceId == service.serviceId) {
        status = 'Hadir';
        break;
      }
    }
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
          child: Text(
            DateFormat.yMMMMd('id').format(service.date),
            style: kBR7.copyWith(
              color: kBlack,
            ),
          ),
        )),
        DataCell(
          Container(
            alignment: Alignment.center,
            child: DetailButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      buildDetailService(context, service),
                );
              },
              width: 0.2 * screenWidth,
              height: 0.05 * screenHeight,
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            child: PresenceButton(
              buttonText: status,
              width: 0.2 * screenWidth,
              height: 0.05 * screenHeight,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => services.length;

  @override
  int get selectedRowCount => 0;
}
