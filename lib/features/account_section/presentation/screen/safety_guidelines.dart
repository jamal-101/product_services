import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../utils/constants/app_color.dart';
import '../controller/support_controller.dart';

class SafetyGuidelinesScreen extends StatelessWidget {


  const SafetyGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final SupportController controller = Get.put(SupportController());
    controller.fetchRuleContent();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColor.appBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'safetyGuidelines'.tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return HtmlWidget(
              controller.htmlContent.value,
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF1A1D24),
              ),
            );
          }),
        ),
      ),
    );
  }
}