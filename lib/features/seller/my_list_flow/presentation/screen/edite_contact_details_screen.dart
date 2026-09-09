import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../account_section/presentation/controller/store_setup_controller.dart';
import '../../../../home_flow/presentatin/controller/home_controller.dart';

class EditContactDetailsScreen extends StatelessWidget {
  const EditContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreUpdateController controller = Get.put(StoreUpdateController());
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'editContactDetails'.tr,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'phoneNumber'.tr,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "+880 1XXX XXX XXX",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
              ),
            ),
            SizedBox(height: 15.h),

            Text(
              'whatsapp'.tr,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.whatsappController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "+880 1XXX XXX XXX",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'emailAddress'.tr,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "shop@example.com",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'location'.tr,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () => _showCityPicker(context, homeController, controller),
              child: GetBuilder<StoreUpdateController>( // Obx এর বদলে GetBuilder ব্যবহার করা হয়েছে এরর এড়াতে
                  builder: (storeCtrl) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            storeCtrl.cityController.text.isEmpty
                                ? 'selectLocation'.tr
                                : storeCtrl.cityController.text,
                            style: GoogleFonts.montserrat(
                              color: storeCtrl.cityController.text.isEmpty ? Colors.grey : Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
                        ],
                      ),
                    );
                  }
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'streetAddress'.tr,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.streetAddressController,
              decoration: InputDecoration(
                hintText: 'streetAddressHint'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: controller.isLoading.value ? null : () => controller.updateStore(),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        'saveChanges'.tr,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _showCityPicker(BuildContext context, HomeController homeController, StoreUpdateController storeController) {
    if (homeController.cityList.isEmpty) {
      homeController.fetchCities();
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'selectLocation'.tr,
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: Obx(() {
                  if (homeController.isCityLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (homeController.cityList.isEmpty) {
                    return Center(child: Text("No cities found".tr));
                  }
                  return ListView.builder(
                    itemCount: homeController.cityList.length,
                    itemBuilder: (context, index) {
                      final city = homeController.cityList[index];
                      return ListTile(
                        title: Text(city.city ?? ""),
                        onTap: () {
                          storeController.cityController.text = city.city ?? "";
                          storeController.latitude.value = city.latitude ?? 0.0;
                          storeController.longitude.value = city.longitude ?? 0.0;
                          // Trigger UI update for cityController.text in Obx
                          storeController.update();
                          Get.back();
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
