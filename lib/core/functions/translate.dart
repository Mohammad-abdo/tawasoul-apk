// import 'package:flutter/material.dart';

// extension AppLocalization on BuildContext {
//   /// اسم اللغة الحالية من الـ locale بدون الاعتماد على LanguageCubit.
//   String getCurrentLanguageName() {
//     final locale = View.of(this).platformDispatcher.locale;
//     switch (locale.languageCode) {
//       case 'ar':
//         return tr.arabic;
//       case 'en':
//         return tr.english;
//       default:
//         return tr.arabic;
//     }
//   }
// }

// // Keep the global tr for backward compatibility, but it's better to use context.tr
// S get tr {
//   return S.of(navigatorKey.currentContext!);
// }

// /// Resolves a translation key string to the translated value (e.g. for wallet transaction labels).
// extension TrValue on String {
//   String get trValue {
//     try {
//       final s = tr;
//       switch (this) {
//         case 'tripNumberPlaceholder':
//           return s.tripNumberPlaceholder;
//         case 'todayAt230PM':
//           return s.todayAt230PM;
//         case 'minus45Riyal':
//           return s.minus45Riyal;
//         case 'walletCharge':
//           return s.walletCharge;
//         case 'yesterdayAt515PM':
//           return s.yesterdayAt515PM;
//         case 'plus200Riyal':
//           return s.plus200Riyal;
//         default:
//           return this;
//       }
//     } catch (_) {
//       return this;
//     }
//   }
// }
