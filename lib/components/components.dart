import 'package:flutter/material.dart';
import 'package:pvvd_app/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.width,
    required this.height,
    this.buttonColor,
    this.textColor,
    this.isOutlined = false,
    this.isDisabled = false,
  });

  final String buttonText;
  final Function onPressed;
  final bool isOutlined;
  final double width;
  final double height;
  final Color? buttonColor;
  final Color? textColor;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          isDisabled ? null : onPressed();
        },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: isDisabled
                  ? kDisabledBtn.withOpacity(0.12)
                  : buttonColor ?? Colors.white,
              border: isOutlined ? Border.all(color: kSecondary) : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isDisabled
                  ? Text(
                      buttonText,
                      style: kH4.copyWith(
                        color: kDisabledBtn.withOpacity(0.38),
                      ),
                    )
                  : Text(
                      buttonText,
                      style: kH4.copyWith(
                        color: textColor ?? Colors.white,
                      ),
                    ),
            ),
          ),
        ));
  }
}
