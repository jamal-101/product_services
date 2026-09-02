import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/account_section/presentation/screen/OperatingHoursScreen.dart';
import 'package:product_service/features/auth_flow/presentation/controller/auth_controller.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../config/route/app_route.dart';
import '../../../../services/storage/storage_service.dart';
import '../../../my_add/presentation/screen/my_add_screen.dart';
import '../../../profile_section/presentation/controller/profile_controller.dart';
import '../../../profile_section/presentation/screen/store_creation/presentation/screen/transection_history_screen.dart';

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
                        if (authController.selectedRole.value == 'seller') ...[
                          _buildGrowthPlanBanner(),
                        ],
                        _buildSectionTitle(AppString.accounT),
                        _buildCardMenuItem(
                          Icons.person_outline,
                          AppString.editeProfile,
                          AppString.nameEx,
                              () {
                            Get.toNamed(AppRoutes.editProfileScreen);
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.credit_card,
                          AppString.identity,
                          AppString.uploadId,
                              () {
                            Get.toNamed(AppRoutes.identityVerificationScreen);
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.lock_outline,
                          AppString.changePassword,
                          AppString.updateYour,
                              () {
                            Get.toNamed(AppRoutes.changePasswordScreen);
                          },
                        ),
                        if (authController.selectedRole.value != 'seller') ...[
                          _buildCardMenuItem(
                            Icons.store,
                            "Create Store",
                            "Create your store",
                                () {
                              Get.toNamed(AppRoutes.myStore);
                            },
                          ),
                        ],
                        if (authController.selectedRole.value == 'seller') ...[
                          _buildSectionTitle(AppString.storeSetting),
                          _buildCardMenuItem(
                            Icons.storefront_outlined,
                            AppString.branding,
                            AppString.nameDescription,
                                () {
                              Get.toNamed(
                                AppRoutes.editeBindingScreen,
                              );
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.phone_outlined,
                            AppString.contactDetails,
                            AppString.phoneWhatUp,
                                () {
                              Get.toNamed(AppRoutes.editContactDetailsScreen);
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.lock_clock,
                            "Operating Hours",
                            "09:00 AM – 09:00 PM (Mon - Sat)",
                                () {
                              Get.to(OperatingHoursScreen());
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.description_outlined,
                            AppString.legalDocuments,
                            AppString.tradeLicense,
                                () {
                              Get.toNamed(AppRoutes.editLegalDocumentsScreen);
                            },
                          ),
                          _buildCardMenuItem(
                            Icons.add_shopping_cart,
                            "My Adds",
                            "See your add",
                                () {
                              Get.to(MyAddScreen());
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],

                        SizedBox(height: 20.h),
                        _buildSectionTitle(AppString.settinG),
                        _buildCardMenuItem(
                          Icons.notifications_none,
                          AppString.notifications,
                          AppString.pushEmail,
                              () {
                            Get.toNamed(AppRoutes.notificationSettingScreen);
                          },
                        ),
                        SizedBox(height: 20.h),
                        _buildSectionTitle("BILLING"),
                        _buildCardMenuItem(
                          Icons.balance,
                          "Transaction History",
                          "Payments, receipts & Stripe invoices",
                              () {
                            Get.to(TransactionHistoryScreen());
                          },
                        ),

                        SizedBox(height: 20.h),
                        _buildSectionTitle(AppString.support),
                        _buildCardMenuItem(
                          Icons.help_outline,
                          AppString.helpAndSupport,
                          AppString.FAQand,
                              () {
                            Get.toNamed(AppRoutes.helpSupportScreen);
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.language,
                          "Language",
                          "Select Your Language",
                              () {

                          },
                        ),
                        _buildCardMenuItem(
                          Icons.logout,
                          AppString.logOut,
                          AppString.singOut,
                              () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                title: Text(
                                  "Log Out",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                content: Text(
                                  "Are you sure you want to log out?",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      "Cancel",
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
                                      "Yes, Logout",
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
                    backgroundImage: NetworkImage(
                      (userData?.profileImage != null &&
                          userData!.profileImage!.isNotEmpty)
                          ? "${ApiEndPoint.imageUrl}${userData.profileImage}"
                          : "https://via.placeholder.com/150",
                    ),
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

  Widget _buildGrowthPlanBanner() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A9B4A),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.diamond, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.growthPlan,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  "Renews on July 18, 2026 (\$49/mo)",
                  style: GoogleFonts.montserrat(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.subscriptionBillingScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                AppString.manage,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF2A9B4A),
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
