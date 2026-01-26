import 'package:get/get.dart';

import '../bindings/initial_binding.dart';
import '../controllers/add_debt_controller.dart';
import '../controllers/collection_controller.dart';
import '../controllers/customer_details_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/reports_controller.dart';
import '../controllers/reminders_controller.dart';
import '../controllers/settings_controller.dart';
import '../data/models/customer.dart';
import '../modules/collection/collection_view.dart';
import '../modules/customers/customer_details_view.dart';
import '../modules/customers/customers_view.dart';
import '../modules/debts/add_debt_view.dart';
import '../modules/debts/debts_view.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_view.dart';
import '../modules/reports/reports_view.dart';
import '../modules/reminders/reminders_view.dart';
import '../modules/settings/settings_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;

  static final pages = <GetPage>[
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: Routes.customers,
      page: () => const CustomersView(),
    ),
    GetPage(
      name: Routes.customerDetails,
      page: () => const CustomerDetailsView(),
      binding: BindingsBuilder(() {
        final customer = Get.arguments as Customer;
        Get.lazyPut<CustomerDetailsController>(
          () => CustomerDetailsController(customer: customer),
        );
      }),
    ),
    GetPage(
      name: Routes.addDebt,
      page: () => const AddDebtView(),
      binding: BindingsBuilder(() {
        final customerId = Get.arguments as int;
        Get.lazyPut<AddDebtController>(
          () => AddDebtController(customerId: customerId),
        );
      }),
    ),
    GetPage(
      name: Routes.debts,
      page: () => const DebtsView(),
    ),
    GetPage(
      name: Routes.collection,
      page: () => const CollectionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CollectionController>(() => CollectionController());
      }),
    ),
    GetPage(
      name: Routes.reports,
      page: () => const ReportsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ReportsController>(() => ReportsController());
      }),
    ),
    GetPage(
      name: Routes.reminders,
      page: () => const RemindersView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RemindersController>(() => RemindersController());
      }),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
    ),
  ];

  static final unknownRoute = GetPage(
    name: '/not-found',
    page: () => const HomeView(),
    binding: InitialBinding(),
  );
}

