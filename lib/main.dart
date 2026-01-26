import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/core/controllers/language_controller.dart';
import 'app/core/controllers/theme_controller.dart';
import 'app/core/translations/app_translations.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة Controllers للغة والثيم
    final languageController = Get.put(LanguageController());
    final themeController = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_name'.tr,
        // الترجمة
        translations: AppTranslations(),
        locale: Locale(languageController.currentLanguage.value),
        fallbackLocale: const Locale('ar'),
        // الثيم
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: const Color.fromARGB(255, 78, 148, 115),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: const Color.fromARGB(255, 78, 148, 115),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        themeMode: themeController.themeMode.value,
        // Routes
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
        initialBinding: InitialBinding(),
        unknownRoute: AppPages.unknownRoute,
      ),
    );
  }
}
