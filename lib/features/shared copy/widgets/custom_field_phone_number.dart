import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/core/classes/text_style.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_colors.dart';
import 'package:mobile_app/features/shared%20copy/widgets/app_image.dart';
import 'package:mobile_app/features/shared%20copy/widgets/give_space.dart';
import 'package:mobile_app/features/shared%20copy/widgets/textformfield.dart';

class CustomFieldPhoneNumber extends StatelessWidget {
  final ValueChanged<String> valueChanged;
  final String image;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool isEditProfile;
  final void Function(CountryCode)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFieldPhoneNumber({
    super.key,
    required this.valueChanged,
    this.image = '',
    this.hintText,
    this.labelText,
    this.controller,
    this.isEditProfile = false,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: ColorResources.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              width: 1.5.w,
              color: ColorResources.borderTextForm,
            ),
          ),
          child: CountryCodePicker(
            onChanged: onChanged,
            builder: (countryCode) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImage(
                    assetPath: countryCode!.flagUri!,
                    assetPackage: 'country_code_picker',
                    width: 24.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                  GiveSpace(width: 5),
                  Text(
                    "$countryCode",
                    style: AppTextStyle.textStyle(
                      appFontSize: 12.sp,
                      appFontWeight: FontWeight.w400,
                      color: ColorResources.blackColor.withValues(
                        alpha: 0.50,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, size: 24.sp),
                ],
              );
            },
            // dialogBackgroundColor: Colors.white,
            // // 👇 ده أهم جزء
            // dialogTextStyle: Theme.of(context).textTheme.bodyMedium,
          
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: '+20',
            favorite: const ['+20', '+966'],
            // optional. Shows only country name and flag
            showCountryOnly: true,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
            // countryFilter: const ['+20', '+966'],
            hideSearch: false,
            textStyle: AppTextStyle.textStyle(
              appFontSize: 14.sp,
              color: ColorResources.greyDark,
              appFontWeight: FontWeight.w500,
            ),
            dialogSize: const Size(80, 500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomTextFormField(
            //obscureText: true,
            hintText: hintText,
            labelText: labelText,
            //validator: Validations.validatePhone,
            keyboardType: TextInputType.phone,
            onChanged: (val) {
              valueChanged(val);
            },
            image: image,
            controller: controller,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
