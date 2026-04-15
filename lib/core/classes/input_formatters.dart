import 'package:flutter/services.dart';

/// يمنع أن يكون أول رقم في حقل الهاتف صفراً.
class NoLeadingZeroPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    // أول رقم لا يكون صفر
    if (newValue.text.length == 1 && newValue.text == '0') {
      return oldValue;
    }
    // عند اللصق: إزالة الصفر من البداية فقط
    if (newValue.text.startsWith('0') && oldValue.text.isEmpty) {
      final trimmed = newValue.text.replaceFirst(RegExp('^0+'), '');
      if (trimmed.isEmpty) return oldValue;
      return TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }
    return newValue;
  }
}
