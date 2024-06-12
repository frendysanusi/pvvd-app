import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvvd_app/components/components.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PresenceScreen extends StatefulWidget {
  const PresenceScreen({super.key});
  static String id = 'presence_screen';

  @override
  State<PresenceScreen> createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  String? errorMessage = '';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  Future<void> addPresence(DateTime date) async {
    try {
      final presences = FirebaseFirestore.instance.collection('presences');
      final services = FirebaseFirestore.instance.collection('services');
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final servicesQuerySnapshot = await services.get();
      bool dateMatches = false;
      String? servicesId;
      for (var doc in servicesQuerySnapshot.docs) {
        final serviceDate = (doc['date'] as Timestamp).toDate();
        if (date.day == serviceDate.day &&
            date.month == serviceDate.month &&
            date.year == serviceDate.year) {
          dateMatches = true;
          servicesId = doc.id;
          break;
        }
      }

      if (dateMatches) {
        final docRef = presences.doc(userUid);
        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          CustomSnackBar.show(
              context: context,
              message: 'Anda sudah melakukan presensi hari ini.');
          controller!.resumeCamera();
        } else {
          docRef.set({
            'id_user': userUid,
            'services_id': servicesId,
            'date': Timestamp.fromDate(date),
          });
          _presenceDetail(context);
        }
      } else {
        CustomSnackBar.show(
            context: context,
            message:
                'Hari ini tidak ada kebaktian ya. Sampai jumpa minggu depan!');
        controller!.resumeCamera();
      }
    } on FirebaseException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null && result!.code == 'Kebaktian Pemuda') {
        controller.pauseCamera();
        try {
          await addPresence(DateTime.now());
        } catch (e) {
          setState(() {
            errorMessage = 'Error: $e';
          });
        }
      }
    });
  }

  Widget _buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(context, controller),
      overlay: QrScannerOverlayShape(
        borderColor: Colors.grey,
        borderWidth: 10,
      ),
    );
  }

  void _presenceDetail(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          width: screenWidth,
          height: screenHeight * 0.33,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal Kebaktian',
                style: kBS4.copyWith(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.0005),
              Text(
                'Hari, tanggal: ${DateFormat('EEEE', 'id').format(now)}, ${DateFormat.yMd('id').format(now)}',
                style: kBR5.copyWith(
                  color: kBlack,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.13,
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: kGreyishTeal.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KEBAKTIAN PEMUDA',
                          style: kBS5.copyWith(
                            color: kBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.014),
                        Text(
                          'Jam 08.00-10.00 WIB',
                          style: kBR6.copyWith(color: kBlack),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
              Container(
                width: screenWidth * 0.9,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
                decoration: BoxDecoration(
                  color: kCasal,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  'Lihat data kehadiran',
                  style: kBS6,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: _buildQRView(context),
              ),
            ],
          ),
          Positioned(
            top: 0,
            bottom: screenHeight * 0.7,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.46,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenWidth * 0.004),
                decoration: BoxDecoration(
                  color: kBlack,
                  borderRadius: BorderRadius.circular(19.5),
                ),
                child: Text(
                  'Scan pada QR Code yang telah diberikan',
                  style: kBM6.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
