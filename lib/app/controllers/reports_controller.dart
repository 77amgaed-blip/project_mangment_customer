import 'package:get/get.dart';

import '../data/models/debt.dart';
import 'customers_controller.dart';
import 'debts_controller.dart';

class ReportsController extends GetxController {
  late final DebtsController debtsController;
  late final CustomersController customersController;

  @override
  void onInit() {
    super.onInit();
    debtsController = Get.find<DebtsController>();
    customersController = Get.find<CustomersController>();
  }

  // إجمالي الديون
  int get totalDebts {
    return debtsController.debts.fold<int>(0, (sum, debt) => sum + debt.amount);
  }

  // إجمالي المحصل
  int get totalCollected {
    return debtsController.debts
        .where((debt) => debt.status == 'paid')
        .fold<int>(0, (sum, debt) => sum + debt.amount);
  }

  // إجمالي المتبقي
  int get totalRemaining {
    return debtsController.debts
        .where((debt) => debt.status != 'paid')
        .fold<int>(0, (sum, debt) => sum + debt.amount);
  }

  // عدد العملاء
  int get totalCustomers => customersController.customers.length;

  // عدد الديون
  int get totalDebtsCount => debtsController.debts.length;

  // عدد الديون المسددة
  int get paidDebtsCount {
    return debtsController.debts.where((debt) => debt.status == 'paid').length;
  }

  // عدد الديون غير المسددة
  int get unpaidDebtsCount {
    return debtsController.debts.where((debt) => debt.status != 'paid').length;
  }

  // نسبة التحصيل
  double get collectionRate {
    if (totalDebts == 0) return 0.0;
    return (totalCollected / totalDebts) * 100;
  }

  // الديون حسب العميل
  Map<int, List<Debt>> get debtsByCustomer {
    final map = <int, List<Debt>>{};
    for (final debt in debtsController.debts) {
      map.putIfAbsent(debt.customerId, () => []).add(debt);
    }
    return map;
  }
}
