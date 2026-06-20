import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/common_button.dart';

class EditContactDetailsScreen extends StatelessWidget {
  const EditContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool isSameAsPhone = false.obs; // GetX ভেরিয়েবল
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Edit Contact Details",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Phone Number"),
            _buildTextField("+880 1XXX XXX XXX"),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel("WhatsApp"),
                Row(
                  children: [
                    Text(
                      "Same as phone",
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Color(0xFF7A818F),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Obx(
                      () => Transform.scale(
                        scale: 0.7,
                        child: Switch.adaptive(
                          value: isSameAsPhone.value,
                          onChanged: (value) => isSameAsPhone.value = value,
                          activeColor: const Color(0xFF2A9B4A),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildTextField("+880 1XXX XXX XXX"),
            SizedBox(height: 16.h),

            _buildLabel("Email Address"),
            _buildTextField("shop@example.com", icon: Icons.email_outlined),
            SizedBox(height: 20.h),

            _buildLabel("Location"),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildNestedLabel("Streat Address *"),
                  _buildTextField(
                    "Calle Mayor 142",
                    icon: Icons.location_on_outlined,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNestedLabel("City *"),
                            _buildTextField(
                              "Madrid",
                              icon: Icons.location_city,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNestedLabel("Postal Code"),
                            _buildTextField(
                              "28013",
                              icon: Icons.local_post_office,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: Color(0xFF2A9B4A),
                          size: 30,
                        ),
                        Text(
                          "Pin exact location on map",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          "Drag the pin to your store's precise location",
                          style: GoogleFonts.montserrat(
                            fontSize: 9.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20.w),
          child: CommonGradientButton(text: "Save Changes", onPressed: (){})
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  Widget _buildNestedLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _buildTextField(String hint, {IconData? icon}) {
    // ফিগমা ইমেজ অনুযায়ী সঠিক বর্ডার কালার (হালকা ধূসর)
    const Color borderColor = Color(0xFFE5E7EB);

    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey.shade500),
        prefixIcon: icon != null
            ? Icon(icon, size: 18.sp, color: Colors.grey.shade600)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        // বর্ডার সেটিং - সব জায়গায় একই কালার ব্যবহার করা হয়েছে
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: borderColor, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: borderColor, width: 1.w),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: borderColor, width: 1.w),
        ),
      ),
    );
  }
}
