import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import '../../../../controller/profile_controller.dart';
import 'creat_new_store_step5.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Store"),
        leading: const BackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFFFF3E0),
              child: Icon(Icons.storefront, size: 40, color: Colors.orange),
            ),
            SizedBox(height: 20.h),
            Text(
              "No Stores Yet",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
              child: const Text(
                "You haven't created any stores yet. Get started by setting up your first one.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF27AE60),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
              ),
              onPressed: () {
                final profileData = profileController.profileModel.value.data;
                bool isStoreCreated = profileData?.isStoreCreated ?? false;
                if (isStoreCreated) {
                  Get.snackbar(
                    "Notice",
                    "You have already created a store!",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.orange,
                    colorText: Colors.white,
                    margin: EdgeInsets.all(10.w),
                    borderRadius: 10.r,
                  );
                  return;
                }
                Get.to(() => const CreateNewStoreStep5(payMode: false));
              },
              child: const Text(
                "Create Store",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
