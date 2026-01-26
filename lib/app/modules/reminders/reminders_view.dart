import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/reminders_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../data/models/debt.dart';
import '../../shared/utils/date_utils.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reminders'.tr),
        backgroundColor: const Color.fromARGB(255, 78, 148, 115),
      ),
      body: Obx(
        () {
          final overdueDebts = controller.getOverdueDebts();
          final upcoming7Days = controller.getUpcomingDebts(7);
          final upcoming30Days = controller.getUpcomingDebts(30);

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: const Color.fromARGB(255, 78, 148, 115),
                  tabs: [
                    Tab(text: 'overdue_reminders'.tr),
                    Tab(text: 'upcoming_7_days'.tr),
                    Tab(text: 'upcoming_30_days'.tr),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildDebtsList(overdueDebts, isOverdue: true),
                      _buildDebtsList(upcoming7Days, isOverdue: false),
                      _buildDebtsList(upcoming30Days, isOverdue: false),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDebtsList(List<Debt> debts, {required bool isOverdue}) {
    if (debts.isEmpty) {
      return Center(
        child: Text(
          isOverdue
              ? 'no_overdue_reminders'.tr
              : 'no_upcoming_reminders'.tr,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: debts.length,
      itemBuilder: (context, index) {
        final debt = debts[index];
        final customer = controller.getCustomerForDebt(debt);
        final daysLeft = isOverdue
            ? -controller.daysUntilDue(debt)
            : controller.daysUntilDue(debt);

        return Card(
          color: isOverdue
              ? const Color.fromARGB(255, 255, 200, 200)
              : const Color.fromARGB(255, 133, 184, 160),
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isOverdue ? Colors.red : Colors.orange,
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text(
              customer?.name ?? 'unknown_customer'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
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
                    return Text('${'debt_amount'.tr}: ${debt.amount} $currency');
                  },
                ),
                Text(
                  '${'due_date'.tr}: ${formatDate(debt.dueDate)}',
                  style: TextStyle(
                    color: isOverdue ? Colors.red : Colors.black87,
                    fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (isOverdue)
                  Text(
                    '${'days_overdue'.tr} $daysLeft ${'day'.tr}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    '${'days_remaining'.tr} $daysLeft ${'day'.tr}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            trailing: Icon(
              isOverdue ? Icons.warning : Icons.schedule,
              color: isOverdue ? Colors.red : Colors.orange,
            ),
          ),
        );
      },
    );
  }
}
