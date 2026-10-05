import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'nav_bar..dart';
import 'nav_controller.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AppScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController navController =
        Get.find<BottomNavigationController>();
    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (selectedIndex != 0) {
          navController.handleBackPress();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
        body: body,
        bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),
      ),
    );
  }
}
