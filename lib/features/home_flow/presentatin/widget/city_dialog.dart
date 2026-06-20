import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CityDialog extends StatelessWidget {
  final String selectedCity; // বর্তমানে কোনটি সিলেক্ট করা আছে
  final Function(String) onCitySelected; // সিটি সিলেকশনের জন্য কলব্যাক

  const CityDialog({
    super.key,
    required this.selectedCity,
    required this.onCitySelected
  });

  @override
  Widget build(BuildContext context) {
    final List<String> cities = ["Barcelona", "Madrid", "Valencia", "Seville", "Bilbao", "Malaga"];

    return Container(
      padding: EdgeInsets.only(top: 12.h), // ড্র্যাগ হ্যান্ডেলের জন্য জায়গা
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ফিগমা স্টাইল ড্র্যাগ হ্যান্ডেল
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // বাকি কন্টেন্ট
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select City", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                SizedBox(height: 10.h),
                ...cities.map((city) => _buildCityOption(city, city == selectedCity, context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityOption(String cityName, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCitySelected(cityName); // সিলেক্ট হলে প্যারেন্টকে জানাবে
        Navigator.pop(context); // ডায়ালগ বন্ধ হবে
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.green : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
          color: isSelected ? Colors.green.shade50 : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cityName, style: TextStyle(color: isSelected ? Colors.green : Colors.black, fontWeight: FontWeight.bold)),
            if (isSelected) const Icon(Icons.check, color: Colors.green, size: 18),
          ],
        ),
      ),
    );
  }
}