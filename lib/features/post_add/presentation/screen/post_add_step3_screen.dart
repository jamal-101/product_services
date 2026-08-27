import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';
// আপনার প্রজেক্ট অনুযায়ী Step 4 স্ক্রিনের সঠিক পাথ এখানে import করে নিন
// import 'post_ad_step4_screen.dart';

class PostAdStep3Screen extends StatelessWidget {
  const PostAdStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // যেহেতু কন্ট্রোলারটি আগের স্ক্রিনেই put করা হয়েছে, তাই এখানে `Get.find()` ব্যবহার করা ভালো
    final PostAddController controller = Get.find<PostAddController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post New Ad"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Text(
              "Step 3 of 4 • Creative & Schedule",
              style: GoogleFonts.montserrat(color: Colors.grey),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () => controller.pickFeaturedImage(),
              child: Obx(() => Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    style: BorderStyle.solid, // flutter-এ dash-এর জন্য DottedBorder বা solid ব্যবহার করা নিরাপদ
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: controller.featuredImage.value == null
                    ? const Center(
                  child: Text("Tap to Upload Banner (1080x400)"),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    controller.featuredImage.value!,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  controller.startDate.value = "2026-09-25"; // ডেট সেট করা হলো
                  // Get.to(() => const PostAdStep4Screen()); // স্টেপ ৪ স্ক্রিনে রিডাইরেক্ট করুন
                },
                child: const Text("Review order →"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}