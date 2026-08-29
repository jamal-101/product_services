import 'package:get/get.dart';
import 'package:product_service/features/account_section/presentation/screen/account_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/change_password_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/help_and_support_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/identity_verification_screen.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/features/home_flow/presentatin/screen/explore_stories_screen.dart';
import 'package:product_service/features/home_flow/presentatin/screen/notification_screen.dart';
import 'package:product_service/features/message_flow/screen/conversation_screen.dart';
import 'package:product_service/features/message_flow/screen/message_screen.dart';
import 'package:product_service/features/onboardin/presentation/screen/onboarding_screen.dart';
import 'package:product_service/features/product_store_flow/presentation/screen/product_details_screen.dart';
import 'package:product_service/features/product_store_flow/presentation/screen/store_details_page.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/screen/creat_new_store_step1.dart';
import 'package:product_service/features/profile_section/presentation/screen/store_creation/presentation/screen/my_store.dart';
import 'package:product_service/features/seller/my_list_flow/presentation/screen/edite_contact_details_screen.dart';
import 'package:product_service/features/seller/seller_home_flow/presentation/screen/seller_home_screen.dart';
import '../../features/account_section/presentation/screen/edite_profile_screen.dart';
import '../../features/account_section/presentation/screen/notification_setting.dart';
import '../../features/auth_flow/presentation/controller/auth_controller.dart';
import '../../features/auth_flow/presentation/screen/create_account_screen.dart';
import '../../features/auth_flow/presentation/screen/forget_password.dart';
import '../../features/auth_flow/presentation/screen/login_screen.dart';
import '../../features/auth_flow/presentation/screen/reset_password.dart';
import '../../features/auth_flow/presentation/screen/select_rol_screen.dart';
import '../../features/auth_flow/presentation/screen/verify_otp.dart';
import '../../features/auth_flow/presentation/screen/verify_phone_screen.dart';
import '../../features/home_flow/presentatin/screen/home_screen.dart';
import '../../features/seller/my_list_flow/presentation/screen/edite_branding_screen.dart';
import '../../features/seller/my_list_flow/presentation/screen/edite_legel_document_screen.dart';
import '../../features/seller/my_list_flow/presentation/screen/subsCription_billing_screen.dart';
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
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String notificationSettingScreen = "/notificationSettingScreen";
  static const String helpSupportScreen = "/helpSupportScreen";
  static const String myStore = "/myStore";
  static const String createNewStoreStep1 = "/createNewStoreStep1";
  static const String messageScreen = "/messageScreen";
  static const String conversationScreen = "/conversationScreen";
  static const String sellerHomeScreen = "/sellerHomeScreen";
  static const String editeBindingScreen = "/editeBindingScreen";
  static const String editContactDetailsScreen = "/editContactDetailsScreen";
  static const String editLegalDocumentsScreen = "/editLegalDocumentsScreen";
  static const String subscriptionBillingScreen = "/subscriptionBillingScreen";
  static const String advertiseWithUs = "/AdvertiseWithUs";

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

    GetPage(
      name: loginScreen,
      page: () =>  LoginScreen(),
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
      page: () => ForgetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: verifyOtp,
      page: () => VerifyOtpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: resetPassword,
      page: () => ResetPasswordScreen(),
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
      page: () => VerifyPhoneScreen(),
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
      name: AppRoutes.exploreStoriesScreen,
      page: () => const ExploreStoriesScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() =>AuthController());
      }),
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
      name: notificationSettingScreen,
      page: () =>  NotificationSettingsScreen(),
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
      page: () => HelpSupportScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: changePasswordScreen,
      page: () => ChangePasswordScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: myStore,
      page: () => MyStore(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: createNewStoreStep1,
      page: () => CreateNewStoreStep1(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: messageScreen,
      page: () => MessageScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: conversationScreen,
      page: () => ConversationScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: sellerHomeScreen,
      page: () => SellerHomeScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: editeBindingScreen,
      page: () => EditBrandingScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: editContactDetailsScreen,
      page: () => EditContactDetailsScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: editLegalDocumentsScreen,
      page: () => EditLegalDocumentsScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    GetPage(
      name: subscriptionBillingScreen,
      page: () => SubscriptionBillingScreen(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    ),
    // GetPage(
    //   name: advertiseWithUs,
      // page: () => AdvertiseWithUs(),
      // binding: BindingsBuilder((){
      //   Get.lazyPut<S>(() => HomeController());
      // })
    // ),
  ];
}