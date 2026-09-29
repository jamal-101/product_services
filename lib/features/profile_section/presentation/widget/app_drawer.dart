import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/auth_flow/presentation/controller/auth_controller.dart';
import 'package:product_service/features/my_add/presentation/screen/my_add_screen.dart';
import 'package:product_service/features/profile_section/presentation/controller/profile_controller.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/privacy_and_policy.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/safety_guidelines.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/save_product_screen.dart';
import 'package:product_service/features/profile_section/presentation/screen/save_flow/presentation/screen/save_screen.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/screen/creat_new_store_step1.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/screen/my_store.dart';
import 'package:product_service/features/save/presentation/screen/save_store_screen.dart';
import 'package:product_service/utils/constants/app_images.dart';

import '../../../../services/storage/storage_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../save/presentation/screen/save_product_screen.dart';
import '../screen/save_flow/presentation/screen/saved_services.dart';
import '../screen/save_flow/presentation/screen/trems_and_condition.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final ProfileController profileController = Get.put(ProfileController());
    final bool isSeller = (LocalStorage.myRole == 'seller');
    return Drawer(
      width: 280.w,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Obx(() {
            final userData = profileController.profileModel.value.data;
            return Container(
              padding: EdgeInsets.only(
                top: 60.h,
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
              ),
              color: const Color(0xFFF1FDF5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: (userData?.profileImage != null &&
                        userData!.profileImage!.isNotEmpty)
                        ? NetworkImage("${ApiEndPoint.imageUrl}${userData.profileImage}")
                    as ImageProvider
                        : const AssetImage("assets/images/buyer.png"),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    userData?.name ?? "User Name",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    isSeller ? "Seller Mode" : "Buyer Mode",
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF27AE60),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      authController.toggleRole();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF27AE60),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.swap_horiz,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            (authController.selectedRole.value == 'seller')
                                ? "Switch to Buyer Mode"
                                : "Switch to Seller Mode",
                            style: GoogleFonts.montserrat(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                if (!isSeller) ...[
                  _buildMenuItem(context, Icons.store, "Create Store"),
                  _buildMenuItem(context, Icons.storefront_outlined, "Save Store"),
                  _buildMenuItem(context, Icons.bookmark_border, "Saved Products"),
                ],
                if(isSeller) ...[
                  _buildMenuItem(context, Icons.description_outlined, "Safety Guidelines"),
                  _buildMenuItem(context, Icons.privacy_tip_outlined, "Privacy Policy"),
                  _buildMenuItem(context, Icons.article_outlined, "Terms & Conditions"),
                ],

              ],
            ),
          ),
          Divider(
            color: const Color(0xFFE5E7EB),
            thickness: 1.0,
            height: 1.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.loginScreen);
              },
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 10.w),
                  Text(
                    "Log Out",
                    style: GoogleFonts.montserrat(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(
        title,
        style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.black),
      ),
      onTap: () {

        Navigator.pop(context);

        switch (title) {
          case "Create Store":
            Get.toNamed(AppRoutes.myStore);
            break;
          case "Save Store":
           Get.to(()=>SaveStoreScreen());
            break;
          case "Saved Products":
            Get.to(() => SavedProductScreen());
            break;
          // case "Saved Services":
          //   Get.to(() => const SavedServicesScreen());
          //   break;
          case "Safety Guidelines":
            Get.to(() => SafetyGuidelines());
            break;
          case "Privacy Policy":
            Get.to(() => const PrivacyAndPolicy());
            break;
          case "Terms & Conditions":
            Get.to(() => TremsAndCondition());
            break;
          default:
            break;
        }
      },
    );
  }
}
