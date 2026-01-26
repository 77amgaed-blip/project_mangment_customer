import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    // يمكن حفظ الثيم في SharedPreferences لاحقاً
    themeMode.value = ThemeMode.light;
  }

  void changeTheme(ThemeMode mode) {
    if (themeMode.value == mode) return;
    
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    Get.snackbar(
      'success'.tr,
      'theme_changed'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      changeTheme(ThemeMode.dark);
    } else {
      changeTheme(ThemeMode.light);
    }
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
  bool get isLightMode => themeMode.value == ThemeMode.light;
}
