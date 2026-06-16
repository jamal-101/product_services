import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/store_creation_controller.dart';

class CreateNewStoreStep5 extends StatelessWidget {
  final StoreCreationController controller = Get.put(StoreCreationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5EF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Create New Store",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Step 5 of 5",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(
            value: 1,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF2A9B4A),
          ),
        ),
      ), // আগের মতোই অ্যাপবার
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Store Publication Plan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            Text(
              "Pick a recurring plan to host your newly registered storefront.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20.h),

            // Plan Selection
            Row(
              children: [
                _buildPlanCard(
                  "Starter",
                  "\$19/m",
                  "Perfect for single boutique launches.",
                  false,
                ),
                SizedBox(width: 15.w),
                _buildPlanCard(
                  "Growth",
                  "\$49/m",
                  "Custom domain integrations included.",
                  true,
                ),
              ],
            ),

            SizedBox(height: 25.h),
            // Payment Method Tabs
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Obx(
                () => Row(
                  children: [
                    _buildPaymentTab("Card", Icons.credit_card),
                    _buildPaymentTab(
                      "Debit",
                      Icons.account_balance_wallet_outlined,
                    ),
                    _buildPaymentTab("Bank", Icons.account_balance_outlined),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
            _buildTextField("Cardholder Name", "e.g. Liam Smith"),
            _buildTextField("Card Number", "4000 1234 5678 9010"),
            Row(
              children: [
                Expanded(child: _buildTextField("Expiry", "MM/YY")),
                SizedBox(width: 10.w),
                Expanded(child: _buildTextField("CVV", "...")),
              ],
            ),

            SizedBox(height: 40.h),
            buildNextButton(() {
              Get.to(() => CreateNewStoreStep5());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(
      String title,
      String price,
      String desc,
      bool isRecommended,
      ) {
    return Obx(() {
      bool isSelected = controller.selectedPlan.value == title;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.selectPlan(title),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF9FBF9) : Colors.white, // সিলেক্টেড হলে হালকা সবুজ ব্যাকগ্রাউন্ড
              border: Border.all(
                color: isSelected ? const Color(0xFF2A9B4A) : const Color(0xFFECECF0),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isRecommended)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A9B4A),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "RECOMMENDED",
                      style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(height: isRecommended ? 8.h : 0),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text(price, style: TextStyle(color: const Color(0xFF2A9B4A), fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text(desc, style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPaymentTab(String name, IconData icon) {
    bool isSelected = controller.selectedPayment.value == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectPayment(name),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Icon(icon, size: 20.sp),
              Text(name, style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      SizedBox(height: 8.h),
      TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFFECECF0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFFECECF0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Color(0xFFECECF0)),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
        ),
      ),
      SizedBox(height: 15.h),
    ],
  );
  Widget buildNextButton(VoidCallback onTap, {String text = "Pay & Publish Store"}) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(
                10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
