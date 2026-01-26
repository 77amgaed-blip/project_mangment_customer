import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        backgroundColor: const Color.fromARGB(255, 78, 148, 115),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // تغيير اسم المستخدم
          _buildSection(
            'change_username'.tr,
            Icons.person,
            [
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'new_username'.tr,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.changeUsername,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 148, 115),
                  foregroundColor: Colors.white,
                ),
                child: Text('save'.tr),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // تغيير كلمة المرور
          _buildSection(
            'change_password'.tr,
            Icons.lock,
            [
              TextField(
                controller: controller.oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'current_password'.tr,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'new_password'.tr,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'confirm_password'.tr,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 148, 115),
                  foregroundColor: Colors.white,
                ),
                child: Text('save'.tr),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // العملة
          _buildSection(
            'currency'.tr,
            Icons.attach_money,
            [
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.currentCurrency.value,
                  decoration: InputDecoration(
                    labelText: 'select_currency'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'ر.ي', child: Text('ريال يمني')),
                    DropdownMenuItem(value: 'ر.س', child: Text('ريال سعودي')),
                    DropdownMenuItem(value: 'د.أ', child: Text('دولار أمريكي')),
                    DropdownMenuItem(value: 'د.إ', child: Text('درهم إماراتي')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.changeCurrency(value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // اللغة
          _buildSection(
            'language'.tr,
            Icons.language,
            [
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.languageController.currentLanguage.value,
                  decoration: InputDecoration(
                    labelText: 'select_language'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'ar', child: Text('العربية')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.changeLanguage(value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // المظهر
          _buildSection(
            'theme'.tr,
            Icons.brightness_6,
            [
              Obx(
                () => DropdownButtonFormField<ThemeMode>(
                  value: controller.themeController.themeMode.value,
                  decoration: InputDecoration(
                    labelText: 'select_theme'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('light_mode'.tr),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('dark_mode'.tr),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('system'.tr),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.changeTheme(value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // النسخ الاحتياطي
          _buildSection(
            'backup'.tr,
            Icons.backup,
            [
              ElevatedButton.icon(
                onPressed: controller.backupData,
                icon: const Icon(Icons.cloud_upload),
                label: Text('backup_data'.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 148, 115),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color.fromARGB(255, 78, 148, 115)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
