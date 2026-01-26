import 'package:get/get.dart';

import '../data/models/upcoming_debt.dart';
import 'customers_controller.dart';
import 'debts_controller.dart';

class HomeController extends GetxController {
  final RxBool showAll = false.obs;

  late final DebtsController debtsController;
  late final CustomersController customersController;

  @override
  void onInit() {
    super.onInit();
    try {
      debtsController = Get.find<DebtsController>();
      customersController = Get.find<CustomersController>();
    } catch (e) {
      // Controllers غير موجودة - سيتم إنشاؤها لاحقاً
    }
  }

  void toggleShowAll() {
    showAll.toggle();
  }

  // حساب الإجماليات من الديون الفعلية
  int get totalDebts {
    try {
      return debtsController.debts.fold<int>(0, (sum, debt) => sum + debt.amount);
    } catch (e) {
      return 0;
    }
  }

  int get totalCollected {
    try {
      return debtsController.debts
          .where((debt) => debt.status == 'paid')
          .fold<int>(0, (sum, debt) => sum + debt.amount);
    } catch (e) {
      return 0;
    }
  }

  int get totalRemaining {
    try {
      return debtsController.debts
          .where((debt) => debt.status != 'paid')
          .fold<int>(0, (sum, debt) => sum + debt.amount);
    } catch (e) {
      return 0;
    }
  }

  // الحصول على الديون القادمة مرتبة حسب التاريخ
  List<UpcomingDebt> get upcomingDebts {
    try {
      final now = DateTime.now();
      final upcoming = <UpcomingDebt>[];

      for (final debt in debtsController.debts) {
        if (debt.status != 'paid' && debt.dueDate.isAfter(now)) {
          try {
            final customer = customersController.customers
                .firstWhere((c) => c.id == debt.customerId);
            upcoming.add(UpcomingDebt(
              name: customer.name,
              amount: debt.amount,
              dueDate: debt.dueDate,
            ));
          } catch (e) {
            // العميل غير موجود - تجاهل هذا الدين
            continue;
          }
        }
      }

      upcoming.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      return upcoming;
    } catch (e) {
      return [];
    }
  }

  List<UpcomingDebt> get displayDebts {
    final all = upcomingDebts;
    if (showAll.value) return all;
    return all.take(3).toList();
  }
}

