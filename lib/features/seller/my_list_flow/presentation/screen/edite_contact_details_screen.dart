import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../account_section/presentation/controller/store_setup_controller.dart';


class EditContactDetailsScreen extends StatelessWidget {
  const EditContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreUpdateController controller = Get.put(StoreUpdateController());

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
          "Edit Contact Details",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone Number", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "+880 1XXX XXX XXX",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 15.h),


                Text("WhatsApp", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),

            SizedBox(width: 16.w),
            TextField(
              controller: controller.whatsappController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "+880 1XXX XXX XXX",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 15.h),
            Text("Email Address", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "shop@example.com",
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
            SizedBox(height: 20.h),
            Text("Location", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15.sp)),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey.shade50,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Select Location"),
                    SizedBox(width: 110.w),
                    Icon(Icons.keyboard_arrow_down_rounded,color: Colors.black87,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: () => controller.updateStore(),
                child: Text("Save Changes", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}