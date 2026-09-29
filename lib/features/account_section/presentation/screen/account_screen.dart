import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/account_section/presentation/screen/OperatingHoursScreen.dart';
import 'package:product_service/features/account_section/presentation/screen/privacy_policy_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/safety_guidelines.dart';
import 'package:product_service/features/account_section/presentation/screen/terms_and_conditation_screen.dart';
import 'package:product_service/features/auth_flow/presentation/controller/auth_controller.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_images.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../config/route/app_route.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../my_add/presentation/screen/my_add_screen.dart';
import '../../../profile_section/presentation/controller/profile_controller.dart';
import '../../../profile_section/presentation/screen/store_creation/presentation/screen/transection_history_screen.dart';
import '../controller/delete_account_controller.dart';
import 'language_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final profileController = Get.put(ProfileController());
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 4),
      body: Obx(() {
        final userData = profileController.profileModel.value.data;

        return Stack(
          children: [
            Container(height: 180.h, color: const Color(0xFF27AE60)),
            Padding(
              padding: EdgeInsets.only(top: 130.h),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userData?.name ?? "User Name",
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            SizedBox(width: 5.w),
                            if (userData?.verified ?? false)
                              Icon(
                                Icons.verified,
                                color: const Color(0xFF27AE60),
                                size: 18.sp,
                              ),
                          ],
                        ),
                        Text(
                          userData?.email ?? "email@example.com",
                          style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      children: [
                        // if (authController.selectedRole.value == 'seller') ...[
                        //   _buildGrowthPlanBanner(),
                        // ],
                        _buildSectionTitle('accounT'.tr),
                        // _buildCardMenuItem(
                        //   Icons.person_outline,
                        //  'editeProfile'.tr,
                        //   'nameEx'.tr,
                        //       () {
                        //         final profileData = profileController.profileModel.value.data;
                        //         Get.toNamed(
                        //           AppRoutes.editProfileScreen,
                        //           arguments: {
                        //             'name': userController.userData.value.name ?? '',
                        //             'email': userController.userData.value.email ?? '',
                        //             'phone': userController.userData.value.phone ?? '',
                        //             'postalCode': userController.userData.value.postalCode ?? '',
                        //             'state': userController.userData.value.state ?? '',
                        //             'address': userController.userData.value.address ?? '',
                        //             'profileImage': userController.userData.value.profileImage ?? '',
                        //           },
                        //         );
                        //   },
                        // ),

                        _buildCardMenuItem(
                          Icons.person_outline,
                          'editeProfile'.tr,
                          'nameEx'.tr,
                              () {
                            final profileData = profileController.profileModel.value.data;

                            Get.toNamed(
                              AppRoutes.editProfileScreen,
                              arguments: {
                                'name': profileData?.name ?? '',
                                'email': profileData?.email ?? '',
                                'phone': profileData?.phone ?? '',
                                'postalCode': profileData?.postalCode ?? '',
                                'state': profileData?.state ?? '',
                                'city': profileData?.location?.city ?? profileData?.state ?? '',
                                'address': profileData?.address ?? profileData?.location?.address ?? '',
                                'canton': profileData?.location?.canton ?? '',
                                'country': profileData?.location?.country ?? '',
                                'neighborhood': profileData?.location?.neighborhood ?? '',
                                'province': profileData?.location?.province ?? '',
                                'sector': profileData?.location?.sector ?? '',
                                'profileImage': profileData?.profileImage ?? '',
                              },
                            );
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.credit_card,
                          'identity'.tr,
                          'uploadId'.tr,
                              () {
                            Get.toNamed(AppRoutes.identityVerificationScreen);
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.lock_outline,
                          'changePassword'.tr,
                          'updateYour'.tr,
                              () {
                            Get.toNamed(AppRoutes.changePasswordScreen);
                          },
                        ),
                        if (authController.selectedRole.value != 'seller') ...[
                          _buildCardMenuItem(
                            Icons.store,
                            'createStore'.tr,
                            'createYourStore'.tr,
                                () {
                              Get.toNamed(AppRoutes.myStore);
                            },
                          ),
                        ],
                        if (authController.selectedRole.value == 'seller') ...[
                          _buildSectionTitle('storeSetting'.tr),
                          _buildCardMenuItem(
                            Icons.storefront_outlined,
                            'branding'.tr,
                            'nameDescription'.tr,
                                () {
                              Get.toNamed(
                                AppRoutes.editeBindingScreen,
                              );
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.phone_outlined,
                            'contactDetails'.tr,
                            'phoneWhatUp'.tr,
                                () {
                              Get.toNamed(AppRoutes.editContactDetailsScreen);
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.lock_clock,
                            'operatingHours'.tr,
                            'operatingHoursTime'.tr,
                                () {
                              Get.to(OperatingHoursScreen());
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.description_outlined,
                            'legalDocuments'.tr,
                            'tradeLicense'.tr,
                                () {
                              Get.toNamed(AppRoutes.editLegalDocumentsScreen);
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.add_shopping_cart,
                            'myAdds'.tr,
                            'seeYourAdd'.tr,
                                () {
                              Get.to(MyAddScreen());
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],

                        SizedBox(height: 20.h),
                        _buildSectionTitle('settinG'.tr),
                        _buildCardMenuItem(
                          Icons.notifications_none,
                          'notifications'.tr,
                          'pushEmail'.tr,
                              () {
                            Get.toNamed(AppRoutes.notificationSettingScreen);
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildSectionTitle("BILLING"),
                        _buildCardMenuItem(
                          Icons.balance,
                          'transactionHistory'.tr,
                          'payments,receipts&Stripeinvoices'.tr,
                              () {
                            Get.to(TransactionHistoryScreen());
                          },
                        ),

                        SizedBox(height: 20.h),
                        _buildSectionTitle('support'.tr),
                        _buildCardMenuItem(
                          Icons.help_outline,
                          'helpAndSupport'.tr,
                          AppString.FAQand.tr,
                              () {
                            Get.toNamed(AppRoutes.helpSupportScreen);
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildCardMenuItem(
                          Icons.language,
                          "language".tr,
                          "selectLanguage".tr,
                              () {
                            Get.to(() => const LanguageScreen());
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.security,
                          "Safety Guidelines",
                          "Rules and regulations for your safety",
                              () {
                            Get.to(() => const SafetyGuidelinesScreen());
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.lock_outline,
                          "Privacy Policy",
                          "Your privacy and data security matter",
                              () {
                            Get.to(() => const PrivacyPolicyScreen());
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.article,
                          "Terms & Conditions",
                          "Read our terms of service",
                              () {
                            Get.to(() => const TermsConditaionScreen());
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.delete_forever_outlined,
                          "Delete Account",
                          "Permanently delete your account and data",
                              () {
                            final DeleteAccountController deleteController = Get.put(DeleteAccountController());
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                title: Text(
                                  'Delete Account',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Please enter your password to confirm account deletion.',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),

                                    // পাসওয়ার্ড ইনপুট ফিল্ড এবং হাইড/শো আইকন যুক্ত করা
                                    Obx(() => TextField(
                                      controller: deleteController.passwordController,
                                      obscureText: deleteController.isPasswordHidden.value,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: GoogleFonts.montserrat(fontSize: 14.sp),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            deleteController.isPasswordHidden.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20.sp,
                                          ),
                                          onPressed: deleteController.togglePasswordVisibility,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Obx(() => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    onPressed: deleteController.isLoading.value
                                        ? null
                                        : () async {
                                      // আপনার তৈরি করা ডিলিট এপিআই কল ফাংশন
                                      await deleteController.deleteAccountApiCall();
                                    },
                                    child: deleteController.isLoading.value
                                        ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                        : Text(
                                      'Delete',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            );
                          },
                          isLogout: true, // এটি দিলে আইকন এবং ব্যাকগ্রাউন্ড লাল (Red) কালার হয়ে যাবে
                        ),

                        _buildCardMenuItem(
                          Icons.logout,
                          'logOut'.tr,
                           'singOut'.tr,
                              () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                title: Text(
                                  'logOutTitle'.tr,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                content: Text(
                                  'logOutMessage'.tr,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'cancel'.tr,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await LocalStorage.removeAllPrefData();
                                      Get.offAllNamed(AppRoutes.loginScreen);
                                    },
                                    child: Text(
                                      'yesLogout'.tr,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          isLogout: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 90.h,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 42.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 38.r,
                    backgroundImage: (userData?.profileImage != null &&
                            userData!.profileImage!.isNotEmpty)
                        ? NetworkImage(
                            "${ApiEndPoint.imageUrl}${userData.profileImage}",
                          ) as ImageProvider
                        : const AssetImage(AppImages.buyerImage),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 5.w, top: 10.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildCardMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: (isLogout ? Colors.red : Colors.green).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.green,
            size: 20.sp,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          color: Color(0xFF7A818F),
          fontWeight: FontWeight.w500,
        ),
        ),
        trailing: Icon(Icons.chevron_right,size: 28.sp, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  // Widget _buildGrowthPlanBanner() {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 20.h),
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF2A9B4A),
  //       borderRadius: BorderRadius.circular(15.r),
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(8.w),
  //           decoration: BoxDecoration(
  //             color: Colors.white.withValues(alpha: 0.2),
  //             shape: BoxShape.circle,
  //           ),
  //           child: const Icon(Icons.diamond, color: Colors.white, size: 20),
  //         ),
  //         SizedBox(width: 12.w),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'growthPlan'.tr,
  //                 style: GoogleFonts.montserrat(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 14.sp,
  //                 ),
  //               ),
  //               Text(
  //                 "Renews on July 18, 2026 (\$49/mo)",
  //                 style: GoogleFonts.montserrat(
  //                   color: Colors.white.withValues(alpha: 0.9),
  //                   fontSize: 11.sp,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             Get.toNamed(AppRoutes.subscriptionBillingScreen);
  //           },
  //           child: Container(
  //             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8.r),
  //             ),
  //             child: Text(
  //               'manage'.tr,
  //               style: GoogleFonts.montserrat(
  //                 color: const Color(0xFF2A9B4A),
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 10.sp,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
