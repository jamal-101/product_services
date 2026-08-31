import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../model/rivew_model.dart';

class ReviewController extends GetxController {
  var isLoading = false.obs;
  var reviewModel = RivewModel().obs;


  Future<void> fetchReviews(String storeId) async {
    try {
      isLoading.value = true;
      final response = await ApiService.get('/reviews/$storeId');

      if (response.isSuccess) {
        if (response.data is Map<String, dynamic>) {
          reviewModel.value = RivewModel.fromJson(response.data as Map<String, dynamic>);
        } else {
          debugPrint("Error: Response data is null or not in expected format.");
        }
      } else {
        debugPrint("API Failed: ${response.message}");
      }
    } catch (e, stackTrace) {
      debugPrint("Exception: $e");
      debugPrint("StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOwnerReply(String reviewId, String commentText, String storeId) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> bodyData = {
        "comment": commentText,
      };

      final response = await ApiService.patch(
        '/reviews/$reviewId/owner-reply',
        body: bodyData,
      );

      if (response.isSuccess) {
        Get.snackbar(
          "Success",
          "Reply sent successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // await fetchReviews(storeId);

      } else {
        String errorMsg = "Failed to send reply";
        if (response.data['message'] != null) {
          errorMsg = response.data['message'];
        }

        Get.snackbar(
          "Error",
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error in sendOwnerReply: $e");
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> createReview(String storeId, int rating, String comment, BuildContext context) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> bodyData = {
        "storeId": storeId,
        "rating": rating,
        "comment": comment,
      };

      final response = await ApiService.post(
        '/reviews',
        body: bodyData,
      );

      if (response.isSuccess) {
        Navigator.pop(context); // ডায়ালগ বন্ধ করার জন্য
        Get.snackbar(
          "Success",
          "Review submitted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // রিভিউ সাবমিট হওয়ার পর লিস্ট রিফ্রেশ করার জন্য
        await fetchReviews(storeId);
      } else {
        String errorMsg = "Failed to submit review";
        if (response.data != null && response.data['message'] != null) {
          errorMsg = response.data['message'];
        }

        Get.snackbar(
          "Error",
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Error in createReview: $e");
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

}