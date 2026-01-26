import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customers_controller.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';
import '../../shared/utils/date_utils.dart';
import '../../shared/widgets/app_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('dashboard'.tr),
        backgroundColor: const Color.fromARGB(255, 78, 148, 115),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(
              () => Row(
                children: [
                  _summaryCard(
                    _formatNumber(controller.totalDebts),
                    'total'.tr,
                    Colors.blue,
                  ),
                  _summaryCard(
                    _formatNumber(controller.totalCollected),
                    'collected'.tr,
                    Colors.green,
                  ),
                  _summaryCard(
                    _formatNumber(controller.totalRemaining),
                    'remaining'.tr,
                    Colors.red,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'upcoming_debts'.tr,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => TextButton(
                    onPressed: controller.toggleShowAll,
                    child: Text(
                      controller.showAll.value ? 'show_less'.tr : 'show_more'.tr,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final displayDebts = controller.displayDebts;
                if (displayDebts.isEmpty) {
                  return Center(
                    child: Text('no_upcoming_debts'.tr),
                  );
                }
                return ListView.builder(
                  itemCount: displayDebts.length,
                  itemBuilder: (context, i) {
                    final debt = displayDebts[i];
                    return Card(
                      color: const Color.fromARGB(255, 133, 184, 160),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(debt.name),
                        subtitle: Text(
                          '${'due_date'.tr}: ${formatDate(debt.dueDate)}',
                        ),
                        trailing: Text(
                          '${_formatNumber(debt.amount)} ر.ي',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _footerButton(Icons.person_add, 'add_customer'.tr, () {
              Get.toNamed(Routes.customers);
            }),
            _footerButton(Icons.receipt_long, 'add_debt'.tr, () async {
              try {
                // اختيار عميل أولاً
                final customersController = Get.find<CustomersController>();
                if (customersController.customers.isEmpty) {
                  Get.snackbar('warning'.tr, 'no_customers'.tr);
                  Get.toNamed(Routes.customers);
                  return;
                }
                // عرض قائمة العملاء للاختيار
                _showCustomerSelectionDialog();
              } catch (e) {
                Get.snackbar('error'.tr, 'error'.tr);
              }
            }),
            _footerButton(Icons.payments, 'collection'.tr, () {
              Get.toNamed(Routes.collection);
            }),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String value, String title, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(value),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          heroTag: label,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: const Color.fromARGB(255, 78, 148, 115),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _showCustomerSelectionDialog() {
    try {
      final customersController = Get.find<CustomersController>();
      Get.dialog(
      AlertDialog(
        title: Text('select_customer'.tr),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: customersController.customers.length,
            itemBuilder: (context, index) {
              final customer = customersController.customers[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(customer.name),
                subtitle: Text(customer.phone),
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.addDebt, arguments: customer.id);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('cancel'.tr),
          ),
        ],
      ),
    );
    } catch (e) {
      Get.snackbar('error'.tr, 'error'.tr);
    }
  }
}

