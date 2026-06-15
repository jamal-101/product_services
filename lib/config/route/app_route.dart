import 'package:get/get.dart';
import 'package:product_service/features/account_section/presentation/screen/account_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/change_password_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/help_and_support_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/identity_verification_screen.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/features/home_flow/presentatin/screen/explore_stories_screen.dart';
import 'package:product_service/features/home_flow/presentatin/screen/notification_screen.dart';
import 'package:product_service/features/onboardin/presentation/screen/onboarding_screen.dart';
import 'package:product_service/features/product_store_flow/presentation/screen/product_details_screen.dart';
import 'package:product_service/features/product_store_flow/presentation/screen/store_details_page.dart';
import '../../features/account_section/presentation/screen/edite_profile_screen.dart';
import '../../features/auth_flow/presentation/controller/auth_controller.dart'; // কন্ট্রোলার ইম্পোর্ট নিশ্চিত করুন
import '../../features/auth_flow/presentation/screen/create_account_screen.dart';
import '../../features/auth_flow/presentation/screen/forget_password.dart';
import '../../features/auth_flow/presentation/screen/login_screen.dart';
import '../../features/auth_flow/presentation/screen/reset_password.dart';
import '../../features/auth_flow/presentation/screen/select_rol_screen.dart';
import '../../features/auth_flow/presentation/screen/verify_otp.dart';
import '../../features/auth_flow/presentation/screen/verify_phone_screen.dart';
import '../../features/home_flow/presentatin/screen/home_screen.dart';
import '../../features/splash/presentation/screen/splash_screen.dart';

class AppRoutes {
  // Route Names
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "/loginScreen";
  static const String selectRoleScreen = "/selectRoleScreen";
  static const String forgetPassword = "/forgetPassword";
  static const String verifyOtp = "/verifyOtp";
  static const String resetPassword = "/resetPassword";
  static const String createAccount = "/createAccount";
  static const String verifyPhone = "/verifyPhone";
  static const String homeScreen = "/homeScreen";
  static const String exploreStoriesScreen = "/exploreStoriesScreen";
  static const String storeDetailsPage = "/storeDetailsPage";
  static const String productDetailsScreen = "/productDetailsScreen";
  static const String accountScreen = "/accountScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String identityVerificationScreen = "/identityVerificationScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String helpSupportScreen = "/helpSupportScreen";

  // GetPage List
  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
    ),

    // Auth Flow স্ক্রিনগুলোতে binding যুক্ত করা হলো যেন কন্ট্রোলার অটো-ইনিশিয়ালাইজ হয়
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: selectRoleScreen,
      page: () => const SelectRoleScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: forgetPassword,
      page: () => const ForgetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: verifyOtp,
      page: () => const VerifyOtpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: createAccount,
      page: () => const CreateAccountScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: verifyPhone,
      page: () => const VerifyPhoneScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      binding: BindingsBuilder((){
        Get.lazyPut<HomeController>(() =>HomeController());
      })
    ),
    GetPage(
      name: exploreStoriesScreen,
      page: () =>  ExploreStoriesScreen(),
      binding: BindingsBuilder((){
        Get.lazyPut<HomeController>(() => HomeController());
      })
    ),
    GetPage(
      name: storeDetailsPage,
      page: () =>  StoreDetailsPage(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: productDetailsScreen,
      page: () =>  ProductDetailsScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: accountScreen,
      page: () =>  AccountScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: editProfileScreen,
      page: () =>  EditProfileScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: identityVerificationScreen,
      page: () =>  IdentityVerificationScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: notificationScreen,
      page: () =>  ChangePasswordScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: notificationScreen,
      page: () =>  NotificationScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: helpSupportScreen,
      page: () => HelpAndSupportScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
  ];
}