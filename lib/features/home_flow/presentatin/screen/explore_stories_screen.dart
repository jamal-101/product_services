import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/home_flow/presentatin/screen/features_stories_screen.dart';
import 'package:product_service/utils/constants/app_color.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';
import '../controller/explore_store_controller.dart';
import '../widget/city_dialog.dart';

class ExploreStoriesScreen extends StatelessWidget {
  const ExploreStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreStoreController controllers = Get.put(
      ExploreStoreController(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: AppColor.appBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: AppString.explore,
                    style: GoogleFonts.plusJakartaSans(color: Colors.black),
                  ),
                  TextSpan(
                    text: AppString.stores,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFFE67E22),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildTopBarActions(controllers),
          ],
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
                      if (!controllers.isListViewSelected.value) {
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
                                controllers.isProductStoreSelected.value,
                                onTap: () => controllers.toggleStoreType(true),
                              ),
                            ),
                            Expanded(
                              child: _buildToggleButton(
                                title: AppString.servicesProvider,
                                isSelected:
                                !controllers.isProductStoreSelected.value,
                                onTap: () => controllers.toggleStoreType(false),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),
                    TextFormField(
                      onChanged: (value) {
                        controllers.updateSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: AppString.searchStores,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        fillColor: const Color(0xFFF5F5F7),
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
                          Obx(() => _buildFilterChip(
                              Icons.location_on_outlined,
                              controllers.selectedCity.value.isEmpty
                                  ? "City"
                                  : controllers.selectedCity.value,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.r),
                                    ),
                                  ),
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: SizedBox(
                                      height: 0.5.sh,
                                      child: CityDialog(
                                        selectedCity:
                                        controllers.selectedCity.value,
                                        onCitySelected: (newCity) {
                                          controllers.updateCity(newCity);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Open Now ফিল্টার চিপ
                          Obx(
                                () => _buildFilterChip(
                              Icons.access_time_rounded,
                              "Open now",
                              isSelected: controllers.isOpenNow.value,
                              onTap: () {
                                controllers.toggleOpenNow();
                              },
                            ),
                          ),

                          // রেটিং ড্রপডাউন মেনু
                          Obx(
                                () => PopupMenuButton<String>(
                              onSelected: (String ratingValue) {
                                controllers.updateRating(ratingValue);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: '1',
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 8),
                                      Text('1 Star'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: '2',
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 8),
                                      Text('2 Stars'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: '3',
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 8),
                                      Text('3 Stars'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: '4',
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 8),
                                      Text('4 Stars'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: '5',
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 8),
                                      Text('5 Stars'),
                                    ],
                                  ),
                                ),
                              ],
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: controllers.selectedRatingEnum.value != null
                                      ? const Color(0xFF2C3E50)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: const Color(0xFFECECF0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_border,
                                      size: 14.w,
                                      color: controllers.selectedRatingEnum.value != null
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      controllers.selectedRatingEnum.value == null
                                          ? "Rating"
                                          : "${controllers.selectedRatingEnum.value.toString().split('.').last} Star",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12.sp,
                                        color: controllers.selectedRatingEnum.value != null
                                            ? Colors.white
                                            : Colors.black54,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 16.w,
                                      color: controllers.selectedRatingEnum.value != null
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Obx(() {
                      if (controllers.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: const CircularProgressIndicator(
                              color: Color(0xFFE67E22),
                            ),
                          ),
                        );
                      }

                      if (!controllers.isListViewSelected.value) {
                        return _buildMapViewContent();
                      }

                      if (controllers.isProductStoreSelected.value) {
                        if (controllers.productStoreList.isEmpty) {
                          return _buildEmptyState();
                        }
                        return ListView.builder(
                          itemCount: controllers.productStoreList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var store = controllers.productStoreList[index];
                            return _buildStoreListItem(
                              title: store.displayName ?? "No Name",
                              subtitle: "${store.categoryId?.name ?? 'Store'} • ${store.phone ?? ''}",
                              rating: store.averageRating?.toString() ?? "0.0",
                              logoBg: const Color(0xFFE67E22),
                            );
                          },
                        );
                      } else {
                        if (controllers.serviceStoreList.isEmpty) {
                          return _buildEmptyState();
                        }
                        return ListView.builder(
                          itemCount: controllers.serviceStoreList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var store = controllers.serviceStoreList[index];
                            return _buildStoreListItem(
                              title: store.displayName ?? "No Name",
                              subtitle: "${store.categoryId?.name ?? 'Service'} • ${store.phone ?? ''}",
                              rating: store.averageRating?.toString() ?? "0.0",
                              logoBg: const Color(0xFF9B59B6),
                            );
                          },
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE67E22) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black54,
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
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
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

  Widget _buildStoreListItem({
    required String title,
    required String subtitle,
    required String rating,
    required Color logoBg,
  }) {
    final ExploreStoreController controllers = Get.find<ExploreStoreController>();
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.storeDetailsPage,
          arguments: controllers.isProductStoreSelected.value,
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
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
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
                      rating,
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Text(
          "No stores found",
          style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildTopBarActions(ExploreStoreController controllers) {
    return Obx(
          () => Row(
        children: [
          if (controllers.isListViewSelected.value)
            GestureDetector(
              onTap: () {
                Get.to(() => const FeaturesStoriesScreen());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 16.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      AppString.saved,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(width: 8.w),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                _buildToggleIconButton(
                  child: Icon(
                    Icons.list,
                    size: 20.sp,

                    color: controllers.isListViewSelected.value
                        ? Colors.white
                        : Colors.grey,
                  ),
                  isSelected: controllers.isListViewSelected.value,
                  onTap: () => controllers.toggleView(true),
                ),
                _buildToggleIconButton(
                  child: Text(
                    "Map",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: !controllers.isListViewSelected.value
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                  isSelected: !controllers.isListViewSelected.value,
                  onTap: () => controllers.toggleView(false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleIconButton({
    required Widget child,
    required bool isSelected,
    required VoidCallback onTap,
  }) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: child,
      ),
    );
  }

  Widget _buildMapViewContent() {
    return SizedBox(
      height: 500.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(40.4168, -3.7038),
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {},
          markers: {
            const Marker(
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
