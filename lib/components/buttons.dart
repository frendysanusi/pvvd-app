import 'package:flutter/material.dart';
import 'package:pvvd_app/utils/constants.dart';

class PresenceButton extends StatelessWidget {
  const PresenceButton({
    super.key,
    required this.buttonText,
    required this.width,
    required this.height,
  });

  final String buttonText;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    bool isPresence = buttonText == 'Hadir';
    return GestureDetector(
        child: Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isPresence
              ? const Color(0xFF588157).withOpacity(0.6)
              : const Color(0xFFEF5680).withOpacity(0.6),
          border: isPresence
              ? Border.all(color: const Color(0xFF3A5A40))
              : Border.all(color: const Color(0xFF9C162E)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: kBS8.copyWith(
              color: isPresence
                  ? const Color(0xFF3A5A40)
                  : const Color(0xFF9C162E),
            ),
          ),
        ),
      ),
    ));
  }
}

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
              color: Colors.transparent,
              border: Border.all(color: kGunmetal),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Detail',
                style: kBS8.copyWith(
                  color: kGunmetal,
                ),
              ),
            ),
          ),
        ));
  }
}
