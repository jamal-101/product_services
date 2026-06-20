import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/features/auth_flow/presentation/controller/auth_controller.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../../../../config/route/app_route.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 3),
      body: Stack(
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
                            "Sazzad Chowdhury",
                            style: GoogleFonts.montserrat(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.verified,
                            color: const Color(0xFF27AE60),
                            size: 18.sp,
                          ),
                        ],
                      ),
                      Text(
                        "john@example.com",
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
                      _buildSectionTitle("ACCOUNT"),
                      _buildCardMenuItem(
                        Icons.person_outline,
                        "Edit Profile",
                        "Name, phone, email, address",
                        () {
                          Get.toNamed(AppRoutes.editProfileScreen);
                        },
                      ),
                      _buildCardMenuItem(
                        Icons.credit_card,
                        "Identity Verification",
                        "Upload ID document",
                        () {
                          Get.toNamed(AppRoutes.identityVerificationScreen);
                        },
                      ),
                      _buildCardMenuItem(
                        Icons.lock_outline,
                        "Change Password",
                        "Update your credentials",
                        () {
                          Get.toNamed(AppRoutes.changePasswordScreen);
                        },
                      ),
                      if (authController.selectedRole.value == 'seller') ...[
                        _buildSectionTitle("STORE SETTINGS"),
                        _buildCardMenuItem(
                          Icons.storefront_outlined,
                          "Branding",
                          "Name, Description, Category, Logo, Cover",
                          () {
                            Get.toNamed(
                              AppRoutes.editeBindingScreen,
                            );
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.phone_outlined,
                          "Contact Details",
                          "Phone, WhatsApp, Email, Map Pin Location",
                          () {
                            Get.toNamed(AppRoutes.editContactDetailsScreen);
                          },
                        ),
                        _buildCardMenuItem(
                          Icons.description_outlined,
                          "Legal Documents",
                          "Trade License, Business License, TIN Info",
                          () {
                            Get.toNamed(AppRoutes.editLegalDocumentsScreen);
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],

                      SizedBox(height: 20.h),
                      _buildSectionTitle("SETTINGS"),
                      _buildCardMenuItem(
                        Icons.notifications_none,
                        "Notifications",
                        "Push, email & SMS",
                        () {
                          Get.toNamed(AppRoutes.notificationSettingScreen);
                        },
                      ),

                      SizedBox(height: 20.h),
                      _buildSectionTitle("SUPPORT"),
                      _buildCardMenuItem(
                        Icons.help_outline,
                        "Help & Support",
                        "FAQ and contact us",
                        () {
                          Get.toNamed(AppRoutes.helpSupportScreen);
                        },
                      ),
                      _buildCardMenuItem(
                        Icons.logout,
                        "Logout",
                        "Sign out of your account",
                        () {
                          Get.offAllNamed(AppRoutes.loginScreen);
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
                  backgroundImage: const AssetImage(
                    'assets/images/profile.png',
                  ),
                ),
              ),
            ),
          ),
        ],
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
      margin: EdgeInsets.only(bottom: 12.h),
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
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.grey),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildGrowthPlanBanner() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A9B4A), // গ্রিন কালার
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
                  "Growth Plan Active",
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
                "MANAGE",
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
