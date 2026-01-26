import 'package:get/get.dart';

import '../data/models/customer.dart';
import '../data/models/debt.dart';
import 'debts_controller.dart';

class CustomerDetailsController extends GetxController {
  final Customer customer;

  CustomerDetailsController({required this.customer});

  final DebtsController debtsController = Get.find<DebtsController>();

  List<Debt> get customerDebts => debtsController.debtsForCustomer(customer.id);

  int get totalCollected => debtsController.totalCollectedForCustomer(customer.id);

  int get totalRemaining => debtsController.totalRemainingForCustomer(customer.id);

  void confirmPayment(Debt debt) {
    Get.defaultDialog(
      title: 'confirm_collection'.tr,
      middleText: 'confirm_collection_message'.tr,
      textCancel: 'cancel'.tr,
      textConfirm: 'confirm'.tr,
      onConfirm: () {
        debtsController.markPaid(debt.id);
        Get.back();
      },
    );
  }
}

