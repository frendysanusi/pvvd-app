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
              border: isOutlined ? Border.all(color: kGreyishTeal) : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isDisabled
                  ? Text(
                      buttonText,
                      style: kBM2.copyWith(
                        color: kDisabledBtn.withOpacity(0.38),
                      ),
                    )
                  : Text(
                      buttonText,
                      style: kBM2.copyWith(
                        color: textColor ?? Colors.white,
                      ),
                    ),
            ),
          ),
        ));
  }
}

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.fieldText,
    required this.labelText,
    required this.controller,
    required this.textInputAction,
    required this.textInputType,
    this.required,
    this.obscureText,
    this.suffixIcon,
    this.focusNode,
    this.autofocus,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.borderColor,
  });

  final String fieldText;
  final String labelText;
  final bool? required;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: fieldText,
              style: kBS5.copyWith(
                color: kGreyishTeal,
              ),
              children: [
                TextSpan(
                  text: required == true ? ' *' : '',
                  style: kBR5.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: textInputType,
            onChanged: onChanged,
            autofocus: autofocus ?? false,
            validator: validator,
            obscureText: obscureText ?? false,
            obscuringCharacter: '*',
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: labelText,
              hintStyle: kBR5.copyWith(
                color: kSilverSand,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: borderColor ?? kSilverSand,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: kGreyishTeal,
                  width: 1.2,
                ),
              ),
            ),
            style: kBR5.copyWith(
              color: kSilverSand,
            ),
          ),
        ],
      ),
    );
  }
}
