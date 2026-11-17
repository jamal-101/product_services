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

    return Obx(
      () => PopScope(
        // আপনি যেমনটি চেয়েছেন: হোম ট্যাবে (Index 0) থাকলে canPop true হবে, ফলে অ্যাপ ক্লোজ হবে।
        // অন্য ট্যাবে থাকলে canPop false হবে, যাতে আমরা ব্যাক প্রেস ইন্টারসেপ্ট করতে পারি।
        canPop: navController.currentIndex.value == 0,
        onPopInvokedWithResult: (didPop, result) {
          // যদি ইতিমধ্যে পপ হয়ে যায় (যেমন canPop true ছিল), তবে আর কিছু করার নেই।
          if (didPop) return;

          // যদি ইউজার হোম ট্যাব (Index 0) ছাড়া অন্য কোনো ট্যাবে থাকে, 
          // তবে ব্যাক প্রেস করলে navController.handleBackPress() রান হবে যা ইউজারকে হোমে ফিরিয়ে আনবে।
          if (navController.currentIndex.value != 0) {
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
      ),
    );
  }
}
