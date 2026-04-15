// import 'package:offer_go_captain/core/functions/translate.dart';

// class Validations {
//   static String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return tr.emailRequired;
//     }

//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//     if (!emailRegex.hasMatch(value.trim())) {
//       return tr.emailInvalid;
//     }

//     return null;
//   }

//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return tr.passwordRequired;
//     }

//     if (value.length < 8) {
//       return tr.passwordMinLength;
//     }

//     return null;
//   }

//   static String? validateStrongPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return tr.passwordRequired;
//     }

//     if (value.length < 8) {
//       return tr.passwordMinLength;
//     }

//     if (!RegExp(r'[A-Z]').hasMatch(value)) {
//       return tr.mustContainUppercase;
//     }

//     if (!RegExp(r'[a-z]').hasMatch(value)) {
//       return tr.mustContainLowercase;
//     }

//     if (!RegExp(r'[0-9]').hasMatch(value)) {
//       return tr.mustContainNumber;
//     }

//     if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
//       return tr.mustContainSpecialChar;
//     }

//     return null;
//   }

//   static String? validatePhone(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return tr.phoneRequired;
//     }

//     final phoneRegex = RegExp(r'^[0-9]{10,15}$');

//     if (!phoneRegex.hasMatch(value.trim())) {
//       return tr.phoneInvalid;
//     }

//     return null;
//   }

//   static String? validateInternationalPhone(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return tr.phoneRequired;
//     }

//     final phoneRegex = RegExp(r'^\+[1-9][0-9]{7,14}$');

//     if (!phoneRegex.hasMatch(value.trim())) {
//       return tr.phoneInvalid;
//     }

//     return null;
//   }

//   static String? validateText(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return tr.fieldRequired;
//     }

//     if (value.trim().length < 3) {
//       return tr.minThreeChars;
//     }

//     return null;
//   }

//   static String? validateNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return tr.valueRequired;
//     }

//     final number = int.tryParse(value);
//     if (number == null) {
//       return tr.mustBeNumber;
//     }

//     return null;
//   }

//   static String? validateDate(DateTime? date) {
//     if (date == null) {
//       return tr.selectDate;
//     }

//     if (date.isAfter(DateTime.now())) {
//       return tr.dateInvalid;
//     }

//     return null;
//   }

//   static String? validateSelection(dynamic value) {
//     if (value == null) {
//       return tr.selectValue;
//     }
//     return null;
//   }

//  static String? validateConfirmPassword(String? value, String password) {
//     if (value == null || value.isEmpty) {
//       return tr.confirmPasswordRequired;
//     }

//     if (value != password) {
//       return tr.passwordsNotMatch;
//     }

//     return null;
//   }

//   static String? validateUrl(String? value) {
//     if (value == null || value.isEmpty) {
//       return tr.urlRequired;
//     }

//     final uri = Uri.tryParse(value);
//     if (uri == null || !uri.isAbsolute) {
//       return tr.urlInvalid;
//     }

//     return null;
//   }

//   static String? validateId(String? value) {
//     if (value == null || value.isEmpty) {
//       return tr.numberRequired;
//     }

//     if (value.length != 14) {
//       return tr.numberInvalid;
//     }

//     return null;
//   }

//   static String? validateCardNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return tr.cardNumberRequired;
//     }

//     if (value.length < 16) {
//       return tr.cardNumberInvalid;
//     }

//     return null;
//   }

//   static String? validateOtp(String? value,int countCode) {
//     if (value == null || value.isEmpty) {
//       return tr.codeRequired;
//     }

//     if (value.length != countCode) {
//       return tr.codeInvalid;
//     }

//     return null;
//   }

//   static String? validateTerms(bool accepted) {
//     if (!accepted) {
//       return tr.mustAcceptTerms;
//     }
//     return null;
//   }
// }
