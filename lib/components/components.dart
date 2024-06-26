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

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    super.key,
    required this.pageController,
    this.isDisabled = false,
  });

  final bool isDisabled;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isDisabled ? kSilverSand.withOpacity(0.12) : kSilverSand,
        border: Border.all(color: kGreyishTeal),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: isDisabled
            ? null
            : () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
        icon: const Icon(
          Icons.navigate_next,
        ),
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(16),
          foregroundColor: kGreyishTeal,
        ),
      ),
    );
  }
}

class BeforeButton extends StatelessWidget {
  const BeforeButton({
    super.key,
    required this.pageController,
    this.isDisabled = false,
  });

  final bool isDisabled;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isDisabled ? kSilverSand.withOpacity(0.12) : kSilverSand,
        border: Border.all(color: kGreyishTeal),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: isDisabled
            ? null
            : () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
        icon: const Icon(
          Icons.navigate_before,
        ),
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(16),
          foregroundColor: kGreyishTeal,
        ),
      ),
    );
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
    this.onTap,
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
  final void Function()? onTap;
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
            onTap: onTap,
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
              color: kWhite,
            ),
          ),
        ],
      ),
    );
  }
}

class AppPhoneFormField extends StatelessWidget {
  const AppPhoneFormField({
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
                  style: kBR3.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 81,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: kSilverSand,
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/indonesia_flag.png',
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      '+62',
                      style: TextStyle(color: kSilverSand),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextFormField(
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
                      borderSide: const BorderSide(
                        color: kSilverSand,
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
                    color: kWhite,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.fieldText,
    this.required,
  });

  final List<DropdownMenuItem<String>> items;
  final String value;
  final void Function(String) onChanged;
  final String fieldText;
  final bool? required;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.fieldText,
            style: kBS5.copyWith(
              color: kGreyishTeal,
            ),
            children: [
              TextSpan(
                text: widget.required == true ? ' *' : '',
                style: kBR5.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: kSilverSand,
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
            color: kWhite,
          ),
          dropdownColor: kCasal,
          value: widget.value,
          items: widget.items,
          onChanged: (String? newValue) {
            setState(() {
              widget.onChanged(newValue!);
            });
          },
        ),
      ],
    );
  }
}

class CustomSnackBar {
  static void show({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: kBR6,
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: kWhite,
          onPressed: () {},
        ),
      ),
    );
  }
}
