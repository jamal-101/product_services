import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/app_color.dart';
import '../../../account_section/presentation/controller/language_controller.dart';
import '../controller/onboarding_controller.dart';
import '../model/onboarding_model.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});


  List<OnboardingModel> get onboardingData => [
    OnboardingModel(
      titleFirst: 'find'.tr,
      titleHighlight: ' trusted '.tr,
      titleLast: 'localStores'.tr,
      description: 'findLocalStoresDesc'.tr,
      image: AppImages.splash1,
    ),
    OnboardingModel(
      titleFirst: 'chat'.tr,
      titleHighlight: ' ${AppString.directly.tr} ',
      titleLast: 'withSellers'.tr,
      description: AppString.description2.tr,
      image: AppImages.splash2,
    ),
    OnboardingModel(
      titleFirst: AppString.promoteYour.tr,
      titleHighlight: ' ${AppString.business.tr}',
      titleLast: "",
      description: AppString.description3.tr,
      image: AppImages.splash3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final LanguageController langController = Get.put(LanguageController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 105.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 10.h, bottom: 10.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Obx(() {
              bool isSpanish = langController.currentLang.value == 'Spanish';
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => langController.changeLanguage('es', 'Spanish'),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isSpanish ? const Color(0xFF10B981) : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "ES",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: isSpanish ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () => langController.changeLanguage('en', 'English'),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: !isSpanish ? const Color(0xFF10B981) : Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "EN",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: !isSpanish ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        actions: [
          Obx(
                () => controller.currentIndex.value < onboardingData.length - 1
                ? Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.loginScreen);
                },
                child: Text(
                  AppString.skip.tr,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: controller.updateIndex,
                  itemBuilder: (context, index) {
                    final item = onboardingData[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 419.h,
                            width: 253.w,
                            child: Image.asset(item.image, fit: BoxFit.contain),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            children: [
                              TextSpan(
                                text: item.titleFirst,
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColor.textDark,
                                ),
                              ),
                              TextSpan(
                                text: item.titleHighlight,
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColor.accent,
                                ),
                              ),
                              TextSpan(
                                text: item.titleLast,
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColor.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.description,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.sp,
                            color: AppColor.textLight,
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: 6.w),
                          height: 6.h,
                          width: controller.currentIndex.value == index
                              ? 24.w
                              : 6.w,
                          decoration: BoxDecoration(
                            color: controller.currentIndex.value == index
                                ? AppColor.primary
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () =>
                          controller.nextStep(onboardingData.length),
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.currentIndex.value ==
                                      onboardingData.length - 1
                                  ? AppString.getStarted.tr
                                  : AppString.next.tr,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
