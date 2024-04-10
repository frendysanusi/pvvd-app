import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* Font Weight */
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w500;
const bold = FontWeight.w700;

/* Custom Font */
TextStyle kBodyMedium = GoogleFonts.montserrat().copyWith(
  fontWeight: medium,
);

/* Color */
const Color kPrimary = Color(0xFF295D61);
const Color kSecondary = Color(0xFF7C9A92);
const Color kDisabledBtn = Color(0xFF1D1B20);

/* Font Size */
// Heading
TextStyle kH1 = kBodyMedium.copyWith(
  fontSize: 64,
);
TextStyle kH2 = kBodyMedium.copyWith(
  fontSize: 48,
);
TextStyle kH3 = kBodyMedium.copyWith(
  fontSize: 32,
);
TextStyle kH4 = kBodyMedium.copyWith(
  fontSize: 24,
);
TextStyle kH5 = kBodyMedium.copyWith(
  fontSize: 20,
);
TextStyle kH6 = kBodyMedium.copyWith(
  fontSize: 16,
);
TextStyle kH7 = kBodyMedium.copyWith(
  fontSize: 14,
);
