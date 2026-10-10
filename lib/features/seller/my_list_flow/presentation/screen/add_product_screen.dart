import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../controller/add_product_controller.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController controller = Get.put(AddProductController());
    final bool isService = controller.storeType == "service_store";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          controller.isEditMode
              ? (isService ? AppString.editService.tr : AppString.editProduct.tr)
              : (isService ? AppString.addService.tr : AppString.addProduct.tr),
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => controller.pickImage(),
              child: Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Obx(() {
                  if (controller.selectedImage.value != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        controller.selectedImage.value!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }

                  if (controller.existingImageUrl.value.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        controller.existingImageUrl.value,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.broken_image, color: Colors.grey),
                            SizedBox(height: 4.h),
                            Text(
                              "Failed to load image",
                              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.perm_media_outlined, color: Colors.orange),
                      SizedBox(height: 8.h),
                      Text(
                        AppString.tapToUploadImage.tr,
                        style: GoogleFonts.montserrat(
                          color: Colors.orange,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Photos: 0/6 : ${AppString.chooseMainPhotoFirst.tr}",
                        style: GoogleFonts.montserrat(
                          fontSize: 10.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 20.h),
            _buildCardContainer(
              child: _buildTextField(
                isService ? AppString.serviceTitle.tr : AppString.productTitle.tr,
                isService ? AppString.serviceTitleHint.tr : AppString.productTitleHint.tr,
                controller.titleController,
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: _buildCardContainer(
                    child: _buildTextField(
                      "${AppString.activePrice.tr} (\$)",
                      "149.99",
                      controller.activePriceController,
                      isNumber: true,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildCardContainer(
                    child: _buildTextField(
                      "${AppString.originalPrice.tr} (\$)",
                      "159.99",
                      controller.originalPriceController,
                      isNumber: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            _buildCardContainer(
              child: _buildTextArea(
                AppString.description.tr,
                AppString.tellCustomersAboutItem.tr,
                controller.descriptionController,
              ),
            ),
            SizedBox(height: 15.h),
            if (!isService) ...[
              _buildCardContainer(
                child: _buildTextArea(
                  AppString.additionalInform.tr,
                  AppString.weightSizeGuideHint.tr,
                  controller.extraInfoController,
                ),
              ),
            ] else ...[
              _buildCardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.whatsIncluded.tr,
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => controller.addWhatsIncludedField(),
                          icon: const Icon(Icons.add, size: 16, color: Colors.green),
                          label: Text(
                            AppString.addPoint.tr,
                            style: TextStyle(color: Colors.green, fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.whatsIncludedList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green, size: 20),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: TextField(
                                  controller: controller.whatsIncludedList[index],
                                  decoration: InputDecoration(
                                    hintText: AppString.featureItemHint.tr,
                                    filled: true,
                                    fillColor: const Color(0xFFF4F4F4),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                onPressed: () => controller.removeWhatsIncludedField(index),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
            ],
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null : () => controller.submitData(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  controller.isEditMode
                      ? (isService ? AppString.updateService.tr : AppString.updateProduct.tr)
                      : (isService ? AppString.publishService.tr : AppString.publishProduct.tr),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController textController, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: textController,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String hint, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: textController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}