import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../widget/city_dialog.dart';
import '../widget/filtter_bottom_sheet.dart';

class FeaturesStoriesScreen extends StatelessWidget {
  const FeaturesStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Center(
          child: Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5EF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          AppString.featuredStores,
          style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (!controller.isListViewSelected.value) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildToggleButton(
                                title: AppString.productsStores,
                                isSelected:
                                controller.isProductStoreSelected.value,
                                onTap: () => controller.toggleStoreType(true),
                              ),
                            ),
                            Expanded(
                              child: _buildToggleButton(
                                title: AppString.servicesProvider,
                                isSelected:
                                !controller.isProductStoreSelected.value,
                                onTap: () => controller.toggleStoreType(false),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: AppString.searchStores,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        fillColor:  Color(0xFFF5F5F7),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildFilterChip(
                            Icons.tune,
                            AppString.allFilters,
                            isSelected: true,
                            onTab: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>  FilterBottomSheet(),
                              );
                            },
                          ),
                          Obx(()=>
                            _buildFilterChip(
                              Icons.location_on_outlined,
                              controller.selectedCity.value,
                              onTab: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                                  ),
                                  builder: (context) => Wrap(
                                    children: [
                                      CityDialog(
                                        selectedCity: controller.selectedCity.value,
                                        onCitySelected: (newCity) => controller.updateCity(newCity),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          _buildFilterChip(Icons.star_border, "4.5+"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() {
                      if (!controller.isListViewSelected.value) {
                        return _buildMapViewContent();
                      }
                      if (controller.isProductStoreSelected.value) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader("A"),
                            _buildStoreListItem(
                              "Anytime",
                              "Electronics • Barcelona",
                              const Color(0xFFE67E22),
                            ),

                            _buildSectionHeader("C"),
                            _buildStoreListItem(
                              "Cocacole",
                              "Food • Barcelona",
                              const Color(0xFFC0392B),
                            ),
                            _buildSectionHeader("D"),
                            _buildStoreListItem(
                              "Dave",
                              "Electronics • Barcelona",
                              const Color(0xFF3498DB),
                            ),
                            _buildSectionHeader("H"),
                            _buildStoreListItem(
                              "Healixir",
                              "Electronics • Barcelona",
                              const Color(0xFF16A085),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader("B"),
                            _buildStoreListItem(
                              "Barber Shop",
                              "Grooming • Barcelona",
                              const Color(0xFF9B59B6),
                            ),
                            _buildSectionHeader("C"),
                            _buildStoreListItem(
                              "Cleaners Pro",
                              "Home Services • Barcelona",
                              const Color(0xFF1ABC9C),
                            ),
                            _buildSectionHeader("L"),
                            _buildStoreListItem(
                              "Laundry Hub",
                              "Services • Madrid",
                              const Color(0xFF34495E),
                            ),
                            _buildSectionHeader("P"),
                            _buildStoreListItem(
                              "Plumbing Experts",
                              "Repairs • Valencia",
                              const Color(0xFFE74C3C),
                            ),
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
     }) {
    final Color selectedBgColor = title.contains("🛍️")
        ? const Color(0xFF27AE60)
        : const Color(0xFFEE7A1F);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? selectedBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Color(0xFF7A818F),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
      IconData icon,
      String label, {
        bool isSelected = false,
        VoidCallback? onTab,
      }) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFECECF0)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14.w,
              color: isSelected ? Colors.white : Colors.black54,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String letter) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
      child: Row(
        children: [
          Text(
            letter,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.orange[800],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Divider(
              color: Colors.grey.withValues(alpha: 0.3),
              thickness: 1.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreListItem(String title, String subtitle, Color logoBg) {
    final HomeController controller = Get.put(HomeController());
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.storeDetailsPage,
          arguments: controller.isProductStoreSelected.value,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFECECF0)),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: logoBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: const Icon(
                Icons.store_mall_directory,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 2.w),
                    Text(
                      "4.9",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                const Icon(Icons.bookmark_border, color: Colors.grey, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTopBarActions(HomeController controller) {
  //   return Obx(
  //         () => Row(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20.r),
  //             border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(Icons.bookmark_border, size: 16.sp, color: Colors.grey),
  //               SizedBox(width: 4.w),
  //               Text(
  //                 AppString.saved,
  //                 style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(width: 8.w),
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(8.r),
  //             border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
  //           ),
  //           child: Row(
  //             children: [
  //               _buildToggleIconButton(
  //                 icon: Icons.list,
  //                 isSelected: controller.isListViewSelected.value,
  //                 onTap: () => controller.toggleView(true),
  //               ),
  //               _buildToggleIconButton(
  //                 icon: Icons.grid_view,
  //                 isSelected: !controller.isListViewSelected.value,
  //                 onTap: () => controller.toggleView(false),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildToggleIconButton({
  //   required IconData icon,
  //   required bool isSelected,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: EdgeInsets.all(8.w),
  //       decoration: BoxDecoration(
  //         color: isSelected ? const Color(0xFF2C3E50) : Colors.transparent,
  //         borderRadius: BorderRadius.circular(8.r),
  //       ),
  //       child: Icon(
  //         icon,
  //         size: 20.sp,
  //         color: isSelected ? Colors.white : Colors.grey,
  //       ),
  //     ),
  //   );
  // }



  Widget _buildMapViewContent() {
    return Container(
      height: 500.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(40.4168, -3.7038),
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {

          },
          markers: {
             Marker(
              markerId: MarkerId('store_1'),
              position: LatLng(40.4168, -3.7038),
              infoWindow: InfoWindow(title: 'Store Name'),
            ),
          },
          myLocationEnabled: true,
          zoomControlsEnabled: false,
        ),
      ),
    );
  }
}
