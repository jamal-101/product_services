import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/post_add/presentation/screen/post_add_step2_screen.dart';

import '../../controller/post_add_controller.dart';

class PostAdStep1Screen extends StatelessWidget {
  const PostAdStep1Screen({super.key});

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
            Text("Step 1 of 4", style: GoogleFonts.montserrat(color: Colors.grey)),
            SizedBox(height: 20.h),
            TextField(
              controller: controller.campaignNameController,
              decoration: const InputDecoration(labelText: "Campaign name", hintText: "e.g. Summer Sale 2026"),
            ),
            SizedBox(height: 20.h),
            Obx(() => controller.isLoadingCities.value
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "City"),
              hint: const Text("Select city"),
              items: controller.citiesList.map<DropdownMenuItem<String>>((city) {
                return DropdownMenuItem<String>(
                  value: city['_id'],
                  child: Text(city['city']),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedCityId.value = value!;
                // সিটি সিলেক্ট করার পর স্লট অ্যাভেইল্যাবিলিটি এপিআই কল করতে পারেন
                controller.fetchSlotAvailability();
              },
            )),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (controller.campaignNameController.text.isEmpty || controller.selectedCityId.value.isEmpty) {
                  Get.snackbar("Warning", "Please fill all fields");
                  return;
                }
                // পরবর্তী স্টেপে যান
                Get.to(() => const PostAdStep2Screen());
              },
              child: const Text("Continue →"),
            ),
          ],
        ),
      ),
    );
  }
}