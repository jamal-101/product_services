import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Identity Verification",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification builds trust with buyers and helps you unlock exclusive selling features. Your data is encrypted and kept private.",
              style: GoogleFonts.montserrat(color: Colors.grey.shade700, fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),

            // মেইন কার্ড
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Document type", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  SizedBox(height: 10.h),
                  _buildDropdown(),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(child: _buildUploadBox("Front Side")),
                      SizedBox(width: 15.w),
                      Expanded(child: _buildUploadBox("Back Side")),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // সাবমিট বাটন
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF27AE60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))),
                onPressed: () {},
                child: Text("Submit Verifications", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey.shade200)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text("National ID", style: GoogleFonts.montserrat()),
          items: ["National ID", "Passport", "Driving License"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _buildUploadBox(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp)),
        SizedBox(height: 8.h),
        Container(
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid), // এখানে ডটেড বর্ডার লাইব্রেরি ব্যবহার করা যেতে পারে
          ),
          child: Center(child: Icon(Icons.add_photo_alternate_outlined, color: Colors.grey.shade400, size: 30.sp)),
        ),
      ],
    );
  }
}