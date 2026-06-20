import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_images.dart';

class SavedProductScreen extends StatelessWidget {
  const SavedProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Saved Product",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // প্রতি সারিতে ২টি কার্ড
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.75, // কার্ডের অনুপাত ঠিক রাখার জন্য
        ),
        itemCount: 4, // আপনার ইমেজের ডেটা অনুযায়ী
        itemBuilder: (context, index) {
          return _buildProductCard();
        },
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                    image:  DecorationImage(
                      image: AssetImage(AppImages.productImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // হার্ট আইকন
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: const Icon(Icons.favorite, color: Colors.orange),
                ),
                // ডিসকাউন্ট ব্যাজ (যদি থাকে)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(4.r)),
                    child: Text("-25%", style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vintage Leather Jacket", maxLines: 1, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text("\$89.99", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 5.w),
                    Text("\$95.45", style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 10.sp)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}