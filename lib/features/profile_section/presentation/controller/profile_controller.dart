import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profileModel = ProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      isLoading.value = true;
      final response = await ApiService.get(ApiEndPoint.profile);

      if (response.isSuccess) {
        profileModel.value = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }
}