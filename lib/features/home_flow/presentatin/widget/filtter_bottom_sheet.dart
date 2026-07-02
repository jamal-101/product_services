import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {

  String selectedSort = 'Popularity';
  String selectedCategory = 'All Categories';
  double minRating = 4.5;
  double locationRadius = 5;

  String? selectedCountry;
  String? selectedProvince;
  String? selectedCity;
  String? selectedCanton;

  // Data Source
  final Map<String, dynamic> locationData = {
    'Switzerland': {
      'Geneva Canton': {
        'Geneva': ['All Cantons / Neighbourhoods', 'Plainpalais', 'Eaux-Vives'],
        'Carouge': ['Centre', 'Old Town'],
      },
      'Zurich': {
        'Zurich City': ['District 1', 'District 2'],
      }
    },
    'Spain': {
      'Madrid': {
        'Madrid City': ['Centro', 'Salamanca'],
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.85.sh,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection("Sort By", ['Popularity', 'Nearest', 'Newest', 'Top Rated'], selectedSort, (val) => setState(() => selectedSort = val)),
                  SizedBox(height: 24.h),
                  _buildDropdown("CATEGORIES", ['All Categories', 'Electronics', 'Fashion'], selectedCategory, (v) => setState(() => selectedCategory = v!)),
                  SizedBox(height: 24.h),
                  _buildRatingSection(),
                  SizedBox(height: 24.h),
                  _buildLocationHierarchy(),
                  SizedBox(height: 24.h),
                  _buildRadiusSection(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildLocationHierarchy() {
    List<String> countries = locationData.keys.toList();
    List<String> provinces = [];
    if (selectedCountry != null && locationData.containsKey(selectedCountry)) {
      provinces = (locationData[selectedCountry] as Map<String, dynamic>).keys.cast<String>().toList();
    }
    List<String> cities = [];
    if (selectedProvince != null && selectedCountry != null) {
      var countryMap = locationData[selectedCountry] as Map<String, dynamic>;
      if (countryMap.containsKey(selectedProvince)) {
        cities = (countryMap[selectedProvince] as Map<String, dynamic>).keys.cast<String>().toList();
      }
    }
    List<String> cantons = [];
    if (selectedCity != null && selectedProvince != null && selectedCountry != null) {
      var countryMap = locationData[selectedCountry] as Map<String, dynamic>;
      var provinceMap = countryMap[selectedProvince] as Map<String, dynamic>;
      if (provinceMap.containsKey(selectedCity)) {
        cantons = (provinceMap[selectedCity] as List<dynamic>).cast<String>();
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("LOCATION", style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
      SizedBox(height: 12.h),

      _buildDropdown("Country", countries, selectedCountry, (v) => setState(() {
        selectedCountry = v; selectedProvince = null; selectedCity = null; selectedCanton = null;
      })),
      SizedBox(height: 10.h),
      _buildDropdown("Province / State", provinces, selectedProvince, (v) => setState(() {
        selectedProvince = v; selectedCity = null; selectedCanton = null;
      })),
      SizedBox(height: 10.h),
      _buildDropdown("City", cities, selectedCity, (v) => setState(() {
        selectedCity = v; selectedCanton = null;
      })),
      SizedBox(height: 10.h),
      _buildDropdown("Canton / Neighbourhood", cantons, selectedCanton, (v) => setState(() {
        selectedCanton = v;
      })),
    ]);
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 10.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
      SizedBox(height: 5.h),
      DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), contentPadding: EdgeInsets.symmetric(horizontal: 12)),
        value: items.contains(value) ? value : null,
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
        onChanged: onChanged,
      ),
    ],
  );

  Widget _buildHeader() => Container(padding: EdgeInsets.all(20.w), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [GestureDetector(onTap: () => Get.back(), child: Icon(Icons.close)), Text("Filter", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)), Text("Reset", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))]));

  Widget _buildSection(String title, List<String> items, String selected, Function(String) onSelect) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title.toUpperCase(), style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)), SizedBox(height: 12.h), Wrap(spacing: 8, children: items.map((item) => ChoiceChip(label: Text(item), selected: selected == item, onSelected: (_) => onSelect(item))).toList())]);

  Widget _buildRatingSection() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("RATING", style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)), Row(children: [4.5, 4.0, 3.5].map((r) => Row(children: [Radio(value: r, groupValue: minRating, onChanged: (v) => setState(() => minRating = v as double)), Text("$r+")],)).toList())]);

  Widget _buildRadiusSection() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("LOCATION RADIUS", style: TextStyle(fontSize: 12.sp, color: Colors.grey, fontWeight: FontWeight.bold)), Slider(value: locationRadius, min: 1, max: 50, onChanged: (v) => setState(() => locationRadius = v)), Text("${locationRadius.toInt()} km radius", style: TextStyle(fontSize: 12.sp, color: Colors.grey))]);

  Widget _buildFooter() => Container(padding: EdgeInsets.all(20.w), child: ElevatedButton(onPressed: () => Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 56.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text("Show Results", style: TextStyle(color: Colors.white))));
}