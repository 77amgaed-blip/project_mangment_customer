import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/controllers/language_controller.dart';
import '../core/controllers/theme_controller.dart';

class SettingsController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // قيم افتراضية (يجب حفظها في SharedPreferences لاحقاً)
  final RxString currentUsername = 'amgad'.obs;
  final RxString currentCurrency = 'ر.ي'.obs;

  late final LanguageController languageController;
  late final ThemeController themeController;

  @override
  void onInit() {
    super.onInit();
    usernameController.text = currentUsername.value;
    languageController = Get.find<LanguageController>();
    themeController = Get.find<ThemeController>();
  }

  void changeUsername() {
    final newUsername = usernameController.text.trim();
    if (newUsername.isEmpty) {
      Get.snackbar('error'.tr, 'enter_username'.tr);
      return;
    }
    currentUsername.value = newUsername;
    Get.snackbar('success'.tr, 'username_changed'.tr);
  }

  void changePassword() {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('error'.tr, 'fill_all_fields'.tr);
      return;
    }

    if (oldPassword != 'amgad') {
      Get.snackbar('error'.tr, 'wrong_current_password'.tr);
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('error'.tr, 'passwords_not_match'.tr);
      return;
    }

    Get.snackbar('success'.tr, 'password_changed'.tr);
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void changeCurrency(String currency) {
    currentCurrency.value = currency;
    Get.snackbar('success'.tr, '${'currency_changed'.tr} $currency');
  }

  void changeLanguage(String languageCode) {
    languageController.changeLanguage(languageCode);
  }

  void changeTheme(ThemeMode mode) {
    themeController.changeTheme(mode);
  }

  void backupData() {
    // TODO: تنفيذ النسخ الاحتياطي
    Get.snackbar('warning'.tr, 'backup_under_development'.tr);
  }

  @override
  void onClose() {
    usernameController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
