import 'package:get/get.dart';

import '../data/models/customer.dart';
import '../data/models/debt.dart';
import 'customers_controller.dart';
import 'debts_controller.dart';

class RemindersController extends GetxController {
  late final DebtsController debtsController;
  late final CustomersController customersController;

  @override
  void onInit() {
    super.onInit();
    debtsController = Get.find<DebtsController>();
    customersController = Get.find<CustomersController>();
  }

  // الحصول على الديون التي تستحق خلال الأيام القادمة
  List<Debt> getUpcomingDebts(int daysAhead) {
    final now = DateTime.now();
    final targetDate = now.add(Duration(days: daysAhead));
    return debtsController.debts
        .where((debt) =>
            debt.status != 'paid' &&
            debt.dueDate.isAfter(now) &&
            debt.dueDate.isBefore(targetDate))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  // الحصول على الديون المتأخرة
  List<Debt> getOverdueDebts() {
    final now = DateTime.now();
    return debtsController.debts
        .where((debt) => debt.status != 'paid' && debt.dueDate.isBefore(now))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  // الحصول على معلومات العميل للدين
  Customer? getCustomerForDebt(Debt debt) {
    try {
      return customersController.customers
          .firstWhere((c) => c.id == debt.customerId);
    } catch (e) {
      return null;
    }
  }

  // حساب الأيام المتبقية حتى الاستحقاق
  int daysUntilDue(Debt debt) {
    final now = DateTime.now();
    return debt.dueDate.difference(now).inDays;
  }
}
