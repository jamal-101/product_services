import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/features/product_store_flow/presentation/controller/store_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../message_flow/presentation/controller/message_controller.dart';

class ContactFooterWidget extends StatelessWidget {
  const ContactFooterWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final StoreDetailsController storeController = Get.find<StoreDetailsController>();
    final MessageController messageController = Get.put(MessageController());


    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                final storeData = storeController.storeDetailsModel.value.data?.store;
                if (storeData != null) {
                  String sellerUserId = storeData.owner?.sId ?? "";
                  messageController.createChat(
                    participantId: sellerUserId,
                    communicationType: "store",
                    referenceId: storeData.sId ?? "",
                    shopName: storeData.displayName ?? "Shop",
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "Store details not loaded yet",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
              label: Text(
                "Message Seller",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D7738),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black87, size: 20.sp),
      ),
    );
  }



}