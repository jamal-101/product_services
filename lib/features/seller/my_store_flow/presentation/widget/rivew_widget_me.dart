import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/my_store_controller.dart';

class ReviewsWidgetMe extends StatelessWidget {
  final String storeId;
  ReviewsWidgetMe({super.key, required this.storeId});
  final MyStoreController controller = Get.find<MyStoreController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final storeData = controller.myStoreModel.value?.data;
      final reviewsList = storeData?.reviews ?? [];
      final ratingStats = storeData?.ratingStats;

      double averageRating = storeData?.averageRating ?? 0.0;
      int totalReviews = storeData?.ratingCount ?? 0;

      return Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _buildRatingHeader(
                  averageRating: averageRating,
                  totalReviews: totalReviews,
                  ratingStats: ratingStats,
                ),
                SizedBox(height: 16.h),
                reviewsList.isEmpty
                    ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(
                      "No reviews found",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviewsList.length,
                  itemBuilder: (context, index) {
                    var review = reviewsList[index];
                    String name = review.userId?.name ?? "Anonymous";
                    String comment = review.comment ?? "";
                    String date = review.createdAt ?? "";
                    int rating = review.rating ?? 5;
                    bool hasResponse = review.isReplied ?? false;
                    String ownerReplyText = review.ownerReply?.comment ?? "";

                    return _buildReviewItem(
                      name: name,
                      comment: comment,
                      date: date,
                      rating: rating,
                      isReplied: hasResponse,
                      replyText: ownerReplyText,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildRatingHeader({
    required double averageRating,
    required int totalReviews,
    required dynamic ratingStats,
  }) {
    int totalCount = totalReviews > 0 ? totalReviews : 1;

    int count5 = ratingStats?.i5 ?? 0;
    int count4 = ratingStats?.i4 ?? 0;
    int count3 = ratingStats?.i3 ?? 0;
    int count2 = ratingStats?.i2 ?? 0;
    int count1 = ratingStats?.i1 ?? 0;

    List<double> values = [
      count5 / totalCount,
      count4 / totalCount,
      count3 / totalCount,
      count2 / totalCount,
      count1 / totalCount,
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "$averageRating",
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "★★★★★",
                style: TextStyle(
                  color: const Color(0xFFEE7A1F),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "$totalReviews reviews",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: List.generate(5, (i) {
                int starCount = 5 - i;
                double progressVal = values[i].clamp(0.0, 1.0);
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Row(
                    children: [
                      Text("$starCount", style: TextStyle(fontSize: 12.sp)),
                      SizedBox(width: 4.w),
                      Icon(Icons.star, color: Colors.orange, size: 12.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progressVal,
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

  Widget _buildReviewItem({
    required String name,
    required String comment,
    required String date,
    required int rating,
    required bool isReplied,
    required String? replyText,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.teal.shade50,
                child: Text(
                  name.isNotEmpty ? name[0] : "U",
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: const Color(0xFFEE7A1F),
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                DateConverter.formatTimeAgo(date),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            comment,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
          if (isReplied && replyText != null && replyText.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12.r),
                border: Border(
                  left: BorderSide(color: Colors.green.shade600, width: 4.w),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.reply,
                        color: Colors.green.shade700,
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "Response from owner",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    replyText,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade800,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DateConverter {
  static String formatTimeAgo(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
      Duration diff = DateTime.now().difference(dateTime);

      if (diff.inDays > 365) {
        return "${(diff.inDays / 365).floor()} years ago";
      } else if (diff.inDays > 30) {
        return "${(diff.inDays / 30).floor()} months ago";
      } else if (diff.inDays >= 7) {
        return "${(diff.inDays / 7).floor()} week ago";
      } else if (diff.inDays > 0) {
        return "${diff.inDays} days ago";
      } else if (diff.inHours > 0) {
        return "${diff.inHours} hours ago";
      } else if (diff.inMinutes > 0) {
        return "${diff.inMinutes} minutes ago";
      } else {
        return "Just now";
      }
    } catch (e) {
      return dateStr;
    }
  }
}