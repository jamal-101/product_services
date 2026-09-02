import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/constants/api_enpoint.dart';
import '../../../utils/constants/api_response_model.dart';
import '../model/favourite_product_model.dart';

class SaveProductController extends GetxController {
  var selectedTab = 0.obs;
  var isLoading = false.obs;

  var favoriteProductList = <FavoriteData>[].obs;
  var favoriteStoreList = <FavoriteData>[].obs;

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
    if (selectedTab.value == 0) {
      fetchFavoriteProduct();
    } else {
      fetchFavoritesService();
    }
  }


  Future<void> fetchFavoriteProduct() async {
    try {
      isLoading.value = true;
      String url = "${ApiEndPoint.favorites}?targetType=product";

      ApiResponseModel response = await ApiService.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        FavouriteProductModel model =
        FavouriteProductModel.fromJson(response.data as Map<String, dynamic>);
        favoriteProductList.value = model.data ?? [];
      } else {
        favoriteProductList.clear();
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
      favoriteProductList.clear();
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchFavoritesService() async {
    try {
      isLoading.value = true;
      String url = "${ApiEndPoint.favorites}?targetType=service";

      ApiResponseModel response = await ApiService.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        FavouriteProductModel model =
        FavouriteProductModel.fromJson(response.data as Map<String, dynamic>);
        favoriteStoreList.value = model.data ?? [];
      } else {
        favoriteStoreList.clear();
      }
    } catch (e) {
      debugPrint("Error fetching services: $e");
      favoriteStoreList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}