import 'package:get/get.dart';

import '../data/models/customer.dart';
import '../data/models/debt.dart';
import 'customers_controller.dart';
import 'debts_controller.dart';

class CollectionController extends GetxController {
  late final DebtsController debtsController;
  late final CustomersController customersController;

  @override
  void onInit() {
    super.onInit();
    debtsController = Get.find<DebtsController>();
    customersController = Get.find<CustomersController>();
  }

  // الحصول على جميع الديون غير المسددة
  List<Debt> get unpaidDebts {
    return debtsController.debts
        .where((debt) => debt.status != 'paid')
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

  // تحصيل دين
  void collectDebt(Debt debt) {
    debtsController.markPaid(debt.id);
    Get.snackbar('success'.tr, 'collection_success'.tr, snackPosition: SnackPosition.BOTTOM);
  }

  // الحصول على الديون المتأخرة
  List<Debt> get overdueDebts {
    final now = DateTime.now();
    return unpaidDebts.where((debt) => debt.dueDate.isBefore(now)).toList();
  }

  // الحصول على الديون القادمة
  List<Debt> get upcomingDebts {
    final now = DateTime.now();
    return unpaidDebts.where((debt) => debt.dueDate.isAfter(now)).toList();
  }

  int get totalUnpaid {
    return unpaidDebts.fold<int>(0, (sum, debt) => sum + debt.amount);
  }
}
