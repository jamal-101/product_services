// import 'package:get/get.dart';
//
// class FilterController extends GetxController {
//   // Observables: এগুলো ভ্যালু পরিবর্তন হলে UI অটোমেটিক আপডেট করবে
//   var selectedSort = 'Popularity'.obs;
//   var selectedCategory = 'All Categories'.obs;
//   var minRating = 4.5.obs;
//   var locationRadius = 5.0.obs;
//
//   var selectedCountry = RxnString();
//   var selectedProvince = RxnString();
//   var selectedCity = RxnString();
//   var selectedCanton = RxnString();
//
//   final Map<String, dynamic> locationData = {
//     'Switzerland': {
//       'Geneva Canton': {
//         'Geneva': ['All Cantons / Neighbourhoods', 'Plainpalais', 'Eaux-Vives'],
//         'Carouge': ['Centre', 'Old Town'],
//       },
//       'Zurich': {
//         'Zurich City': ['District 1', 'District 2'],
//       }
//     },
//     'Spain': {
//       'Madrid': {
//         'Madrid City': ['Centro', 'Salamanca'],
//       }
//     }
//   };
//
//   // ডাইনামিক লিস্ট ক্যালকুলেশন মেথড
//   List<String> get countries => locationData.keys.toList();
//
//   List<String> get provinces => (selectedCountry.value != null)
//       ? (locationData[selectedCountry.value] as Map<String, dynamic>).keys.cast<String>().toList()
//       : [];
//
//   List<String> get cities => (selectedProvince.value != null && selectedCountry.value != null)
//       ? (locationData[selectedCountry.value][selectedProvince.value] as Map<String, dynamic>).keys.cast<String>().toList()
//       : [];
//
//   List<String> get cantons => (selectedCity.value != null && selectedProvince.value != null && selectedCountry.value != null)
//       ? (locationData[selectedCountry.value][selectedProvince.value][selectedCity.value] as List<dynamic>).cast<String>()
//       : [];
//
//   void resetFilters() {
//     selectedCountry.value = null;
//     selectedProvince.value = null;
//     selectedCity.value = null;
//     selectedCanton.value = null;
//     selectedSort.value = 'Popularity';
//     selectedCategory.value = 'All Categories';
//   }
// }