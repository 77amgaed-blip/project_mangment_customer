import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 171, 181, 185),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 78, 148, 115),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 78, 148, 115),
                        blurRadius: 10,
                        blurStyle: BlurStyle.solid,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(-5, -5),
                        spreadRadius: 3,
                        blurRadius: 7,
                      ),
                      BoxShadow(
                        color: Colors.red,
                        blurRadius: 7,
                        offset: Offset(5, 5),
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_person,
                    size: 50,
                    color: Color.fromARGB(214, 105, 88, 88),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'login'.tr,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 148, 115),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'enter_credentials'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 3),
                      ),
                      labelText: 'username'.tr,
                      suffixIcon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(214, 105, 88, 88),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.green, width: 3),
                        ),
                        filled: true,
                        labelText: 'password'.tr,
                        hintText: 'password'.tr,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color.fromARGB(214, 105, 88, 88),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color.fromARGB(255, 78, 148, 115),
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 148, 115),
                      foregroundColor:
                          const Color.fromARGB(255, 253, 251, 251),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 15,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.login, size: 22),
                        const SizedBox(width: 10),
                        Text(
                          'login_button'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

