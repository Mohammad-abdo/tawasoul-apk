import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/core/classes/responsive_screen.dart';
import 'package:mobile_app/core/config/app_config.dart';
import 'package:mobile_app/core/constants/app_colors.dart';
import 'package:mobile_app/core/di.dart';
import 'package:mobile_app/core/storage/pref_services.dart';
import 'package:mobile_app/features/shared%20copy/resources/app_images.dart';
import 'package:mobile_app/features/shared%20copy/widgets/app_image.dart';
import 'package:mobile_app/features/splash%20copy/data/models/cases_enum.dart';
import 'package:mobile_app/features/splash%20copy/presentation/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController _logoController;
  late AnimationController _bubbleController;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _buttonFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.4, 0.9, curve: Curves.easeOut)),
    );

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _logoController.forward();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (!mounted) return;
    await _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    final prefs = PrefServices.instance;
    final onboardingCompleted =
        prefs.getData(key: AppConfig.keyOnboardingCompleted) ?? false;
    final isLoggedIn = prefs.getData(key: AppConfig.keyAuthToken) != null;
    final assessmentOnboardingCompleted =
        prefs.getData(key: AppConfig.keyAssessmentOnboardingCompleted) ?? false;
    if (!mounted) return;
    if (!onboardingCompleted) {
      context.go('/onboarding');
    } else if (!isLoggedIn) {
      context.go('/login');
    } else if (!assessmentOnboardingCompleted) {
      context.go('/assessment-onboarding/intro');
    } else {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScreen.initialize(context);
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..startApp(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            switch (state.flow) {
              case AppFlow.splash:
                break;
             
              case AppFlow.onboard:
                context.go("/onboarding");
                break;
              case AppFlow.login:
                context.go("/login");
                break;
              case AppFlow.home:
                context.go("/home");
                break;
            }
          }
          // ديالوج رفض صلاحية اللوكيشن — معطّل لأننا بنطلب اللوكيشن في اللوجن
          // if (state is SplashPermissionDenied) {
          //   _showPermissionDeniedDialog(context);
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Center(
                child: AppImage(
                  assetPath: AppImages.splash3,
                  width: ResponsiveScreen.width,
                  height: ResponsiveScreen.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
