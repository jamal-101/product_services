import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductScreen extends StatelessWidget {

  const AddProductScreen({super.key,});



  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? product = Get.arguments as Map<String, dynamic>?;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
          product == null ? "Add Product" : "Edit Product",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            // ১. ইমেজ আপলোড সেকশন
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.perm_media_outlined, color: Colors.grey),
                  SizedBox(height: 8.h),
                  Text(
                    "Tap to upload image",
                    style: GoogleFonts.montserrat(
                      color: Colors.orange,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Photos: 0/6 : Choose your main photo first",
                    style: GoogleFonts.montserrat(
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // ২. প্রোডাক্ট টাইটেল
            _buildCardContainer(
              child: _buildTextField("Product Title", "e.g., Premium Olive Jersey Polo"),
            ),
            SizedBox(height: 15.h),

            // ৩. প্রাইস সেকশন
            Row(
              children: [
                Expanded(
                  child: _buildCardContainer(
                    child: _buildTextField("Active Price (\$)", "149.99"),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildCardContainer(
                    child: _buildTextField("Original Price (\$)", "159.99"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),

            // ৪. ডেসক্রিপশন
            _buildCardContainer(
              child: _buildTextArea("Description", "Tell your customers about the product..."),
            ),
            SizedBox(height: 15.h),

            // ৫. অ্যাডিশনাল ইনফরমেশন
            _buildCardContainer(
              child: _buildTextArea("Additional Information", "Weight, size guides, or technical details."),
            ),
            SizedBox(height: 30.h),

            // ৬. পাবলিশ বাটন
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                 product == null ? "Publish Product" : "Update Product",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // আলাদা কন্টেইনার স্টাইল
  Widget _buildCardContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // টেক্সট ফিল্ড উইজেট
  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color(0xFFE5E7EB),width: 1.0.w)
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Color(0xFFF4F4F4),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // টেক্সট এরিয়া উইজেট
  Widget _buildTextArea(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Color(0xFFE5E7EB),width: 1.0.w)
          ),
          child: TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Color(0xFFF4F4F4),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}