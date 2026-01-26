import 'package:get/get.dart';

import '../data/models/debt.dart';

class DebtsController extends GetxController {
  final RxList<Debt> debts = <Debt>[
    Debt(
      id: 1,
      customerId: 1,
      amount: 5000,
      dueDate: DateTime(2026, 1, 10),
      status: 'active',
    ),
    Debt(
      id: 2,
      customerId: 1,
      amount: 2000,
      dueDate: DateTime(2026, 1, 5),
      status: 'late',
    ),
  ].obs;

  List<Debt> debtsForCustomer(int customerId) {
    final list = debts.where((d) => d.customerId == customerId).toList();
    list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return list;
  }

  int totalCollectedForCustomer(int customerId) {
    return debts
        .where((d) => d.customerId == customerId && d.status == 'paid')
        .fold<int>(0, (sum, d) => sum + d.amount);
  }

  int totalRemainingForCustomer(int customerId) {
    return debts
        .where((d) => d.customerId == customerId && d.status != 'paid')
        .fold<int>(0, (sum, d) => sum + d.amount);
  }

  void addDebt(Debt debt) {
    debts.add(debt);
  }

  void markPaid(int debtId) {
    final index = debts.indexWhere((d) => d.id == debtId);
    if (index == -1) return;
    debts[index] = debts[index].copyWith(status: 'paid');
  }
}

