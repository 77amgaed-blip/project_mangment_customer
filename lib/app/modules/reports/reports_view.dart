import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customers_controller.dart';
import '../../controllers/reports_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../data/models/customer.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reports'.tr),
        backgroundColor: const Color.fromARGB(255, 78, 148, 115),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ملخص عام
              _buildSummaryCard(),
              const SizedBox(height: 16),
              // إحصائيات
              _buildStatisticsCard(),
              const SizedBox(height: 16),
              // نسبة التحصيل
              _buildCollectionRateCard(),
              const SizedBox(height: 16),
              // الديون حسب العميل
              _buildDebtsByCustomerCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'general_summary'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _statItem('total_debts'.tr, controller.totalDebts, Colors.blue),
                ),
                Expanded(
                  child: _statItem('total_collected'.tr, controller.totalCollected, Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _statItem('total_remaining'.tr, controller.totalRemaining, Colors.red),
                ),
                Expanded(
                  child: _statItem('total_customers'.tr, controller.totalCustomers, Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'debt_statistics'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _statRow('total_debts_count'.tr, controller.totalDebtsCount.toString()),
            _statRow('paid_debts'.tr, controller.paidDebtsCount.toString()),
            _statRow('unpaid_debts'.tr, controller.unpaidDebtsCount.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionRateCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'collection_rate'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: controller.collectionRate / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                controller.collectionRate >= 50 ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${controller.collectionRate.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtsByCustomerCard() {
    final debtsByCustomer = controller.debtsByCustomer;
    if (debtsByCustomer.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('no_debts'.tr),
        ),
      );
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'debts_by_customer'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...debtsByCustomer.entries.map((entry) {
              final customerId = entry.key;
              final debts = entry.value;
              CustomersController? customersController;
              Customer? customer;
              try {
                customersController = Get.find<CustomersController>();
                customer = customersController.customers
                    .firstWhere((c) => c.id == customerId);
              } catch (e) {
                customer = null;
              }
              final total = debts.fold<int>(0, (sum, debt) => sum + debt.amount);
              final paid = debts
                  .where((debt) => debt.status == 'paid')
                  .fold<int>(0, (sum, debt) => sum + debt.amount);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer?.name ?? 'عميل غير معروف',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('${debts.length} ${'debt_count'.tr}'),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Builder(
                          builder: (context) {
                            String currency = 'ر.ي';
                            try {
                              currency = Get.find<SettingsController>().currentCurrency.value;
                            } catch (e) {
                              // استخدام القيمة الافتراضية
                            }
                            return Text(
                              '$total $currency',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        Builder(
                          builder: (context) {
                            String currency = 'ر.ي';
                            try {
                              currency = Get.find<SettingsController>().currentCurrency.value;
                            } catch (e) {
                              // استخدام القيمة الافتراضية
                            }
                            return Text(
                              '${'total_collected'.tr}: $paid $currency',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          _formatNumber(value),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
