import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedSort = 'Popularity';
  double locationRadius = 5;

  String? selectedCategory;
  String? selectedSubcategory;

  final Map<String, dynamic> categoryData = {
    'Electronics': ['All Results', 'Laptops', 'Mobile Phones', 'Video Game Consoles'],
    'Fashion': ['All Results', 'Men Clothing', 'Women Clothing', 'Footwear'],
  };

  String? selectedCountry;
  String? selectedProvince;
  String? selectedCity;
  String? selectedCanton;

  final Map<String, dynamic> locationData = {
    'Switzerland': {
      'Geneva Canton': {
        'Geneva': ['All Places', 'Plainpalais', 'Eaux-Vives'],
        'Carouge': ['All Places', 'Centre', 'Old Town'],
      },
      'Zurich': {
        'Zurich City': ['All Places', 'District 1', 'District 2'],
      },
    },
    'Spain': {
      'Madrid': {
        'Madrid City': ['All Places', 'Centro', 'Salamanca'],
      },
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.85.sh,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    "Sort By",
                    ['Popularity', 'Nearest', 'Newest', 'Top Rated'],
                    selectedSort,
                        (val) => setState(() => selectedSort = val),
                  ),
                  SizedBox(height: 24.h),
                  _buildCategoryHierarchy(),
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

  Widget _buildCategoryHierarchy() {
    List<String> categories = ['All Results', ...categoryData.keys.toList()];
    List<String> subcategories = [];

    if (selectedCategory != null &&
        selectedCategory != 'All Results' &&
        categoryData.containsKey(selectedCategory)) {
      subcategories = (categoryData[selectedCategory] as List<dynamic>).cast<String>();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CATEGORIES",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        _buildPopupDropdown(
          label: "Category",
          hintText: "Select Category",
          items: categories,
          selectedValue: selectedCategory,
          onSelected: (v) {
            setState(() {
              selectedCategory = v;
              selectedSubcategory = null;
            });
          },
        ),
        if (subcategories.isNotEmpty) ...[
          SizedBox(height: 10.h),
          _buildPopupDropdown(
            label: "Subcategory",
            hintText: "Select Subcategory",
            items: subcategories,
            selectedValue: selectedSubcategory,
            onSelected: (v) {
              setState(() {
                selectedSubcategory = v;
              });
            },
          ),
        ],
      ],
    );
  }

  Widget _buildLocationHierarchy() {
    List<String> countries = ['All Places', ...locationData.keys.toList()];
    List<String> provinces = [];
    if (selectedCountry != null &&
        selectedCountry != 'All Places' &&
        locationData.containsKey(selectedCountry)) {
      provinces = [
        'All Places',
        ...(locationData[selectedCountry] as Map<String, dynamic>).keys.cast<String>()
      ];
    }

    List<String> cities = [];
    if (selectedProvince != null &&
        selectedProvince != 'All Places' &&
        selectedCountry != null) {
      var countryMap = locationData[selectedCountry] as Map<String, dynamic>;
      if (countryMap.containsKey(selectedProvince)) {
        cities = [
          'All Places',
          ...(countryMap[selectedProvince] as Map<String, dynamic>).keys.cast<String>()
        ];
      }
    }

    List<String> cantons = [];
    if (selectedCity != null &&
        selectedCity != 'All Places' &&
        selectedProvince != null &&
        selectedCountry != null) {
      var countryMap = locationData[selectedCountry] as Map<String, dynamic>;
      var provinceMap = countryMap[selectedProvince] as Map<String, dynamic>;
      if (provinceMap.containsKey(selectedCity)) {
        cantons = (provinceMap[selectedCity] as List<dynamic>).cast<String>();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "LOCATION",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        _buildPopupDropdown(
          label: "Country",
          hintText: "Select Country",
          items: countries,
          selectedValue: selectedCountry,
          onSelected: (v) {
            setState(() {
              selectedCountry = v;
              selectedProvince = null;
              selectedCity = null;
              selectedCanton = null;
            });
          },
        ),
        if (provinces.isNotEmpty) ...[
          SizedBox(height: 10.h),
          _buildPopupDropdown(
            label: "Province / State",
            hintText: "Select Province",
            items: provinces,
            selectedValue: selectedProvince,
            onSelected: (v) {
              setState(() {
                selectedProvince = v;
                selectedCity = null;
                selectedCanton = null;
              });
            },
          ),
        ],
        if (cities.isNotEmpty) ...[
          SizedBox(height: 10.h),
          _buildPopupDropdown(
            label: "City",
            hintText: "Select City",
            items: cities,
            selectedValue: selectedCity,
            onSelected: (v) {
              setState(() {
                selectedCity = v;
                selectedCanton = null;
              });
            },
          ),
        ],
        if (cantons.isNotEmpty) ...[
          SizedBox(height: 10.h),
          _buildPopupDropdown(
            label: "Canton / Neighbourhood",
            hintText: "Select Canton / Neighbourhood",
            items: cantons,
            selectedValue: selectedCanton,
            onSelected: (v) {
              setState(() {
                selectedCanton = v;
              });
            },
          ),
        ],
      ],
    );
  }

  Widget _buildPopupDropdown({
    required String label,
    required String hintText,
    required List<String> items,
    required String? selectedValue,
    required Function(String?) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<String>(
            onSelected: onSelected,
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            itemBuilder: (BuildContext context) {
              return items.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      color: selectedValue == item ? Colors.green[700] : Colors.black87,
                      fontWeight: selectedValue == item ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedValue ?? hintText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: selectedValue != null ? Colors.black87 : Colors.grey.shade400,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() => Container(
    padding: EdgeInsets.all(20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.close)),
        Text(
          "Filter",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedSort = 'Popularity';
              selectedCategory = null;
              selectedSubcategory = null;
              selectedCountry = null;
              selectedProvince = null;
              selectedCity = null;
              selectedCanton = null;
              locationRadius = 5;
            });
          },
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );

  Widget _buildSection(
      String title,
      List<String> items,
      String selected,
      Function(String) onSelect,
      ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8,
            children: items
                .map(
                  (item) => ChoiceChip(
                label: Text(item),
                selected: selected == item,
                selectedColor: Colors.green.shade100,
                labelStyle: TextStyle(
                  color: selected == item ? Colors.green.shade800 : Colors.black87,
                  fontWeight: selected == item ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (_) => onSelect(item),
              ),
            )
                .toList(),
          ),
        ],
      );

  Widget _buildRadiusSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "LOCATION RADIUS",
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      Slider(
        value: locationRadius,
        min: 1,
        max: 50,
        activeColor: Colors.green,
        onChanged: (v) => setState(() => locationRadius = v),
      ),
      Text(
        "${locationRadius.toInt()} km radius",
        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
      ),
    ],
  );

  Widget _buildFooter() => Container(
    padding: EdgeInsets.all(20.w),
    child: ElevatedButton(
      onPressed: () => Get.back(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text("Show Results", style: TextStyle(color: Colors.white, fontSize: 16)),
    ),
  );
}