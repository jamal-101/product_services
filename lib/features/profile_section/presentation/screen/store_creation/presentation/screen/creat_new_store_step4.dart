import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/store_creation_controller.dart';
import '../controller/suscription_controller.dart';

class CreateNewStoreStep4 extends StatelessWidget {
  const CreateNewStoreStep4({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreCreationController controller = Get.find<StoreCreationController>();
    // পেমেন্ট ট্রিগার করার জন্য সাবস্ক্রিপশন কন্ট্রোলার
    final SubscriptionController subController = Get.isRegistered<SubscriptionController>()
        ? Get.find<SubscriptionController>()
        : Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: const Text(
          "Create New Store",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Legal Documents",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            Text(
              "Required for marketplace compliance and delivery setup.",
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFECECF0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("TIN Number *"),
                  _buildTextField("e.g. 123-456-789", controller.tinNumberController),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Obx(() {
              // স্টোর তৈরি বা পেমেন্ট লোডিং চেক
              bool isLoading = controller.isLoading.value || subController.isPurchasing.value;
              
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2A9B4A)),
                );
              }
              
              return buildNextButton(
                () {
                  if (controller.tinNumberController.text.isEmpty) {
                    Get.snackbar("Warning", "Please enter TIN number");
                    return;
                  }
                  
                  // সব তথ্য শেষে এখন সরাসরি পেমেন্ট গেটওয়ে ওপেন হবে
                  // এটি ডুপ্লিকেট প্ল্যান সিলেকশন স্টেপ (Step 5) এড়িয়ে যাবে
                  subController.startDatafastPayment(
                    onSuccess: () async {
                      await controller.createStore();
                    }
                  );
                },
                text: "Pay & Create Store",
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 10.h),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
    ),
  );

  Widget _buildTextField(String hint, TextEditingController textController) => TextField(
    controller: textController,
    decoration: InputDecoration(
      hintText: hint,
      fillColor: const Color(0xFFF9F9F9),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFFECECF0)),
      ),
    ),
  );

  Widget buildNextButton(VoidCallback onTap, {String text = "Pay & Create Store"}) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
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
