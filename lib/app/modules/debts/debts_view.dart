import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customers_controller.dart';
import '../../controllers/debts_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../data/models/customer.dart';
import '../../data/models/debt.dart';
import '../../routes/app_routes.dart';
import '../../shared/utils/date_utils.dart';

class DebtsView extends StatelessWidget {
  const DebtsView({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final debtsController = Get.find<DebtsController>();
      final customersController = Get.find<CustomersController>();

      return Scaffold(
        appBar: AppBar(
          title: Text('debts'.tr),
          backgroundColor: const Color.fromARGB(255, 78, 148, 115),
        ),
        body: Obx(
          () {
            final debts = debtsController.debts;
            if (debts.isEmpty) {
              return Center(
                child: Text('no_debts'.tr),
              );
            }

            // تصنيف الديون
            final activeDebts = debts.where((d) => d.status == 'active').toList();
            final lateDebts = debts.where((d) => d.status == 'late').toList();
            final paidDebts = debts.where((d) => d.status == 'paid').toList();

            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: const Color.fromARGB(255, 78, 148, 115),
                    tabs: [
                      Tab(text: 'debt_status_active'.tr),
                      Tab(text: 'debt_status_late'.tr),
                      Tab(text: 'debt_status_paid'.tr),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildDebtsList(activeDebts, customersController),
                        _buildDebtsList(lateDebts, customersController),
                        _buildDebtsList(paidDebts, customersController),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } catch (e) {
      return Scaffold(
        appBar: AppBar(
          title: Text('debts'.tr),
          backgroundColor: const Color.fromARGB(255, 78, 148, 115),
        ),
        body: Center(
          child: Text('error_loading'.tr),
        ),
      );
    }
  }

  Widget _buildDebtsList(
    List<Debt> debts,
    CustomersController customersController,
  ) {
    if (debts.isEmpty) {
      return Center(
        child: Text('no_debts'.tr),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: debts.length,
      itemBuilder: (context, index) {
        final debt = debts[index];
        Customer? customer;
        try {
          customer = customersController.customers
              .firstWhere((c) => c.id == debt.customerId);
        } catch (e) {
          customer = null;
        }

        Color cardColor;
        Color statusColor;
        switch (debt.status) {
          case 'paid':
            cardColor = const Color.fromARGB(255, 200, 255, 200);
            statusColor = Colors.green;
            break;
          case 'late':
            cardColor = const Color.fromARGB(255, 255, 200, 200);
            statusColor = Colors.red;
            break;
          default:
            cardColor = const Color.fromARGB(255, 133, 184, 160);
            statusColor = Colors.orange;
        }

        return Card(
          color: cardColor,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: statusColor,
              child: const Icon(Icons.receipt_long, color: Colors.white),
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
                Text('${'due_date'.tr}: ${formatDate(debt.dueDate)}'),
              ],
            ),
            trailing: debt.status != 'paid' && customer != null
                ? ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.customerDetails, arguments: customer);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 78, 148, 115),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('view'.tr),
                  )
                : null,
            onTap: () {
              if (customer != null) {
                Get.toNamed(Routes.customerDetails, arguments: customer);
              }
            },
          ),
        );
      },
    );
  }
}
