import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              _buildRatingHeader(),
              SizedBox(height: 16.h),
              _buildReviewItem("Maria Rodriguez", "Best organic produce in Madrid. The staff actually know the farmers they buy from.", "2 days ago", hasResponse: true),
              _buildReviewItem("Alex López", "Slightly pricey but quality is unmatched. Delivery was on time and packaging was great.", "1 week ago"),
              _buildReviewItem("Carmen García", "Have been shopping here for 5 years. Consistent quality, fair prices.", "2 jan 2026"),
            ],
          ),
        ),
        _buildFooterButton(),
      ],
    );
  }

  // উপরের রেটিং ড্যাশবোর্ড
  Widget _buildRatingHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // বাম পাশের বড় রেটিং সেকশন
          Column(
            children: [
              Text("4.9", style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold)),
              Text("★★★★★",style: TextStyle(
                color: Color(0xFFEE7A1F),
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),),
              Text("247 reviews", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
          SizedBox(width: 20.w),

          // ডান পাশের রেটিং বার এবং স্টার সেকশন
          Expanded(
            child: Column(
              children: List.generate(5, (i) {
                int starCount = 5 - i;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Row(
                    children: [
                      Text("$starCount", style: TextStyle(fontSize: 12.sp)),
                      SizedBox(width: 4.w),
                      Icon(Icons.star, color: Colors.orange, size: 12.sp), // এখানে স্টার আইকন যোগ করা হয়েছে
                      SizedBox(width: 8.w),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.8 - (i * 0.15), // আপনার প্রয়োজন অনুযায়ী ভ্যালু অ্যাডজাস্ট করে নিন
                          color: Colors.orange,
                          backgroundColor: Colors.grey.shade200,
                          minHeight: 6.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // রিভিউ আইটেম
  Widget _buildReviewItem(String name, String comment, String date, {bool hasResponse = false}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(backgroundColor: Colors.teal.shade100, child: Text(name[0])),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Row(children: [Icon(Icons.star, color: Color(0xFFEE7A1F), size: 14), Text(" 5.0")]),
          trailing: Text(date, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        ),
        Text(comment, style: TextStyle(color: Colors.grey.shade800)),
        if (hasResponse)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8.r)),
            child: Text("↩ Response from owner: Thank you Maria!", style: TextStyle(fontSize: 12.sp, color: Colors.green.shade900)),
          ),
        Divider(height: 30.h),
      ],
    );
  }

  // নিচের 'Write a Review' বাটন
  Widget _buildFooterButton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800, minimumSize: Size(double.infinity, 50.h)),
        child: Text("Write a Review", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
      ),
    );
  }
}