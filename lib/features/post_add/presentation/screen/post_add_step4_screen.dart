import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/presentation/screen/post_add_step1.dart';

import '../../controller/post_add_controller.dart';

class PostAdStep4Screen extends StatelessWidget {
  const PostAdStep4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.put(PostAddController());

    return Scaffold(
      appBar: AppBar(title: const Text("Post New Ad")),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Step 4 of 4 • Summary & pay", style: GoogleFonts.montserrat(color: Colors.grey)),
            SizedBox(height: 20.h),
            Text("Campaign: ${controller.campaignNameController.text}", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            Text("City ID: ${controller.selectedCityId.value}"),
            Text("Selected Slot: ${controller.selectedSlot.value}"),
            Text("Start Date: ${controller.startDate.value}"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: controller.isSubmitting.value
                    ? null
                    : () {
                  // ফাইনাল POST এপিআই কল যা সব ডেটা ব্যাকএন্ডে পাঠাবে
                  controller.submitAdvertisement();
                },
                child: controller.isSubmitting.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit & Pay", style: TextStyle(color: Colors.white)),
              )),
            ),
          ],
        ),
      ),
    );
  }
}