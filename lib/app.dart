import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:product_service/utils/constants/app_string.dart';
import 'package:product_service/services/storage/storage_key.dart';
import 'package:product_service/services/storage/storage_service.dart';
import 'config/route/app_route.dart';
import 'config/theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(430, 932),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        defaultTransition: Transition.fadeIn,
        theme: themeData,
        transitionDuration: const Duration(milliseconds: 300),
        translations: AppString(),
        // locale: Locale(
        //   LocalStorage.preferences?.getString(LocalStorageKeys.languageCode) ?? 'en',
        //   LocalStorage.preferences?.getString(LocalStorageKeys.countryCode) ?? 'US',
        // ),
        // fallbackLocale: const Locale('en', 'US'),
        locale: Locale(
          LocalStorage.preferences?.getString(LocalStorageKeys.languageCode) ?? 'es',
          LocalStorage.preferences?.getString(LocalStorageKeys.countryCode) ?? 'ES',
        ),
        fallbackLocale: const Locale('es', 'ES'),
        initialRoute: AppRoutes.splashScreen,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
