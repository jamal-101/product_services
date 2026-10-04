import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_color.dart';
import '../controller/store_creation_controller.dart';
import '../widget/common_widget.dart';
import 'creat_new_store_step3.dart';
import 'package:image_picker/image_picker.dart' as img_picker;

class CreateNewStoreStep2 extends StatelessWidget {
  const CreateNewStoreStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreCreationController controller =
        Get.find<StoreCreationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: AppColor.appBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        title: const Text(
          "Create New Store",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop Identity",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            SizedBox(height: 5.h),
            Text(
              "Let's start with the basics — what is your shop?",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 25.h),

            _buildTextField(
              "Display Shop Name",
              "e.g. Le Reve Organics",
              controller.nameController,
            ),
            _buildTextField(
              "Description",
              "Describe what you sell...",
              controller.descriptionController,
              maxLines: 3,
            ),
            _buildCategoryDropdownField(
              controller,
              () => _showCategoryBottomSheet(context, controller),
            ),

            _buildDropdownField(
              "Time zone / City",
              controller.selectedCityName,
              () {
                controller.fetchCitiesOnDemand();
                _showCityBottomSheet(context, controller);
              },
            ),

            SizedBox(height: 15.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Branding *",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFECECF0)),
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => buildUploadBox(
                          "Upload Logo\nSquare, 500x500 px",
                          controller.logoFile.value,
                          'logo',
                          controller,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Obx(
                        () => buildUploadBox(
                          "Upload Cover\n6:9 ratio",
                          controller.coverImageFile.value,
                          'cover',
                          controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            buildNextButton(() {
              if (controller.nameController.text.isNotEmpty &&
                  controller.selectedCategoryId.value.isNotEmpty) {
                Get.to(() => const CreateNewStoreStep3());
              } else {
                Get.snackbar(
                  "Required",
                  "Please fill in all required fields and select a category.",
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController textController, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: textController,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFECECF0)),
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildCategoryDropdownField(
    StoreCreationController controller,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFECECF0)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.selectedCategoryId.value.isEmpty) {
                      return Text(
                        controller.selectedCategoryName.value,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                        ),
                      );
                    }

                    final selectedCat = controller.categories.firstWhere(
                      (cat) =>
                          cat['_id'] == controller.selectedCategoryId.value,
                      orElse: () => null,
                    );

                    final name = selectedCat != null
                        ? (selectedCat['name'] ?? '')
                        : controller.selectedCategoryName.value;
                    final description = selectedCat != null
                        ? (selectedCat['description'] ?? '')
                        : '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        if (description.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    RxString selectedValue,
    VoidCallback onTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFECECF0)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    selectedValue.value,
                    style: TextStyle(
                      color: selectedValue.value.contains("Select")
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  void _showCategoryBottomSheet(
    BuildContext context,
    StoreCreationController controller,
  ) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMoreCategories();
      }
    });

    Get.bottomSheet(
      Container(
        height: 400.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Obx(() {
          if (controller.isLoading.value && controller.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemCount:
                controller.categories.length +
                (controller.isCategoryLoadingMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.categories.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              final cat = controller.categories[index];
              return ListTile(
                title: Text(cat['name'] ?? ''),
                subtitle: Text(
                  cat['description'] ?? '',
                ),
                onTap: () {
                  controller.selectedCategoryName.value = cat['name'];
                  controller.selectedCategoryId.value = cat['_id'];
                  Get.back();
                },
              );
            },
          );
        }),
      ),
      isScrollControlled: true,
    );
  }

  void _showCityBottomSheet(
    BuildContext context,
    StoreCreationController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.cities.length,
            itemBuilder: (context, index) {
              final city = controller.cities[index];
              return ListTile(
                title: Text("${city['city']}, ${city['country']}"),
                onTap: () {
                  controller.selectedCityName.value =
                      "${city['city']}, ${city['country']}";
                  controller.selectedCityId.value = city['_id'];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildUploadBox(
    String label,
    File? file,
    String type,
    StoreCreationController controller,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _showImageSourceBottomSheet(type, controller);
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10.r),
          dashPattern: const [6, 4],
          color: const Color(0xFFECECF0),
          strokeWidth: 1.5,
          child: Container(
            height: 110.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAF7),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: file != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.file(
                        file,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.grey.shade600,
                          size: 28.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceBottomSheet(
    String type,
    StoreCreationController controller,
  ) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                "Select Image Source",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFF2A9B4A),
              ),
              title: const Text("Gallery"),
              onTap: () {
                Get.back();
                controller.pickImage(type, img_picker.ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF2A9B4A)),
              title: const Text("Camera"),
              onTap: () {
                Get.back();
                controller.pickImage(type, img_picker.ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
