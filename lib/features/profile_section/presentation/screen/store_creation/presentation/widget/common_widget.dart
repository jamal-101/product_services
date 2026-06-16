import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSize buildProgressBar(double value) {
  return PreferredSize(
    preferredSize: Size.fromHeight(4.h),
    child: LinearProgressIndicator(
      value: value,
      color: const Color(0xFF27AE60),
    ),
  );
}

Widget buildNextButton(VoidCallback onTap, {String text = "Next"}) {
  return SizedBox(
    width: double.infinity,
    height: 50.h,
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // লিনিয়ার গ্রেডিয়েন্ট কালার সেট করা হলো
          gradient: const LinearGradient(
            colors: [Color(0xFF2A9B4A), Color(0xFF1F7A3A)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.r), // আপনার ডিজাইনের বর্ডার রেডিয়াস
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

Widget buildTextField(String label, String hint) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15.h),
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    ),
  );
}
