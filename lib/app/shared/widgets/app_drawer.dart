import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 78, 148, 115),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/amgadcv.png'),
                  ),
                ),
                Expanded(
                  child: Text(
                    'امجد صادق',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          _drawerTile('home'.tr, Icons.home, () => Get.offNamed(Routes.home)),
          _drawerTile('customers'.tr, Icons.people_sharp,
              () => Get.toNamed(Routes.customers)),
          _drawerTile('debts'.tr, Icons.receipt_long, () => Get.toNamed(Routes.debts)),
          _drawerTile('collection'.tr, Icons.payments, () => Get.toNamed(Routes.collection)),
          _drawerTile('reminders'.tr, Icons.notifications, () => Get.toNamed(Routes.reminders)),
          _drawerTile('reports'.tr, Icons.bar_chart, () => Get.toNamed(Routes.reports)),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 30),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              childrenPadding: const EdgeInsets.only(right: 16),
              title: Text('settings'.tr),
              leading: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 78, 148, 115),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              children: [
                const Divider(color: Colors.black),
                _subItem('change_username'.tr, Icons.person, () {
                  Get.toNamed(Routes.settings);
                }),
                const Divider(color: Color.fromARGB(255, 8, 109, 122)),
                _subItem('change_password'.tr, Icons.lock, () {
                  Get.toNamed(Routes.settings);
                }),
                const Divider(color: Color.fromARGB(255, 8, 109, 122)),
                _subItem('backup'.tr, Icons.backup, () {
                  Get.toNamed(Routes.settings);
                }),
                const Divider(color: Color.fromARGB(255, 8, 109, 122)),
                _subItem('currency'.tr, Icons.attach_money, () {
                  Get.toNamed(Routes.settings);
                }),
                const Divider(color: Color.fromARGB(255, 8, 109, 122)),
                _subItem('language'.tr, Icons.language, () {
                  Get.toNamed(Routes.settings);
                }),
                const Divider(color: Color.fromARGB(255, 8, 109, 122)),
                _subItem('theme'.tr, Icons.brightness_6, () {
                  Get.toNamed(Routes.settings);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _drawerTile(String text, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        onTap: onTap,
        tileColor: Colors.white,
        title: Text(text),
        leading: Icon(icon, color: const Color.fromARGB(255, 78, 148, 115)),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  static Widget _subItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 40),
      dense: true,
      leading: Icon(
        icon,
        size: 20,
        color: const Color.fromARGB(255, 78, 148, 115),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      onTap: onTap,
    );
  }
}

