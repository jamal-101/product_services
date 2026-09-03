class ApiEndPoint {
  static const baseUrl = "http://10.10.7.10:5009/api/v1";
  static const imageUrl = "http://10.10.7.10:5009";
  static const signUp = "$baseUrl/users";
  static const verifyOtp = "$baseUrl/auth/verify-email";
  static const login = "$baseUrl/auth/login";
  static const forgotPassword = "$baseUrl/auth/forget-password";
  static const verifyEmail = "$baseUrl/auth/verify-email";
  static const resetPassword = "$baseUrl/auth/reset-password";
  static const banner = "$baseUrl/banners";
  static const profile = "$baseUrl/users/profile";
  static const updateProfile = "$baseUrl/users";
  static const verifyIdentity = "$baseUrl/stores/verify-identity";
  static const switchRole = "$baseUrl/auth/switch-role";
  static const changePass = "$baseUrl/auth/change-password";
  static const stores = "$baseUrl/stores";
  static const categories = "$baseUrl/categories";
  static const cityAdConfigurationsAdmin =
      "$baseUrl/city-ad-configurations/admin";
  static const faqs = "$baseUrl/faqs";
  static const activeCities = "$baseUrl/city-ad-configurations/seller/active";
  static const slotAvailability = "$baseUrl/advertisements/availability";
  static const createAdvertisement = "$baseUrl/advertisements";
  static const verifySellerForPosting = "$baseUrl/advertisements/verify-seller";
  static const String myAdvertisements = "$baseUrl/advertisements/my-advertisements";
  static const String userAds = "$baseUrl/advertisements/user-ads";
  static const String reviews = "$baseUrl/reviews";
  static const myServices = "$baseUrl/services/my-services";
  static const myProducts = "$baseUrl/products/my-products";
  static const services = "$baseUrl/services";
  static const products = "$baseUrl/products";
  static const sellerDashboard = "$baseUrl/stores/seller/dashboard";
  static const favorites = "$baseUrl/favorites";


  static const chats = "$baseUrl/chats";
  static const message = "$baseUrl/messages";
  static const sendMessage = "$baseUrl/messages/send-message";
  static const superAdmin = "$baseUrl/users/super-admin";
}
