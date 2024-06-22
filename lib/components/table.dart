import 'package:flutter/material.dart';
import 'package:pvvd_app/utils/constants.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.text,
    this.type = 'cell',
  });

  final String text;
  final String type;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      padding: type == 'cell'
          ? EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01)
          : EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
      child: Text(
        text,
        style: type == 'cell'
            ? kBR7.copyWith(
                color: kBlack,
              )
            : kBS6.copyWith(
                color: kBlack,
              ),
      ),
    );
  }
}
