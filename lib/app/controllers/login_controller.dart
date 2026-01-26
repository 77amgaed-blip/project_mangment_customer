import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class LoginController extends GetxController {
  static const String _defaultUsername = 'amgad';
  static const String _defaultPassword = 'amgad';

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void login() {
    final enteredUsername = usernameController.text.trim();
    final enteredPassword = passwordController.text.trim();

    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      Get.snackbar('warning'.tr, 'fill_all_fields'.tr);
      return;
    }

    if (enteredUsername == _defaultUsername &&
        enteredPassword == _defaultPassword) {
      Get.offAllNamed(Routes.home);
      return;
    }

    Get.snackbar('error'.tr, 'invalid_credentials'.tr);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

