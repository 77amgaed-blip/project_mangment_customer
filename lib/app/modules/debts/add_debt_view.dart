import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/add_debt_controller.dart';
import '../../shared/utils/date_utils.dart';

class AddDebtView extends GetView<AddDebtController> {
  const AddDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add_debt_title'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'debt_amount'.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () {
                final selected = controller.selectedDate.value;
                return ListTile(
                  title: Text(
                    selected == null
                        ? 'select_due_date'.tr
                        : '${'due_date'.tr}: ${formatDate(selected)}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: controller.pickDate,
                );
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.saveDebt,
              child: Text('save'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

