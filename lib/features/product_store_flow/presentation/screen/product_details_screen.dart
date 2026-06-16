import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:product_service/utils/constants/app_color.dart';
import 'package:product_service/utils/constants/app_images.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isProductStore = Get.arguments ?? true;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ইমেজ স্লাইডার সেকশন
                SizedBox(
                  height: 350.h,
                  child: Stack(
                    children: [
                      Image.asset(
                       isProductStore ?AppImages.productDetailsImage: AppImages.serviceImage,
                        width: double.infinity,
                        height: 350.h,
                        fit: BoxFit.cover,
                      ),
                      // '1/4' কাউন্টার
                      Positioned(
                        top: 16.h,
                        right: 16.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "1/4",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      // অ্যারো বাটন
                      Positioned(
                        left: 16.w,
                        top: 160.h,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16.w,
                        top: 160.h,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // ডট ইন্ডিকেটর
                      Positioned(
                        bottom: 15.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (i) => Container(
                              width: 8.w,
                              height: 8.w,
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i == 0 ? Colors.white : Colors.white38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ), // ইমেজের ওপর কিছুটা ওভারল্যাপ করার জন্য
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Color(0xFFF3F4F6)),
                      color: Colors.white, // ব্যাকগ্রাউন্ড সাদা
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ), // ওপরে রাউন্ডেড কর্নার
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium Olive Jersey Polo",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\$149.99 ",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$159.99",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "Olive Green Jersey Short Sleeve Polo is built for everyday wear with a clean, modern look, breathable comfort. Made from high-quality jersey fabric, it feels lightweight on the skin.",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 16.h),
                        // Additional Information
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text("Available Size : S, M, L, XL"),
                        Text("• 100% Giza Cotton"),
                        Text("• Weight: 185 GSM (Ultra light but structured)"),
                        Text("• Colorfast dye system"),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 16.h),
                // Store Info Box
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(16.r), // কার্ডের রাউন্ডনেস বাড়ানো হয়েছে
                    ),
                    child: Row(
                      children: [
                        // লোগোর জন্য Container
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1F25), // গাঢ় কালার
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text("LR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Le Reve", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                            Text("Clothing", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        // অরেঞ্জ বাটন
                        SizedBox(
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF37A20), // অরেঞ্জ কালার
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              elevation: 0,
                            ),
                            child: const Text("View Store"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(width: 1.w,color: Color(0xFFECECF0))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF27AE60),
                    // উচ্চতা এবং প্যাডিং অ্যাডজাস্ট করা হয়েছে
                    minimumSize: Size(double.infinity, 56.h),
                    // ডিজাইন অনুযায়ী পুরোপুরি গোলাকার শেপ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 0, // শ্যাডো কমিয়ে ফ্ল্যাট লুক দেওয়া হয়েছে
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat_bubble_outline, color: Colors.white), // চ্যাট আইকন
                      SizedBox(width: 10.w),
                      Text(
                        "Message Seller",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600, // ফন্ট ওয়েট বাড়িয়ে দেওয়া হয়েছে
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
