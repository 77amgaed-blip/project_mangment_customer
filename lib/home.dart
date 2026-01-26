import 'package:flutter/material.dart';

import 'package:project_mangment_customer/app/modules/home/home_view.dart';

/// Backward-compatible entry point for older code paths.
/// The real Home screen lives under GetX modules: `HomeView`.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => const HomeView();
}
