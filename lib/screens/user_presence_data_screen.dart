import 'package:flutter/material.dart';
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

  Widget generateServiceTable(double screenWidth, double screenHeight) {
    if (services == null || services!.isEmpty) {
      return const Text('Tidak ada data');
    }
    return Stack(
      children: [
        DataTableTheme(
          data: DataTableThemeData(
            headingRowColor:
                MaterialStateColor.resolveWith((states) => kShadedSpruce),
            headingTextStyle: kBR7.copyWith(color: kBlack),
            dataRowColor:
                MaterialStateColor.resolveWith((states) => kGreyishTeal),
            dataTextStyle: kBS6.copyWith(
              color: kBlack,
            ),
          ),
          child: PaginatedDataTable(
            onRowsPerPageChanged: (perPage) {},
            availableRowsPerPage: const [5, 10, 15],
            rowsPerPage: 10,
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
            source: ServicesDataSource(services!, screenWidth, screenHeight),
            columnSpacing: 40,
          ),
        ),
        Positioned(
          top: screenHeight * 0.5 - (screenHeight * 0.2892 / 2),
          left: screenWidth * 0.45 - (screenWidth * 0.5964 / 2),
          child: Image.asset(
            'assets/images/logo-pvvd-transparent-15%.png',
            width: screenWidth * 0.5964,
            height: screenHeight * 0.2892,
            fit: BoxFit.contain,
          ),
        ),
      ],
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
              generateServiceTable(screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesDataSource extends DataTableSource {
  final List<Services> services;
  final double screenWidth;
  final double screenHeight;

  ServicesDataSource(
    this.services,
    this.screenWidth,
    this.screenHeight,
  );

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= services.length) {
      return null;
    }
    final service = services[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
          child: Text(
            service.date.toString().substring(0, 10),
            style: kBR7.copyWith(
              color: kBlack,
            ),
          ),
        )),
        DataCell(Text("Cell $index")),
        DataCell(Text("Cell $index")),
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
