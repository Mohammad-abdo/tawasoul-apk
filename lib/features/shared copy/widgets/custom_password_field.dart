import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_colors.dart';
import 'package:mobile_app/features/shared%20copy/widgets/textformfield.dart';
/// حقل باسورد مع أيقونة إظهار/إخفاء (العين).
class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.obscuringCharacter = '*',
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscure,
      obscuringCharacter: widget.obscuringCharacter,
      suffixIconWidget: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: ColorResources.black300,
          size: 24.r,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
