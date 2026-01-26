import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customers_controller.dart';
import '../../routes/app_routes.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('customers'.tr),
        backgroundColor: const Color.fromARGB(255, 98, 165, 134),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.customers.length,
          itemBuilder: (context, i) {
            final customer = controller.customers[i];
            return Card(
              color: const Color.fromARGB(255, 133, 184, 160),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 47, 10, 212),
                ),
                title: Text(
                  customer.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(customer.phone),
                onTap: () {
                  Get.toNamed(Routes.customerDetails, arguments: customer);
                },
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      controller.openCustomerDialog(customer: customer);
                    } else if (value == 'delete') {
                      controller.confirmDelete(customer);
                    }
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('edit'.tr),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('delete'.tr),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openCustomerDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

