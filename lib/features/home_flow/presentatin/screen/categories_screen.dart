import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"title": "Electronics", "icon": Icons.electrical_services},
    {"title": "Fashion", "icon": Icons.checkroom},
    {"title": "Home & Living", "icon": Icons.chair},
    {"title": "Beauty & Cosmetic", "icon": Icons.brush},
    {"title": "Sports", "icon": Icons.sports_tennis},
    {"title": "Toys and Games", "icon": Icons.gamepad},
    {"title": "Toys and Games", "icon": Icons.gamepad},
    {"title": "Groceries", "icon": Icons.shopping_cart},
    {"title": "Gifts & Lifestyle", "icon": Icons.card_giftcard},
    {"title": "Books and Stationery", "icon": Icons.menu_book},
    {"title": "Health & Wellness", "icon": Icons.medical_services},
  ];

   CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Center(
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5EF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          "Categories",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.start,
          children: categories.map((item) {
            return SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Icon(item["icon"], color: Colors.black87, size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}