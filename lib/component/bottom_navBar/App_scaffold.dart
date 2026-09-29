import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'nav_bar..dart';
import 'nav_controller.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController navController = Get.find<BottomNavigationController>();

    return Obx(
          () => PopScope(
        canPop: navController.currentIndex.value == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          if (navController.currentIndex.value != 0) {
            navController.handleBackPress();
          }
        },
        child: Scaffold(
          appBar: appBar,
          body: body,
          bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
        ),
      ),
    );
  }
}