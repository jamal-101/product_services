import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../controller/rivew_controller.dart';

class ReviewsWidget extends StatefulWidget {
  final String storeId;
  const ReviewsWidget({super.key, required this.storeId});

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  final ReviewController controller = Get.put(ReviewController());

  final RxString activeReplyReviewId = "".obs;
  final TextEditingController _replyTextController = TextEditingController();

  @override
  void dispose() {
    _replyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchReviews(widget.storeId);
    });

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.orange),
        );
      }

      final data = controller.reviewModel.value.data;
      final reviewsList = data?.reviews ?? [];
      final ratingStats = data?.ratingStats;
      final bool isSeller = data?.isSeller ?? false;

      return Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _buildRatingHeader(
                  averageRating: data?.averageRating?.toDouble() ?? 0.0,
                  totalReviews: data?.totalReviews ?? 0,
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
                          String reviewId = review.id ?? "";
                          String name = review.userId?.name ?? "Anonymous";
                          String comment = review.comment ?? "";
                          String date = review.createdAt ?? "";
                          int rating = review.rating ?? 5;
                          String profileImage =
                              review.userId?.profileImage ?? "";
                          bool hasResponse = review.isReplied ?? false;
                          String ownerReplyText =
                              review.ownerReply?.comment ?? "";

                          return Obx(
                            () => _buildReviewItem(
                              reviewId: reviewId,
                              name: name,
                              comment: comment,
                              date: date,
                              rating: rating,
                              profileImage: profileImage,
                              isReplied: hasResponse,
                              // replyText: review.reply ?? "",
                              replyText: ownerReplyText,
                              isReplying: activeReplyReviewId.value == reviewId,
                              isSeller: isSeller,
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          _buildFooterButton(),
        ],
      );
    });
  }

  Widget _buildRatingHeader({
    required double averageRating,
    required int totalReviews,
    var ratingStats,
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
    required String reviewId,
    required String name,
    required String comment,
    required String date,
    required int rating,
    required String profileImage,
    required bool isReplied,
    required String? replyText,
    required bool isReplying,
    required bool isSeller,
  }) {
    final String? finalProfileImg = profileImage.isNotEmpty
        ? (profileImage.startsWith('http')
              ? profileImage
              : "${ApiEndPoint.imageUrl}$profileImage")
        : null;

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
                backgroundImage: finalProfileImg != null
                    ? NetworkImage(finalProfileImg)
                    : null,
                child: finalProfileImg == null
                    ? Text(
                        name.isNotEmpty ? name[0] : "U",
                        style: TextStyle(
                          color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      )
                    : null,
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
          // if (isReplied && replyText != null && replyText.isNotEmpty)
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

          // if (!isReplied) ...[
          if (!isReplied && isSeller) ...[
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  if (activeReplyReviewId.value == reviewId) {
                    activeReplyReviewId.value = "";
                  } else {
                    activeReplyReviewId.value = reviewId;
                    _replyTextController.clear();
                  }
                },
                child: Text(
                  isReplying ? "Cancel" : "Reply",
                  style: TextStyle(
                    color: const Color(0xFFEE7A1F),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),

            if (isReplying)
              Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: _replyTextController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: "Write your reply...",
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(height: 6.h),
                    ElevatedButton(
                      onPressed: () {
                        if (_replyTextController.text.trim().isNotEmpty) {
                          controller.sendOwnerReply(
                            reviewId,
                            _replyTextController.text.trim(),
                            widget.storeId,
                          );
                          activeReplyReviewId.value = "";
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE7A1F),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooterButton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: ElevatedButton(
        onPressed: () {
          _showCreateReviewDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade800,
          minimumSize: Size(double.infinity, 50.h),
        ),
        child: Text(
          "Write a Review",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ),
    );
  }

  void _showCreateReviewDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    RxInt selectedRating = 5.obs;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("Write a Review", style: TextStyle(fontSize: 18.sp)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Rating",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => FittedBox(
                // জায়গা বেশি নিলে অটো স্কেল করে ছোট করে নেবে
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    int starVal = index + 1;
                    return IconButton(
                      onPressed: () {
                        selectedRating.value = starVal;
                      },
                      icon: Icon(
                        index < selectedRating.value
                            ? Icons.star
                            : Icons.star_border,
                        color: const Color(0xFFEE7A1F),
                        size: 28.sp,
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write your feedback here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                isDense: true,
              ),
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (commentController.text.trim().isNotEmpty) {
                controller.createReview(
                  widget.storeId,
                  selectedRating.value,
                  commentController.text.trim(),
                  dialogContext,
                );
              } else {
                Get.snackbar(
                  "Warning",
                  "Please write something in comment",
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEE7A1F),
            ),
            child: const Text("Submit", style: TextStyle(color: Colors.white)),
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
        return "${diff.inMinutes} minutes, ago";
      } else {
        return "Just now";
      }
    } catch (e) {
      return dateStr;
    }
  }

  static String formatDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr).toLocal();
      return DateFormat('d MMM yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }
}
