import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import '../../../../component/bottom_navBar/nav_bar..dart';

class ExploreStoriesScreen extends StatelessWidget {
  const ExploreStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(

      backgroundColor: const Color(0xFFFBFBFB),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
      ),
      // আপনার ExploreStoriesScreen-এর অ্যাপবারটি এভাবে পরিবর্তন করুন:

     appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        // 🟢 এখানে আপনার কাস্টম টাইটেল ডিজাইনটি করা হলো
        title: Row(
          children: [
            // বামপাশে "Explore Stores" টেক্সট
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                children: const [
                  TextSpan(text: "Explore ", style: TextStyle(color: Colors.black)),
                  TextSpan(text: "Stores", style: TextStyle(color: Color(0xFFE67E22))), // অরেঞ্জ কালার
                ],
              ),
            ),
            const Spacer(), // মাঝখানের ফাঁকা জায়গা পূরণের জন্য

            // ডানপাশে "Saved" বাটন এবং আইকন বাটন
            _buildTopBarActions(controller),
          ],
        ),
      ),
      body: SafeArea(

        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                "Featured Stores",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- টগল বাটন সেকশন ---
                    // বডির ভেতরে বা কন্টেন্টের শুরুতে যেখানে টগল বাটনটি আছে:
                    Obx(() {
                      // যদি ম্যাপ ভিউ হয় (controller.isListViewSelected.value == false),
                      // তবে এটি return করবে একটি খালি সাইজডবক্স (বা হাইড হয়ে যাবে)
                      if (!controller.isListViewSelected.value) {
                        return const SizedBox.shrink();
                      }

                      // অন্যথায় লিস্ট ভিউ হলে টগল বাটনটি দেখাবে
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
                                title: "🛍️ Products Stores",
                                isSelected: controller.isProductStoreSelected.value,
                                onTap: () => controller.toggleStoreType(true),
                              ),
                            ),
                            Expanded(
                              child: _buildToggleButton(
                                title: "🛠️ Services Providers",
                                isSelected: !controller.isProductStoreSelected.value,
                                onTap: () => controller.toggleStoreType(false),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),

                    // 🔍 Search Bar
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search stores & Service Providers",
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
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

                    // 🎚️ Filter Tags Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildFilterChip(Icons.tune, "All Filters", isSelected: true),
                          _buildFilterChip(Icons.location_on_outlined, "Madrid"),
                          _buildFilterChip(Icons.schedule, "Open now"),
                          _buildFilterChip(Icons.star_border, "4.5+"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // 🔤 ডাইনামিক স্টোর লিস্ট (Obx দিয়ে রিয়্যাক্টিভ করা হলো)
                    Obx(() {
                      if (!controller.isListViewSelected.value) {
                        return _buildMapViewContent();
                      }
                      if (controller.isProductStoreSelected.value) {
                        // 🛍️ Products সিলেক্টেড থাকলে এই ডেটাগুলো দেখাবে
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader("A"),
                            _buildStoreListItem("Anytime", "Electronics • Barcelona", const Color(0xFFE67E22)),

                            _buildSectionHeader("C"),
                            _buildStoreListItem("Cocacole", "Food • Barcelona", const Color(0xFFC0392B)),

                            _buildSectionHeader("D"),
                            _buildStoreListItem("Dave", "Electronics • Barcelona", const Color(0xFF3498DB)),

                            _buildSectionHeader("H"),
                            _buildStoreListItem("Healixir", "Electronics • Barcelona", const Color(0xFF16A085)),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader("B"),
                            _buildStoreListItem("Barber Shop", "Grooming • Barcelona", const Color(0xFF9B59B6)),

                            _buildSectionHeader("C"),
                            _buildStoreListItem("Cleaners Pro", "Home Services • Barcelona", const Color(0xFF1ABC9C)),

                            _buildSectionHeader("L"),
                            _buildStoreListItem("Laundry Hub", "Services • Madrid", const Color(0xFF34495E)),

                            _buildSectionHeader("P"),
                            _buildStoreListItem("Plumbing Experts", "Repairs • Valencia", const Color(0xFFE74C3C)),
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

  // --- 📦 হেল্পার উইজেটসমূহ ---

  Widget _buildToggleButton({required String title, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF27AE60) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(IconData icon, String label, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFECECF0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.w, color: isSelected ? Colors.white : Colors.black54),
          SizedBox(width: 4.w),
          Text(label, style: TextStyle(fontSize: 12.sp, color: isSelected ? Colors.white : Colors.black54)),
        ],
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
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800]
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
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.storeDetailsPage);
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
              decoration: BoxDecoration(color: logoBg, borderRadius: BorderRadius.circular(8.r)),
              child: const Icon(Icons.store_mall_directory, color: Colors.white),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text(subtitle, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
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
                    Text("4.9", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8.h),
                const Icon(Icons.bookmark_border, color: Colors.grey, size: 18),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _buildTopBarActions(HomeController controller) {
    return Obx(() => Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.bookmark_border, size: 16.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text("Saved", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ],
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
                  icon: Icons.list,
                  isSelected: controller.isListViewSelected.value,
                  onTap: () => controller.toggleView(true)
              ),
              _buildToggleIconButton(
                  icon: Icons.grid_view,
                  isSelected: !controller.isListViewSelected.value,
                  onTap: () => controller.toggleView(false)
              ),
            ],
          ),
        ),
      ],
    ));
  }
  Widget _buildToggleIconButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 20.sp,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildMapViewContent() {
    return Container(
      height: 500.h,
      child: Stack(
        children: [
          const Center(child: Text("Google Map View")),
        ],
      ),
    );
  }
}