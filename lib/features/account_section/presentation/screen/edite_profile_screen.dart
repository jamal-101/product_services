import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_color.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        surfaceTintColor: AppColor.appBackgroundColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Profile", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            // প্রোফাইল ছবি
            Center(
              child: Stack(
                children: [
                  CircleAvatar(radius: 50.r, backgroundImage: const AssetImage('assets/images/profile.png')),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(color: Color(0xFF27AE60), shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2))),
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text("Tap to change profile photo", style: GoogleFonts.montserrat(color: Colors.grey.shade600, fontSize: 12.sp)),
            SizedBox(height: 25.h),

            // কার্ড কন্টেইনার
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: Column(
                children: [
                  _buildTextField("Full Name", "Sazzad Chowdhury", Icons.person_outline),
                  _buildTextField("Email Address", "sarah.j@email.com", Icons.email_outlined),
                  _buildTextField("Phone Number", "+1 (555) 123-4567", Icons.phone_outlined),
                  _buildAddressSection(),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // সেভ বাটন
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF27AE60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))),
                onPressed: () {},
                child: Text("Save Changes", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Icon(icon, size: 16.sp, color: Colors.orange.shade800), SizedBox(width: 8.w), Text(label, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp))]),
        SizedBox(height: 8.h),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5)),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Icon(Icons.location_on_outlined, size: 16.sp, color: Colors.orange.shade800), SizedBox(width: 8.w), Text("Address", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13.sp))]),
        SizedBox(height: 8.h),
        Text("Country", style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey)),
        SizedBox(height: 5.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            filled: true, fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5)),
          ),
          hint: Text("Select your City", style: GoogleFonts.montserrat(fontSize: 14.sp)),
          items: ["Dhaka", "Chittagong"].map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
          onChanged: (v) {},
        ),
        SizedBox(height: 10.h),
        Text("Postal Code", style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey)),
        SizedBox(height: 5.h),
        TextField(
          decoration: InputDecoration(
            hintText: "Enter your postal code", contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), filled: true, fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5)),
          ),
        ),
        SizedBox(height: 10.h),
        Text("Streat Address", style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey)),
        SizedBox(height: 5.h),
        TextField(
          maxLines: 2,
          decoration: InputDecoration(
            hintText: "e.g House 12, Road 5, Block B", contentPadding: EdgeInsets.all(15.w), filled: true, fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: Colors.grey.shade200, width: 1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF27AE60), width: 1.5)),
          ),
        ),
      ],
    );
  }
}