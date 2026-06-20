import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/common_button.dart';


class EditLegalDocumentsScreen extends StatelessWidget {
  const EditLegalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
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
          "Edite Legal Documents",
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
            // কন্টেইনারের ভেতরে সব এলিমেন্ট
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Trade License No. *"),
                  _buildTextField("e.g. TL-8829-2024"),
                  SizedBox(height: 20.h),

                  _buildLabel("Upload Trade License *"),
                  _buildFilePickerSection(),
                  SizedBox(height: 20.h),

                  _buildLabel("TIN Number *"),
                  _buildTextField("e.g. 123-456-789"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: CommonGradientButton(
          text: "Save Changes",
          onPressed: () {
            // Save logic here
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildFilePickerSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300,),
      ),
      child: Column(
        children: [
          Icon(Icons.badge_outlined, color: const Color(0xFF2A9B4A), size: 32.sp),
          SizedBox(height: 10.h),
          Text("Upload your file here", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
          Text("PDF or image . PNG up to 10MB", style: GoogleFonts.montserrat(fontSize: 10.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  // আপনার পূর্বের তৈরি করা _buildTextField এখানে ব্যবহার করুন
  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Color(0xFFE5E7EB))),
      ),
    );
  }
}