import 'package:flutter/material.dart';
import 'package:pvvd_app/utils/constants.dart';

class DetailButton extends StatelessWidget {
  const DetailButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
  });

  final Function onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: kGreyishTeal,
              border: Border.all(color: kGunmetal),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Detail',
                style: kBS7.copyWith(
                  color: kGunmetal,
                ),
              ),
            ),
          ),
        ));
  }
}
