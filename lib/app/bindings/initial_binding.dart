import 'package:get/get.dart';

import '../controllers/customers_controller.dart';
import '../controllers/debts_controller.dart';
import '../core/controllers/language_controller.dart';
import '../core/controllers/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Shared/global controllers (state across the app)
    Get.put<CustomersController>(CustomersController(), permanent: true);
    Get.put<DebtsController>(DebtsController(), permanent: true);
    Get.put<LanguageController>(LanguageController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}

