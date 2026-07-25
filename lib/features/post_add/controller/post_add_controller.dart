import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

enum City { dhaka, chattogram, other }

class PostAddController extends GetxController {

  var currentStep = 1.obs;

  var selectedBannerType = 0.obs;
  var selectedSlotIndex = (-1).obs;
  var selectedPlanIndex = (-1).obs;

  var startDate = ''.obs;
  var endDate = ''.obs;

  RxString selectedCity = "Select".obs;

  void updateSelectedGender(City genderItem) {
    switch (genderItem) {
      case City.dhaka: selectedCity.value = "dhaka"; break;
      case City.chattogram: selectedCity.value = "chattogram"; break;
      case City.other: selectedCity.value = "Prefer not to say"; break;
    }
  }

  void selectBannerType(int type) {
    selectedBannerType.value = type;
    selectedSlotIndex.value = -1;
  }

  void selectSlot(int index) {
    selectedSlotIndex.value = index;
  }

  void selectPlan(int plan) {
    selectedPlanIndex.value = plan;
    calculateEndDate();
  }
  Future<void> chooseStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2E7D32),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDate.value = DateFormat('MM/dd/yyyy').format(picked);
      calculateEndDate(picked: picked);
    }
  }
  void calculateEndDate({DateTime? picked}) {
    if (startDate.value.isEmpty || selectedPlanIndex.value == -1) return;

    DateTime start = picked ?? DateFormat('MM/dd/yyyy').parse(startDate.value);
    int daysToAdd = selectedPlanIndex.value == 1 ? 7 : 30;

    DateTime end = start.add(Duration(days: daysToAdd));
    endDate.value = DateFormat('MMM dd, yyyy').format(end);
  }

  void nextStep() {
    if (currentStep.value == 1) {
      currentStep.value = 2;
    } else if (currentStep.value == 2) {
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }


  RxString uploadedBannerPath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  void pickBannerImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        uploadedBannerPath.value = image.path;
      }
    } catch (e) {
      print("Image pick error: $e");
    }
  }

  void removeBannerImage() {
    uploadedBannerPath.value = '';
  }

}