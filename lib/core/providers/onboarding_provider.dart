import 'package:flutter/foundation.dart';

class OnboardingSlide {
  final String imageUrl;
  final String title;
  final String description;
  
  OnboardingSlide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

/// Onboarding uses local default slides only (API connection disabled).
class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider();
  
  List<OnboardingSlide> _slides = [];
  int _currentIndex = 0;
  bool _isLoading = false;
  
  List<OnboardingSlide> get slides => _slides;
  int get currentIndex => _currentIndex;
  bool get isLoading => _isLoading;
  
  Future<void> loadOnboardingSlides({String? language}) async {
    _isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _slides = _getDefaultSlides();
    _isLoading = false;
    notifyListeners();
  }
  
  List<OnboardingSlide> _getDefaultSlides() {
    return [
      OnboardingSlide(
        imageUrl: 'https://images.unsplash.com/photo-1596464716127-f2a82984de30?w=800',
        title: 'مرحباً بك في تواصل',
        description: 'منصة متخصصة لمساعدة الأطفال ذوي الاحتياجات الخاصة في تطوير مهارات التواصل',
      ),
      OnboardingSlide(
        imageUrl: 'https://images.unsplash.com/photo-1587652991060-d46142981d4a?w=800',
        title: 'استشارات متخصصة',
        description: 'احصل على استشارات وجلسات فيديو مباشرة مع أفضل المتخصصين المعتمدين',
      ),
      OnboardingSlide(
        imageUrl: 'https://images.unsplash.com/photo-1484820540004-14229fe36ca4?w=800',
        title: 'ابدأ رحلتك معنا',
        description: 'سجل الآن وتابع تطور طفلك من خلال تقارير دورية واختبارات تقييمية ذكية',
      ),
    ];
  }
  
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}


