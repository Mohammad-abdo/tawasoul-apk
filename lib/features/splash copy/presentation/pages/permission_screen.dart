// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class PermissionIntroScreen extends StatefulWidget {
//   const PermissionIntroScreen({super.key});

//   @override
//   State<PermissionIntroScreen> createState() => _PermissionIntroScreenState();
// }

// class _PermissionIntroScreenState extends State<PermissionIntroScreen> {
//   bool _isFetchingLocation = false;

//   Future<void> _onAllowPressed() async {
//     setState(() => _isFetchingLocation = true);

//     final locationService = sl<LocationService>();
//     final granted = await locationService.requestPermission();

//     if (!granted) {
//       setState(() => _isFetchingLocation = false);
//       await locationService.openLocationSettings();
//       return;
//     }

//     await sl<LocationCubit>().getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LocationCubit, LocationState>(
//       listener: (context, state) {
//         if (!state.isLoading && state.currentLocation != null) {
//           Navigator.pushReplacementNamed(context, Routes.login);
//         }
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Center(
//             child: _isFetchingLocation
//                 ? Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const AppLoader(isCentered: true),
//                       SizedBox(height: 16.h),
//                       Text(
//                         tr.gettingYourLocation,
//                         style: AppTextStyle.textStyle(
//                           appFontSize: 18.sp,
//                           color: AppColors.blackColorApp,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   )
//                 : Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24.w),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.location_on_outlined,
//                           size: 80.sp,
//                           color: AppColors.primaryColor,
//                         ),
//                         SizedBox(height: 24.h),
//                         Text(
//                           tr.weNeedYourLocation,
//                           style: AppTextStyle.textStyle(
//                             appFontSize: 16.sp,
//                             color: AppColors.blackColorApp,
//                             appFontWeight: FontWeight.w500,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 32.h),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: _onAllowPressed,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primaryColor,
//                               foregroundColor: AppColors.whiteColor,
//                               padding: EdgeInsets.symmetric(vertical: 14.h),
//                             ),
//                             child: Text(tr.allowLocation),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
