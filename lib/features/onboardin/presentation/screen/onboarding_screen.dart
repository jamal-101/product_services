import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_images.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/onboarding_controller.dart';
import '../model/onboarding_model.dart';

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    titleFirst: "Find ",
    titleHighlight: "trusted\n",
    titleLast: "local stores",
    description: "Find and find local stores near you seller and shop to fulfill your regular needs",
    image: AppImages.splash1,
  ),
  OnboardingModel(
    titleFirst: "Chat ",
    titleHighlight: "directly\n",
    titleLast: "with sellers",
    description: "Chat directly with local store owners to verify and purchase items easily",
    image: AppImages.splash2,
  ),
  OnboardingModel(
    titleFirst: "Promote your\n",
    titleHighlight: "business",
    titleLast: "",
    description: "We promote your local business to local customers to grow your store easily",
    image: AppImages.splash3,
  ),
];

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(() => controller.currentIndex.value < onboardingData.length - 1
              ? Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: TextButton(
              onPressed: () => controller.skipToLast(onboardingData.length - 1),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
          )
              : const SizedBox.shrink()),
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
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            children: [
                              TextSpan(text: item.titleFirst, style: const TextStyle(color: AppColor.textDark)),
                              TextSpan(text: item.titleHighlight, style: const TextStyle(color: AppColor.accent)),
                              TextSpan(text: item.titleLast, style: const TextStyle(color: AppColor.textDark)),
                            ],
                          ),
                        ),
                        Text(
                          item.description,
                          style: TextStyle(
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
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: 6.w),
                        height: 6.h,
                        width: controller.currentIndex.value == index ? 24.w : 6.w,
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? AppColor.primary
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  )),
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
                      onPressed: () => controller.nextStep(onboardingData.length),
                      child: Obx(() => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.currentIndex.value == onboardingData.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(Icons.arrow_forward_outlined,color: Colors.white,)
                        ],
                      )),
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

