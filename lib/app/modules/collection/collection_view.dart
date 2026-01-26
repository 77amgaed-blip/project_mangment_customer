import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/collection_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../data/models/debt.dart';
import '../../shared/utils/date_utils.dart';

class CollectionView extends GetView<CollectionController> {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('collection_title'.tr),
        backgroundColor: const Color.fromARGB(255, 78, 148, 115),
      ),
      body: Obx(
        () {
          final unpaidDebts = controller.unpaidDebts;
          final overdueDebts = controller.overdueDebts;
          final upcomingDebts = controller.upcomingDebts;

          if (unpaidDebts.isEmpty) {
            return Center(
              child: Text('no_debts_to_collect'.tr),
            );
          }

          return Column(
            children: [
              // ملخص سريع
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 148, 115),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _summaryItem('total_unpaid'.tr, controller.totalUnpaid, Colors.white),
                    _summaryItem('overdue'.tr, overdueDebts.length, Colors.red),
                    _summaryItem('upcoming'.tr, upcomingDebts.length, Colors.orange),
                  ],
                ),
              ),
              // التبويبات
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                    TabBar(
                      labelColor: const Color.fromARGB(255, 78, 148, 115),
                      tabs: [
                        Tab(text: 'overdue'.tr),
                        Tab(text: 'upcoming'.tr),
                      ],
                    ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildDebtsList(overdueDebts, isOverdue: true),
                            _buildDebtsList(upcomingDebts, isOverdue: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _summaryItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDebtsList(List<Debt> debts, {required bool isOverdue}) {
    if (debts.isEmpty) {
      return Center(
        child: Text(
          isOverdue ? 'no_overdue_debts'.tr : 'no_upcoming_debts_list'.tr,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: debts.length,
      itemBuilder: (context, index) {
        final debt = debts[index];
        final customer = controller.getCustomerForDebt(debt);

        return Card(
          color: isOverdue
              ? const Color.fromARGB(255, 255, 200, 200)
              : const Color.fromARGB(255, 133, 184, 160),
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isOverdue ? Colors.red : Colors.orange,
              child: const Icon(Icons.person, color: Colors.white),
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
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () => _confirmCollection(debt),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 148, 115),
                foregroundColor: Colors.white,
              ),
              child: Text('collect'.tr),
            ),
          ),
        );
      },
    );
  }

  void _confirmCollection(Debt debt) {
    final customer = controller.getCustomerForDebt(debt);
    Get.dialog(
      AlertDialog(
        title: Text('confirm_collection'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'customer'.tr}: ${customer?.name ?? 'unknown_customer'.tr}'),
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
            Text('${'due_date'.tr}: ${formatDate(debt.dueDate)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              controller.collectDebt(debt);
              Get.back();
            },
            child: Text('confirm_collection'.tr),
          ),
        ],
      ),
    );
  }
}
