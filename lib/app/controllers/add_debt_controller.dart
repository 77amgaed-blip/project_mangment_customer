import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/debt.dart';

class AddDebtController extends GetxController {
  final int customerId;

  AddDebtController({required this.customerId});

  final TextEditingController amountController = TextEditingController();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();

  Future<void> pickDate() async {
    final context = Get.context;
    if (context == null) return;

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      selectedDate.value = date;
    }
  }

  void saveDebt() {
    final amount = int.tryParse(amountController.text.trim());
    final dueDate = selectedDate.value;

    if (amount == null || dueDate == null) {
      Get.snackbar('warning'.tr, 'fill_debt_fields'.tr);
      return;
    }

    final debt = Debt(
      id: DateTime.now().millisecondsSinceEpoch,
      customerId: customerId,
      amount: amount,
      dueDate: dueDate,
      status: 'active',
    );

    Get.back(result: debt);
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}

