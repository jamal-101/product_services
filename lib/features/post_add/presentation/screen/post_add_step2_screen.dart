import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/controller/post_add_controller.dart';
import 'package:product_service/features/post_add/presentation/screen/post_add_step3_screen.dart';

class PostAdStep2Screen extends StatelessWidget {
  const PostAdStep2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostAddController controller = Get.put(PostAddController());

    return Scaffold(
      appBar: AppBar(title: const Text("Post New Ad")),
      body: Obx(() {
        if (controller.isLoadingSlots.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Text("Step 2 of 4 • Placement", style: GoogleFonts.montserrat(color: Colors.grey)),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView(
                  children: [
                    // উদাহরণস্বরূপ স্ট্যাটিক বা স্লট অ্যাভেইল্যাবিলিটি ডেটা লুপ করা
                    ListTile(
                      title: const Text("Slot 1"),
                      subtitle: const Text("Available - \$150/wk"),
                      trailing: Radio<String>(
                        value: "Slot 1",
                        groupValue: controller.selectedSlot.value,
                        onChanged: (val) => controller.selectedSlot.value = val!,
                      ),
                    ),
                    ListTile(
                      title: const Text("Slot 2"),
                      subtitle: const Text("Available - \$140/wk"),
                      trailing: Radio<String>(
                        value: "Slot 2",
                        groupValue: controller.selectedSlot.value,
                        onChanged: (val) => controller.selectedSlot.value = val!,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.selectedSlot.value.isEmpty) {
                    Get.snackbar("Warning", "Please select a slot");
                    return;
                  }
                  Get.to(() => const PostAdStep3Screen());
                },
                child: const Text("Continue →"),
              ),
            ],
          ),
        );
      }),
    );
  }
}