import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/my_store_controller.dart';

class AboutWidgetMe extends StatelessWidget {
  const AboutWidgetMe({super.key});

  @override
  Widget build(BuildContext context) {
    final MyStoreController controller = Get.find<MyStoreController>();
    final RxBool isExpanded = false.obs;

    return Obx(() {
      final storeData = controller.myStoreModel.value?.data;

      String description = storeData?.description ?? "No description available";
      String location = storeData?.cityId?.city ?? "N/A";
      String phone = storeData?.phone ?? "N/A";
      String email = storeData?.email ?? "N/A";

      return SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w, bottom: 100.h),
        child: Column(
          children: [
            _buildInfoContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        maxLines: isExpanded.value ? null : 3,
                        overflow: isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          isExpanded.value = !isExpanded.value;
                        },
                        child: Text(
                          isExpanded.value ? "Read less ←" : "Read more →",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _buildInfoContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  _buildContactRow(Icons.location_on_outlined, location),
                  _buildContactRow(Icons.phone_outlined, phone),
                  _buildContactRow(Icons.email_outlined, email),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}