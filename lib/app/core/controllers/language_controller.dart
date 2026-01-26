import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  final RxString currentLanguage = 'ar'.obs;

  @override
  void onInit() {
    super.onInit();
    // يمكن حفظ اللغة في SharedPreferences لاحقاً
    currentLanguage.value = 'ar';
  }

  void changeLanguage(String languageCode) {
    if (currentLanguage.value == languageCode) return;
    
    currentLanguage.value = languageCode;
    Get.updateLocale(Locale(languageCode));
    Get.snackbar(
      'success'.tr,
      'theme_changed'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  bool get isArabic => currentLanguage.value == 'ar';
  bool get isEnglish => currentLanguage.value == 'en';
}
