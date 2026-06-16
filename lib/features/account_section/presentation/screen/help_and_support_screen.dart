import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          "Help & Support",
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
            // FAQ লিস্টের কার্ড
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildExpansionTile(
                    "Can I buy products directly through the app?",
                    "No, [App Name] does not process payments or handle transactions. Buyers and sellers arrange payments and delivery directly between themselves.",
                  ),
                  _buildDivider(),
                  _buildExpansionTile("How do I contact a seller?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("Is there any fee to use the platform?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("How do I create a seller account?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("Can I export my payment history?", "Answer text goes here..."),
                  _buildDivider(),
                  _buildExpansionTile("How do I get my listings approved faster?", "Answer text goes here..."),
                ],
              ),
            ),
            SizedBox(height: 25.h),

            // কন্টাক্ট সাপোর্ট বক্স
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFB9E2C5).withValues(alpha: 0.3), // হালকা সবুজ ব্যাকগ্রাউন্ড
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Icon(Icons.support_agent, size: 40.sp, color: const Color(0xFF27AE60)),
                  SizedBox(height: 10.h),
                  Text(
                    "Still need help ?",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Our support team is ready to assist you anytime.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // গ্রেডিয়েন্ট দেখানোর জন্য ট্রান্সপারেন্ট করা হয়েছে
                          shadowColor: Colors.transparent, // ডিফল্ট শ্যাডো রিমুভ করা হয়েছে
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Contact Support",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, String subtitle) {
    return ExpansionTile(
      title: Text(
        title,
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14.sp, color: Colors.black),
      ),
      childrenPadding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
      children: [
        Text(subtitle, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 20.w, endIndent: 20.w);
  }
}