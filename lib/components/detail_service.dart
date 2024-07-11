import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pvvd_app/utils/constants.dart';
import 'package:pvvd_app/utils/services.dart';

Widget buildDetailService(BuildContext context, Services service) {
  double screenHeight = MediaQuery.of(context).size.height;
  return AlertDialog(
    content: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.04 * screenHeight),
            detailInfo('Pemimpin Kebaktian', service.leader, screenHeight),
            detailInfo('Penerjemah', service.translator, screenHeight),
            detailInfo(
                'Tanggal & Jam Kebaktian',
                '${DateFormat.yMMMMd('id').format(service.date)}, ${DateFormat.jm('id').format(service.date)} WIB',
                screenHeight),
            detailInfo('Pembicara', service.speaker, screenHeight),
            detailInfo('Topik', service.topic, screenHeight, true),
          ],
        ),
        Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close_rounded, color: kBlack),
            ))
      ],
    ),
  );
}

Widget detailInfo(String title, String content, double screenHeight,
    [bool last = false]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: kBB4.copyWith(color: kBlack),
      ),
      Text(
        content,
        style: kBR6.copyWith(color: kBlack),
      ),
      !last ? SizedBox(height: 0.03 * screenHeight) : const SizedBox(height: 0),
    ],
  );
}
