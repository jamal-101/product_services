import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/constants/app_color.dart';
import '../controller/store_creation_controller.dart';
import '../widget/common_widget.dart';
import 'creat_new_store_step4.dart';

class CreateNewStoreStep3 extends StatelessWidget {
  const CreateNewStoreStep3({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreCreationController controller = Get.find<StoreCreationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: AppColor.appBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(color: const Color(0xFFF5F5EF), borderRadius: BorderRadius.circular(12.r)),
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
            ),
          ),
        ),
        title: const Text(
          "Create New Store",
          style: TextStyle(
            color: Color(0xFF1A1D24),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contact Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            Text("How can customers and our team reach you?", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20.h),

            _buildLabel("Phone Number *"),
            _buildTextField("+880 1XXX XXX XXX", controller.phoneController),
            
            _buildLabel("WhatsApp"),
            _buildTextField("+880 1XXX XXX XXX", controller.whatsappController),

            _buildLabel("Email Address *"),
            _buildTextField("shop@example.com", controller.emailController, prefixIcon: Icons.email_outlined),

            SizedBox(height: 30.h),
            buildNextButton(() {
              Get.to(() => const CreateNewStoreStep4());
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 10.h),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp)),
  );

  Widget _buildTextField(String hint, TextEditingController textController, {IconData? prefixIcon}) => TextField(
    controller: textController,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      hintText: hint,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20.sp) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFECECF0))),
    ),
  );
}
