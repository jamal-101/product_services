import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
// সঠিক প্যাকেজ ইমপোর্ট ব্যবহার করা হলো
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/controller/suscription_controller.dart';

class SubscriptionBillingScreen extends StatelessWidget {
  const SubscriptionBillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলারটি এখানে ইনজেক্ট করা হচ্ছে
    final SubscriptionController controller = Get.put(SubscriptionController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Subscription & Billing",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF2A9B4A)));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active Plan Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "ACTIVE PLAN",
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF065F46),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Growth Plan",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$49/mo",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Next Billing Date:",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF7A818F),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "July 18, 2026",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Available Plans",
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),

              // dynamic Plan Cards from Controller
              if (controller.subscriptionList.isEmpty)
                const Center(child: Text("No plans available"))
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: controller.subscriptionList.length,
                  itemBuilder: (context, index) {
                    final plan = controller.subscriptionList[index];
                    bool isRecommended = index == 1; // Assuming 2nd plan is recommended
                    return _buildPlanCard(
                      controller,
                      plan.sId ?? "",
                      plan.name ?? "",
                      "\$${plan.price ?? 0}/mo",
                      plan.features?.isNotEmpty == true ? plan.features!.first : "Standard features",
                      isRecommended,
                    );
                  },
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPlanCard(
    SubscriptionController controller,
    String id,
    String title,
    String price,
    String desc,
    bool isRecommended,
  ) {
    return Obx(() {
      bool isSelected = controller.selectedPlanId.value == id;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected || isRecommended
                ? const Color(0xFF2A9B4A)
                : Colors.grey.shade200,
            width: isSelected || isRecommended ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isRecommended)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A9B4A),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  "RECOMMENDED",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Text(
                desc,
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 11.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.selectPlan(id, title);
                  controller.startDatafastPayment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRecommended || isSelected
                      ? const Color(0xFF059669)
                      : const Color(0xFFF1F5F9),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: controller.isPurchasing.value && isSelected
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        isRecommended ? "ACTIVE PLAN" : "SELECT",
                        style: GoogleFonts.montserrat(
                          color: isRecommended || isSelected ? Colors.white : Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
