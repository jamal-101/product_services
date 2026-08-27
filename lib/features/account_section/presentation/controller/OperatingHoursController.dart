import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperatingHoursController extends GetxController {
  // 24/7 Toggle state
  var isOpen24_7 = false.obs;

  // Selected preset index (-1 mane konotai select nai)
  var selectedPresetIndex = (-1).obs;

  // Days state: [Mon, Tue, Wed, Thu, Fri, Sat, Sun]
  var workingDays = <String, bool>{
    'M': true,
    'T': false,
    'W': false,
    'Th': false,
    'F': false,
    'Sat': false,
    'Sun': false,
  }.obs;

  // Time controllers
  final openingTimeController = TextEditingController();
  final closingTimeController = TextEditingController();

  // Toggle individual day selection
  void toggleDay(String dayKey) {
    workingDays[dayKey] = !(workingDays[dayKey] ?? false);
    selectedPresetIndex.value = -1; // Preset reset hobe jodi custom click kora hoy
  }

  // Select Preset (0: Mon-Sat, 1: Mon-Fri, 2: Everyday)
  void selectPreset(int index) {
    selectedPresetIndex.value = index;
    if (index == 0) {
      workingDays.updateAll((key, value) => key != 'Sun');
    } else if (index == 1) {
      workingDays.updateAll((key, value) => key == 'M' || key == 'T' || key == 'W' || key == 'Th' || key == 'F');
    } else if (index == 2) {
      workingDays.updateAll((key, value) => true);
    }
  }

  // Toggle 24/7
  void toggleOpen24_7(bool value) {
    isOpen24_7.value = value;
  }

  @override
  void onClose() {
    openingTimeController.dispose();
    closingTimeController.dispose();
    super.dispose();
  }
}