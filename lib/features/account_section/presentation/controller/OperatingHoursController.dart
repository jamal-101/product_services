import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperatingHoursController extends GetxController {

  var isOpen24_7 = false.obs;

  var selectedPresetIndex = (-1).obs;


  var workingDays = <String, bool>{
    'M': true,
    'T': false,
    'W': false,
    'Th': false,
    'F': false,
    'Sat': false,
    'Sun': false,
  }.obs;

  final openingTimeController = TextEditingController();
  final closingTimeController = TextEditingController();

  void toggleDay(String dayKey) {
    workingDays[dayKey] = !(workingDays[dayKey] ?? false);
    selectedPresetIndex.value = -1;
  }

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