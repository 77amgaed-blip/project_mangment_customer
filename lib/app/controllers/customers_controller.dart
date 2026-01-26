import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/customer.dart';

class CustomersController extends GetxController {
  final RxList<Customer> customers = <Customer>[
    const Customer(id: 1, name: 'امجد صادق', phone: '778480008'),
    const Customer(id: 2, name: 'عيسى الجماعي', phone: '775346074'),
    const Customer(id: 3, name: 'يوسف الدالي', phone: '778656990'),
    const Customer(id: 4, name: 'البراء فهد', phone: '7798854687'),
    const Customer(id: 5, name: 'ابراهيم الصبان', phone: '785366534'),
  ].obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void openCustomerDialog({Customer? customer}) {
    if (customer != null) {
      nameController.text = customer.name;
      phoneController.text = customer.phone;
    } else {
      nameController.clear();
      phoneController.clear();
    }

    Get.dialog(
      AlertDialog.adaptive(
        title: Text(customer == null ? 'add_customer_title'.tr : 'edit_customer_title'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'customer_name'.tr,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                ),
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'phone'.tr,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                ),
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isEmpty) return;

              if (customer == null) {
                customers.add(
                  Customer(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: name,
                    phone: phone,
                  ),
                );
              } else {
                final index = customers.indexWhere((c) => c.id == customer.id);
                if (index != -1) {
                  customers[index] = customers[index].copyWith(
                    name: name,
                    phone: phone,
                  );
                }
              }

              Get.back();
            },
            child: Text('save'.tr),
          ),
        ],
      ),
    );
  }

  void confirmDelete(Customer customer) {
    Get.dialog(
      AlertDialog(
        title: Text('delete_customer'.tr),
        content: Text(
          'confirm_delete_customer'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              customers.removeWhere((c) => c.id == customer.id);
              Get.back();
            },
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}

