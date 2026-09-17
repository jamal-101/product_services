import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/controller/suscription_controller.dart';

import 'creat_new_store_step1.dart';

/// [payMode] false = first-time plan selection → continue to setup (steps 1–4).
/// [payMode] true = after setup → pay, verify, create store → home.
class CreateNewStoreStep5 extends StatelessWidget {
  final bool payMode;

  const CreateNewStoreStep5({super.key, this.payMode = true});

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller =
        Get.isRegistered<SubscriptionController>()
            ? Get.find<SubscriptionController>()
            : Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
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
              payMode ? "Step 5 of 5" : "Step 1 of 5",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.h),
          child: LinearProgressIndicator(
            value: payMode ? 1.0 : 0.2,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF2A9B4A),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2A9B4A)),
          );
        }

        if (controller.subscriptionList.isEmpty) {
          return const Center(
            child: Text("No store_creation packages available"),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Store Publication Plan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                payMode
                    ? "Confirm your plan and pay securely. Your store will be created after payment."
                    : "Choose a plan first, then set up your store. Payment comes after setup.",
                style: TextStyle(color: Colors.grey, fontSize: 13.sp),
              ),
              SizedBox(height: 20.h),
              ...controller.subscriptionList.asMap().entries.map((entry) {
                final index = entry.key;
                final plan = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildPlanCard(
                    controller,
                    plan.sId ?? "",
                    plan.name ?? "",
                    "\$${plan.price ?? 0}",
                    plan.features != null && plan.features!.isNotEmpty
                        ? plan.features!.first
                        : "Host your storefront seamlessly.",
                    index == 0,
                  ),
                );
              }),
              SizedBox(height: 24.h),
              Obx(
                () => controller.isPurchasing.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2A9B4A),
                        ),
                      )
                    : buildNextButton(
                        () {
                          if (controller.selectedPlanId.value.isEmpty) {
                            Get.snackbar(
                              "Warning",
                              "Please select a subscription plan first",
                            );
                            return;
                          }
                          if (payMode) {
                            controller.startDatafastPayment();
                          } else {
                            Get.to(() => CreateNewStoreStep1());
                          }
                        },
                        text: payMode
                            ? "Pay & Create Store"
                            : "Continue to Setup",
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPlanCard(
    SubscriptionController controller,
    String planId,
    String title,
    String price,
    String desc,
    bool isRecommended,
  ) {
    return Obx(() {
      final isSelected = controller.selectedPlanId.value == planId;
      return GestureDetector(
        onTap: () => controller.selectPlan(planId, title),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF9FBF9) : Colors.white,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF2A9B4A)
                  : const Color(0xFFECECF0),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isRecommended)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A9B4A),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "RECOMMENDED",
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (isRecommended) SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                price,
                style: TextStyle(
                  color: const Color(0xFF2A9B4A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.shade600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildNextButton(
    VoidCallback onTap, {
    String text = "Pay & Create Store",
  }) {
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
            borderRadius: BorderRadius.circular(10.r),
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
