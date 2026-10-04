import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/constants/api_enpoint.dart';
import '../../../utils/constants/api_response_model.dart';
import '../model/favourite_product_model.dart' as product_m;
import '../model/favourite_store_model.dart' as store_m;

class SaveController extends GetxController {
  var selectedTab = 0.obs;
  var isLoading = false.obs;
  var favoriteStoreList = <store_m.FavoriteData>[].obs;
  var favoriteProductList = <product_m.FavoriteData>[].obs; // Jodi products alada tab-e lage rakhben

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  void changeTab(int index) {
    if (selectedTab.value != index) {
      selectedTab.value = index;
      loadInitialData();
    }
  }


  void loadInitialData() {
    fetchFavoritesStore();
  }

  Future<void> fetchFavoritesStore() async {
    try {
      isLoading.value = true;
      String targetType = (selectedTab.value == 0) ? 'product_store' : 'service_store';
      String url = "${ApiEndPoint.favorites}?targetType=$targetType";

      ApiResponseModel response = await ApiService.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        store_m.FavoriteStoreModel model = store_m.FavoriteStoreModel.fromJson(response.data as Map<String, dynamic>);
        favoriteStoreList.value = model.data ?? [];
      } else {
        favoriteStoreList.clear();
        debugPrint("Failed to load stores: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching stores: $e");
      favoriteStoreList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFavoriteProduct() async {
    try {
      isLoading.value = true;
      String url = "${ApiEndPoint.favorites}?targetType=product";

      ApiResponseModel response = await ApiService.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        product_m.FavouriteProductModel model = product_m.FavouriteProductModel.fromJson(response.data as Map<String, dynamic>);
        favoriteProductList.value = model.data ?? [];
      } else {
        favoriteProductList.clear();
      }
    } catch (e) {
      favoriteProductList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}