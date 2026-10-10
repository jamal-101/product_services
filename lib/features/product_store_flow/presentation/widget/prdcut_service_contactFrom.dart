import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../message_flow/presentation/controller/message_controller.dart';
import '../controller/productServiceDetailsController.dart';

class ProductServiceContactFrom extends StatelessWidget {
  const ProductServiceContactFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageController messageController = Get.put(MessageController());
    final ProductServiceDetailsController controller =
        Get.find<ProductServiceDetailsController>();

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
                final productStore =
                    controller.productModel.value.data?.storeId;
                final serviceStore =
                    controller.serviceModel.value.data?.storeId;
                final store = productStore ?? serviceStore;

                if (store != null) {
                  final dynamic storeData = store;

                  String sellerUserId = "";
                  try {
                    if (storeData.owner != null) {
                      sellerUserId = storeData.owner.toString();
                    }
                  } catch (_) {}

                  String storeId = "";
                  try {
                    storeId = (storeData.id ?? storeData.sId ?? "").toString();
                  } catch (_) {}

                  String storeName = "";
                  try {
                    storeName = (storeData.displayName ?? "Shop").toString();
                  } catch (_) {
                    storeName = "Shop";
                  }

                  messageController.createChat(
                    participantId: sellerUserId,
                    communicationType: "store",
                    referenceId: storeId,
                    shopName: storeName,
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
}
