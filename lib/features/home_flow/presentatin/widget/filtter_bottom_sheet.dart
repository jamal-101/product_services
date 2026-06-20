import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedSort = 'Popularity';
  List<String> selectedCategories = ['Electronics'];
  double minRating = 4.5;
  double locationRadius = 5;
  String selectedLocation = 'All';

  final List<String> categories = ['Electronics', 'Food & Dining', 'Services', 'Fashion', 'Health & Beauty'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.85.sh, // স্ক্রিনের উচ্চতার ৮৫%
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Drag Handle & Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            child: Column(
              children: [
                Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: ()=>Get.back(),
                      child: Icon(Icons.close),
                    ),
                     Text("Filter", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    Text("Reset", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection("Sort By", ['Popularity', 'Nearest', 'Newest', 'Top Rated'], selectedSort, (val) => setState(() => selectedSort = val)),
                  SizedBox(height: 24.h),
                  _buildCategoriesSection(),
                  SizedBox(height: 24.h),
                  _buildRatingSection(),
                  SizedBox(height: 24.h),
                  _buildSection("Location", ['All', 'Madrid', 'Barcelona', 'Valencia', 'Seville'], selectedLocation, (val) => setState(() => selectedLocation = val)),
                  SizedBox(height: 24.h),
                  _buildRadiusSection(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),

          // Footer Action Button
          Container(
            padding: EdgeInsets.all(20.w),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 56.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: Text("Show 128 results", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets (Sort & Location)
  Widget _buildSection(String title, List<String> items, String selected, Function(String) onSelect) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
      SizedBox(height: 12.h),
      Wrap(spacing: 8, children: items.map((item) => ChoiceChip(label: Text(item), selected: selected == item, onSelected: (_) => onSelect(item))).toList()),
    ]);
  }

  Widget _buildCategoriesSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("CATEGORIES", style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
      SizedBox(height: 12.h),
      GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: categories.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () => setState(() => selectedCategories.contains(categories[i]) ? selectedCategories.remove(categories[i]) : selectedCategories.add(categories[i])),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: selectedCategories.contains(categories[i]) ? Colors.green : Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(categories[i], style: TextStyle(fontSize: 12.sp))),
          ),
        ),
      ),
    ]);
  }

  Widget _buildRatingSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("RATING", style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
      Row(children: [4.5, 4.0, 3.5].map((r) => RadioMenuButton(value: r, groupValue: minRating, onChanged: (v) => setState(() => minRating = v!), child: Text("$r+"))).toList()),
    ]);
  }

  Widget _buildRadiusSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("LOCATION RADIUS", style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
      Slider(value: locationRadius, min: 1, max: 50, onChanged: (v) => setState(() => locationRadius = v)),
      Text("${locationRadius.toInt()} km radius", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
    ]);
  }
}

