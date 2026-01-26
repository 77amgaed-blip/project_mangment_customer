import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customer_details_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../data/models/debt.dart';
import '../../routes/app_routes.dart';
import '../../shared/utils/date_utils.dart';

class CustomerDetailsView extends GetView<CustomerDetailsController> {
  const CustomerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${'customer_details'.tr} ${controller.customer.name}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result =
              await Get.toNamed(Routes.addDebt, arguments: controller.customer.id);
          if (result is Debt) {
            controller.debtsController.addDebt(result);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            // touch RxList so Obx rebuilds
            controller.debtsController.debts.length;

            final customerDebts = controller.customerDebts;
            final totalCollected = controller.totalCollected;
            final totalRemaining = controller.totalRemaining;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    String currency = 'ر.ي';
                    try {
                      currency = Get.find<SettingsController>().currentCurrency.value;
                    } catch (e) {
                      // استخدام القيمة الافتراضية
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'total_debts'.tr}: ${totalCollected + totalRemaining} $currency',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${'total_collected'.tr}: $totalCollected $currency',
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text(
                          '${'total_remaining'.tr}: $totalRemaining $currency',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: customerDebts.isEmpty
                      ? Center(child: Text('no_debts'.tr))
                      : ListView.builder(
                          itemCount: customerDebts.length,
                          itemBuilder: (context, index) {
                            final debt = customerDebts[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Builder(
                                  builder: (context) {
                                    String currency = 'ر.ي';
                                    try {
                                      currency = Get.find<SettingsController>().currentCurrency.value;
                                    } catch (e) {
                                      // استخدام القيمة الافتراضية
                                    }
                                    return Text('${'debt_amount'.tr}: ${debt.amount} $currency');
                                  },
                                ),
                                subtitle: Text(
                                  '${'due_date'.tr}: ${formatDate(debt.dueDate)}',
                                ),
                                trailing: Wrap(
                                  direction: Axis.vertical,
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(
                                      _statusText(debt.status),
                                      style: TextStyle(
                                        color: _statusColor(debt.status),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (debt.status != 'paid')
                                      InkWell(
                                        onTap: () =>
                                            controller.confirmPayment(debt),
                                        child: Text(
                                          'collect'.tr,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _statusText(String status) {
    switch (status) {
      case 'paid':
        return 'مسدد';
      case 'late':
        return 'متأخر';
      default:
        return 'نشط';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'late':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}

