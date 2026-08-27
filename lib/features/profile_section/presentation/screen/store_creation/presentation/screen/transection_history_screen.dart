import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_color.dart';

import '../controller/subscription_history_controller.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionHistoryController controller = Get.put(SubscriptionHistoryController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5EF),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
          ),
        ),
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2A9B4A)),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.fetchSubscriptionHistory(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.historyList.isEmpty
                    ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Text(
                      "No transaction history found",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: controller.historyList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = controller.historyList[index];

                    // প্যাকেজের নাম অথবা প্যাকেজ টাইপ
                    String title = item.packageId?.name ?? item.packageType ?? "Subscription Plan";

                    // ক্রিয়েটেড ডেট
                    String date = item.createdAt != null
                        ? (item.createdAt!.length >= 10 ? item.createdAt!.substring(0, 10) : item.createdAt!)
                        : "";

                    // int বা double যাই আসুক না কেন সেফলি ডাবলে কনভার্ট করার জন্য
                    double amount = (item.amountPaid ?? 0).toDouble();

                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // বাম পাশে প্যাকেজের নাম এবং তারিখ
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  date,
                                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),

                          // ডান পাশে শুধু অ্যামাউন্ট
                          Text(
                            "\$${amount.toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black87),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}