import 'package:get/get.dart';
import 'package:product_service/features/account_section/presentation/screen/account_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/change_password_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/help_and_support_screen.dart';
import 'package:product_service/features/account_section/presentation/screen/identity_verification_screen.dart';
import 'package:product_service/features/auth_flow/presentation/screen/forget_pass_verify_otp_screen.dart';
import 'package:product_service/features/home_flow/presentatin/controller/home_controller.dart';
import 'package:product_service/features/home_flow/presentatin/screen/explore_stories_screen.dart';
import 'package:product_service/features/notification/presentaiton/screen/notification_screen.dart';
import 'package:product_service/features/message_flow/screen/conversation_screen.dart';
import 'package:product_service/features/message_flow/screen/message_screen.dart';
import 'package:product_service/features/onboardin/presentation/screen/onboarding_screen.dart';
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
import '../../features/auth_flow/presentation/screen/verify_signUp_otp_screen.dart';
import '../../features/home_flow/presentatin/screen/home_screen.dart';
import '../../features/product_store_flow/presentation/screen/productServiceDetailsScreen.dart';
import '../../features/product_store_flow/presentation/screen/store_details_page.dart';
import '../../features/seller/my_list_flow/presentation/screen/edite_branding_screen.dart';
import '../../features/seller/my_list_flow/presentation/screen/edite_legel_document_screen.dart';
import '../../features/seller/my_list_flow/presentation/screen/subsCription_billing_screen.dart';
import '../../features/splash/presentation/screen/splash_screen.dart';

class AppRoutes {

  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "/loginScreen";
  static const String selectRoleScreen = "/selectRoleScreen";
  static const String forgetPassword = "/forgetPassword";
  static const String forgetPassVerifyOtpScreen = "/forgetPassVerifyOtpScreen";
  static const String resetPassword = "/resetPassword";
  static const String createAccount = "/createAccount";
  static const String verifySignUpOtpScreen = "/verifySignUpOtpScreen";
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
  static const String adProductScreen = "/addProductScreen";

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
      name: forgetPassVerifyOtpScreen,
      page: () => ForgetPassVerifyOtpScreen(),
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
      name: AppRoutes.createAccount,
      page: () => const CreateAccountScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.verifySignUpOtpScreen,
      page: () => const VerifySignupOtpScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AuthController>()) {
          Get.lazyPut<AuthController>(() => AuthController());
        }
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
      name: accountScreen,
      page: () =>  AccountScreen(),
    ),
    GetPage(
      name: editProfileScreen,
      page: () =>  EditProfileScreen(),
    ),
    GetPage(
      name: identityVerificationScreen,
      page: () =>  IdentityVerificationScreen(),
    ),
    GetPage(
      name: notificationSettingScreen,
      page: () =>  NotificationSettingsScreen(),
    ),
    GetPage(
      name: notificationScreen,
      page: () =>  NotificationScreen(),
    ),
    GetPage(
      name: helpSupportScreen,
      page: () => HelpSupportScreen(),
    ),
    GetPage(
      name: changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: myStore,
      page: () => MyStore(),
    ),
    GetPage(
      name: createNewStoreStep1,
      page: () => CreateNewStoreStep1(),
    ),
    GetPage(
      name: messageScreen,
      page: () => MessageScreen(),
    ),
    GetPage(
      name: conversationScreen,
      page: () => ConversationScreen(),
    ),
    GetPage(
      name: sellerHomeScreen,
      page: () => SellerHomeScreen(),
    ),
    GetPage(
      name: editeBindingScreen,
      page: () => EditBrandingScreen(),
    ),
    GetPage(
      name: editContactDetailsScreen,
      page: () => EditContactDetailsScreen(),
    ),
    GetPage(
      name: editLegalDocumentsScreen,
      page: () => EditLegalDocumentsScreen(),
    ),
    GetPage(
      name: subscriptionBillingScreen,
      page: () => SubscriptionBillingScreen(),
    ),
  ];
}