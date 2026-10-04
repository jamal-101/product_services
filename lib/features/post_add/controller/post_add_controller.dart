import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/api/api_service.dart';
import '../../../services/storage/storage_key.dart';
import '../../../services/storage/storage_service.dart';
import '../../../utils/constants/api_enpoint.dart';
import '../../../utils/constants/api_response_model.dart';
import '../../auth_flow/presentation/controller/auth_controller.dart';
import '../../profile_section/presentation/screen/store_creation/presentation/screen/datafast_payment_screen.dart';
import '../presentation/screen/campaign_success_view.dart';
import '../presentation/screen/post_add_step1.dart';

class AdSlot {
  final int position;
  final bool isAvailable;
  final double? weeklyPrice;
  final double? monthlyPrice;
  final String? label;

  const AdSlot({
    required this.position,
    required this.isAvailable,
    this.weeklyPrice,
    this.monthlyPrice,
    this.label,
  });

  String get displayName =>
      label?.isNotEmpty == true ? label! : 'Slot $position';
}

class PostAddController extends GetxController {
  final campaignNameController = TextEditingController();
  var selectedCityId = "".obs;
  var selectedCityName = "".obs;
  var citiesList = [].obs;
  var isLoadingCities = false.obs;

  var slotAvailabilityData = Rxn<dynamic>();
  var availableSlots = <AdSlot>[].obs;
  var selectedSlot = "".obs;
  var selectedPosition = 0.obs;
  var slotPrice = 0.0.obs;
  var isLoadingSlots = false.obs;

  var selectedDuration = "monthly".obs;
  var startDate = "".obs;
  var endDate = "".obs;
  var featuredImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  var isSubmitting = false.obs;
  var isVerifying = false.obs;
  var isCreatingCheckout = false.obs;
  var isVerifyingPayment = false.obs;
  var isLoadingPackages = false.obs;
  var selectedPackageId = "".obs;
  var packagePrice = 0.0.obs;
  var packageName = "".obs;
  var activeCheckoutId = "".obs;
  var postAddPackages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPostAddPackages();
  }

  Future<void> checkAndNavigateToPostAd() async {
    try {
      isVerifying.value = true;

      final response = await ApiService.get(
        ApiEndPoint.verifySellerForPosting,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        final responseData = response.data['data'];
        final bool hasStore = responseData['hasStore'] ?? false;
        if (!hasStore) {
          Get.rawSnackbar(
            messageText: Text(
              "You must create a store first to post an ad!",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.red.shade600,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(16.w),
            borderRadius: 12.r,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.error_outline, color: Colors.white),
          );
          return;
        }

        final tokens = responseData is Map ? responseData['tokens'] : null;
        final sellerToken = tokens is Map
            ? (tokens['accessToken'] ?? tokens['token'])?.toString()
            : null;
        if (sellerToken != null && sellerToken.isNotEmpty) {
          LocalStorage.token = sellerToken;
          await LocalStorage.setString(LocalStorageKeys.token, sellerToken);
          await LocalStorage.setSellerToken(sellerToken);
          debugPrint('🔐 Seller token saved from verify-seller');
        } else if (LocalStorage.token.isNotEmpty) {
          await LocalStorage.setSellerToken(LocalStorage.token);
        }

        final AuthController authController = Get.find<AuthController>();
        authController.selectedRole.value = 'seller';
        await LocalStorage.setUserRole('seller');

        bool isCityFetched = await fetchActiveCities();
        if (!isCityFetched) return;
        fetchPostAddPackages();
        Get.to(() => const PostAdStep1Screen());
      } else {
        Get.rawSnackbar(
          messageText: Text(
            response.message,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red.shade600,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16.w),
          borderRadius: 12.r,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        messageText: Text(
          e.toString(),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.sp,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
    } finally {
      isVerifying.value = false;
    }
  }

  Future<bool> fetchActiveCities() async {
    try {
      isLoadingCities.value = true;
      final response = await ApiService.get(
        ApiEndPoint.activeCities,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        citiesList.value = response.data['data'] ?? [];
        return true;
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoadingCities.value = false;
    }
  }

  /// GET /subscription-packages?packageType=post_add
  Future<void> fetchPostAddPackages() async {
    try {
      isLoadingPackages.value = true;
      final response = await ApiService.get(
        "${ApiEndPoint.baseUrl}/subscription-packages?packageType=post_add",
      );

      if (response.isSuccess) {
        final list = response.data['data'];
        if (list is List) {
          final packages = list
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .where((p) {
                final status = (p['status'] ?? '').toString().toLowerCase();
                // Prefer active; keep unknown status (older APIs)
                return status.isEmpty || status == 'active';
              })
              .toList();
          postAddPackages.assignAll(packages);
          _syncSelectedPackage();
        }
      }
    } catch (e) {
      debugPrint('fetchPostAddPackages error: $e');
    } finally {
      isLoadingPackages.value = false;
    }
  }

  void onDurationChanged(String duration) {
    selectedDuration.value = duration;
    _syncSelectedPackage();
    _refreshSlotPrice();
  }

  /// Select a package from GET /subscription-packages?packageType=post_add
  void selectPackage(Map<String, dynamic> pkg) {
    final id = (pkg['_id'] ?? '').toString();
    if (id.isEmpty) return;

    selectedPackageId.value = id;
    packageName.value = (pkg['name'] ?? '').toString();
    packagePrice.value = _toDouble(pkg['price']) ?? 0;
    selectedDuration.value = _uiDurationFromApi(
      (pkg['duration'] ?? '').toString(),
    );
    _refreshSlotPrice();
  }

  String _uiDurationFromApi(String apiDuration) {
    final d = apiDuration.toLowerCase();
    if (d.contains('week')) return 'weekly';
    if (d.contains('year')) return 'yearly';
    return 'monthly';
  }

  String packageDurationLabel(String? apiDuration) {
    final d = (apiDuration ?? '').toLowerCase();
    if (d.contains('week')) return '7 days';
    if (d.contains('year')) return '365 days';
    if (d.contains('month')) return '30 days';
    return apiDuration?.isNotEmpty == true ? apiDuration! : '—';
  }

  void _syncSelectedPackage() {
    if (postAddPackages.isEmpty) {
      selectedPackageId.value = '';
      packagePrice.value = 0;
      packageName.value = '';
      return;
    }

    // Keep explicit user selection if still present in list
    if (selectedPackageId.value.isNotEmpty) {
      final existing = postAddPackages.firstWhereOrNull(
        (p) => (p['_id'] ?? '').toString() == selectedPackageId.value,
      );
      if (existing != null) {
        selectPackage(existing);
        return;
      }
    }

    final matched = _matchPackageForDuration(selectedDuration.value);
    selectPackage(matched ?? postAddPackages.first);
  }

  Map<String, dynamic>? _matchPackageForDuration(String duration) {
    final normalized = duration.toLowerCase();
    for (final pkg in postAddPackages) {
      final pkgDuration = (pkg['duration'] ?? '').toString().toLowerCase();
      if (_durationsMatch(normalized, pkgDuration)) return pkg;
    }
    return null;
  }

  bool _durationsMatch(String uiDuration, String apiDuration) {
    if (uiDuration.contains('week') || uiDuration == 'weekly') {
      return apiDuration.contains('week');
    }
    if (uiDuration.contains('month') || uiDuration == 'monthly') {
      return apiDuration.contains('month');
    }
    return apiDuration.contains(uiDuration) || uiDuration.contains(apiDuration);
  }

  /// GET /advertisements/availability?cityAdConfigId=...&advertisementType=featured
  Future<void> fetchSlotAvailability() async {
    if (selectedCityId.value.isEmpty) return;
    try {
      isLoadingSlots.value = true;
      selectedSlot.value = '';
      selectedPosition.value = 0;
      slotPrice.value = 0;

      final url =
          "${ApiEndPoint.slotAvailability}?cityAdConfigId=${selectedCityId.value}&advertisementType=featured";

      final response = await ApiService.get(
        url,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        final data = response.data['data'];
        slotAvailabilityData.value = data;
        availableSlots.assignAll(_parseSlots(data));
      } else {
        availableSlots.clear();
        Get.snackbar(
          "Error",
          response.message.isNotEmpty
              ? response.message
              : "Failed to load slot availability",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      availableSlots.clear();
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingSlots.value = false;
    }
  }

  List<AdSlot> _parseSlots(dynamic data) {
    if (data == null) return [];

    if (data is List) {
      return _slotsFromList(data);
    }

    if (data is! Map) return [];
    final map = Map<String, dynamic>.from(data);

    for (final key in [
      'slots',
      'availableSlots',
      'slotList',
      'positions',
      'availability',
      'data',
    ]) {
      final value = map[key];
      if (value is List && value.isNotEmpty) {
        return _slotsFromList(value);
      }
    }

    final availablePositions = _toIntList(
      map['availablePositions'] ?? map['available'] ?? map['freePositions'],
    );
    final bookedPositions = _toIntList(
      map['bookedPositions'] ?? map['booked'] ?? map['occupiedPositions'],
    );
    final capacity =
        _toInt(
          map['featuredCapacity'] ??
              map['capacity'] ??
              map['totalSlots'] ??
              map['maxSlots'] ??
              map['slotCount'],
        ) ??
        0;

    if (availablePositions.isNotEmpty ||
        bookedPositions.isNotEmpty ||
        capacity > 0) {
      final total = capacity > 0
          ? capacity
          : [
              ...availablePositions,
              ...bookedPositions,
            ].fold<int>(0, (m, p) => p > m ? p : m);

      final slots = <AdSlot>[];
      for (
        var i = 1;
        i <= (total > 0 ? total : availablePositions.length);
        i++
      ) {
        final isAvailable = availablePositions.isNotEmpty
            ? availablePositions.contains(i)
            : !bookedPositions.contains(i);
        slots.add(AdSlot(position: i, isAvailable: isAvailable));
      }
      if (slots.isEmpty && availablePositions.isNotEmpty) {
        for (final p in availablePositions) {
          slots.add(AdSlot(position: p, isAvailable: true));
        }
      }
      return slots;
    }

    return [];
  }

  List<AdSlot> _slotsFromList(List raw) {
    final slots = <AdSlot>[];
    for (var i = 0; i < raw.length; i++) {
      final item = raw[i];
      if (item is num) {
        slots.add(AdSlot(position: item.toInt(), isAvailable: true));
        continue;
      }
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final position =
          _toInt(
            map['position'] ??
                map['slot'] ??
                map['slotNumber'] ??
                map['index'] ??
                map['id'],
          ) ??
          (i + 1);

      // API shape: { position, slotNumber, price, isBooked, status: available|booked }
      bool isAvailable = true;
      if (map['isBooked'] == true) {
        isAvailable = false;
      } else if (map['isBooked'] == false) {
        isAvailable = true;
      } else {
        final availableRaw =
            map['isAvailable'] ??
            map['available'] ??
            map['isFree'] ??
            map['free'] ??
            map['status'];
        if (availableRaw is bool) {
          isAvailable = availableRaw;
        } else if (availableRaw != null) {
          final s = availableRaw.toString().toLowerCase();
          isAvailable =
              s == 'available' ||
              s == 'free' ||
              s == 'true' ||
              s == 'open' ||
              s == '1';
          if (s == 'booked' ||
              s == 'occupied' ||
              s == 'unavailable' ||
              s == 'false' ||
              s == '0') {
            isAvailable = false;
          }
        }
      }

      final price = _toDouble(map['price']);
      slots.add(
        AdSlot(
          position: position,
          isAvailable: isAvailable,
          weeklyPrice:
              _toDouble(
                map['weeklyPrice'] ??
                    map['priceWeekly'] ??
                    map['priceWk'] ??
                    map['weekPrice'],
              ) ??
              price,
          monthlyPrice:
              _toDouble(
                map['monthlyPrice'] ??
                    map['priceMonthly'] ??
                    map['priceMo'] ??
                    map['monthPrice'],
              ) ??
              price,
          label:
              (map['name'] ?? map['label'] ?? map['title'] ?? 'Slot $position')
                  ?.toString(),
        ),
      );
    }
    slots.sort((a, b) => a.position.compareTo(b.position));
    return slots;
  }

  void selectSlot(AdSlot slot) {
    if (!slot.isAvailable) return;
    selectedSlot.value = slot.displayName;
    selectedPosition.value = slot.position;
    _refreshSlotPrice(slot: slot);
  }

  void _refreshSlotPrice({AdSlot? slot}) {
    final selected =
        slot ??
        availableSlots.firstWhereOrNull(
          (s) => s.position == selectedPosition.value,
        );
    if (selected == null) {
      slotPrice.value = packagePrice.value;
      return;
    }

    final isWeekly = selectedDuration.value.toLowerCase().contains('week');
    final fromSlot = isWeekly ? selected.weeklyPrice : selected.monthlyPrice;
    slotPrice.value = fromSlot ?? packagePrice.value;
  }

  // Future<void> pickFeaturedImage() async {
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1280,
  //     maxHeight: 1280,
  //     imageQuality: 70,
  //   );
  //   if (image != null) {
  //     featuredImage.value = File(image.path);
  //   }
  // }

  Future<void> pickFeaturedImage() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    Get.back();
                    await _getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue.shade50,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text('Camera'),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    Get.back();
                    await _getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green.shade50,
                        child: const Icon(
                          Icons.photo_library,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    SizedBox(width : 8.w),
                      const Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 70,
      );
      if (image != null) {
        featuredImage.value = File(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  int _selectedPosition() {
    if (selectedPosition.value > 0) return selectedPosition.value;
    if (selectedSlot.value.isEmpty) return 1;
    final digits = selectedSlot.value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 1;
  }

  Future<String?> _resolveAdPackageId() async {
    if (selectedPackageId.value.isNotEmpty) {
      return selectedPackageId.value;
    }

    await fetchPostAddPackages();
    if (selectedPackageId.value.isNotEmpty) {
      return selectedPackageId.value;
    }

    return null;
  }

  /// Prefer seller token (same one used for post_add package APIs).
  String _sellerAuthToken() {
    if (LocalStorage.sellerAccessToken.isNotEmpty) {
      return LocalStorage.sellerAccessToken;
    }
    return LocalStorage.token;
  }

  Map<String, String> _sellerAuthHeader() => {
    'Authorization': 'Bearer ${_sellerAuthToken()}',
    'Content-Type': 'application/json',
  };

  /// Post-ad: POST /datafast/create-checkout-session then open WebView widget.
  Future<void> startDatafastPayment() async {
    if (selectedCityId.value.isEmpty) {
      Get.snackbar("Warning", "Please select a city first");
      return;
    }
    if (selectedSlot.value.isEmpty || selectedPosition.value <= 0) {
      Get.snackbar("Warning", "Please select a slot first");
      return;
    }

    try {
      isCreatingCheckout.value = true;

      final packageId = await _resolveAdPackageId();
      if (packageId == null || packageId.isEmpty) {
        Get.snackbar("Error", "No post_add package found. Please try again.");
        return;
      }

      final body = {
        "packageId": packageId,
        "cityConfigId": selectedCityId.value,
        "position": _selectedPosition(),
      };

      final response = await ApiService.post(
        "${ApiEndPoint.baseUrl}/datafast/create-checkout-session",
        body: body,
        header: _sellerAuthHeader(),
      );

      if (response.isSuccess) {
        final checkoutId = _extractCheckoutId(response.data);
        final paymentUrl = _extractPaymentUrl(response.data);
        if (checkoutId != null && checkoutId.isNotEmpty) {
          activeCheckoutId.value = checkoutId;
          Get.to(
            () => DatafastPaymentScreen(
              checkoutId: checkoutId,
              paymentUrl: paymentUrl,
              onPaymentSuccess: (resultUrl) =>
                  handlePaymentCompleted(checkoutId, resultUrl),
            ),
          );
        } else {
          Get.snackbar("Error", "Checkout ID not found in server response");
        }
      } else {
        Get.snackbar(
          "Error",
          response.message.isNotEmpty
              ? response.message
              : "Failed to create checkout session",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isCreatingCheckout.value = false;
    }
  }

  Future<void> handlePaymentCompleted(
    String checkoutId,
    String resultUrl,
  ) async {
    final verified = await verifyDatafastPayment(checkoutId, resultUrl);
    if (!verified) return;
    await submitAdvertisement();
  }

  Future<bool> verifyDatafastPayment(
    String checkoutId, [
    String? resultUrl,
  ]) async {
    final packageId = selectedPackageId.value.isNotEmpty
        ? selectedPackageId.value
        : await _resolveAdPackageId();

    if (packageId == null || packageId.isEmpty) {
      Get.snackbar("Error", "Package ID missing for payment verification");
      return false;
    }
    if (selectedCityId.value.isEmpty) {
      Get.snackbar("Error", "City config missing for payment verification");
      return false;
    }

    final token = _sellerAuthToken();
    if (token.isEmpty) {
      Get.snackbar("Error", "Seller token missing. Please re-login as seller.");
      return false;
    }

    final parsed = _parsePaymentResultUrl(resultUrl);
    final resolvedCheckoutId = parsed['checkoutId']?.isNotEmpty == true
        ? parsed['checkoutId']!
        : checkoutId;
    final resourcePath = parsed['resourcePath'] ?? '';

    try {
      isVerifyingPayment.value = true;

      final body = <String, dynamic>{
        "checkoutId": resolvedCheckoutId,
        "packageId": packageId,
        "cityConfigId": selectedCityId.value,
        "position": _selectedPosition(),
      };
      if (resourcePath.isNotEmpty) {
        body["resourcePath"] = resourcePath;
      }
      debugPrint('🔐 verify-payment body: $body');
      await Future.delayed(const Duration(seconds: 5));
      ApiResponseModel? response;
      for (var attempt = 1; attempt <= 2; attempt++) {
        response = await ApiService.post(
          "${ApiEndPoint.baseUrl}/datafast/verify-payment",
          body: body,
          header: _sellerAuthHeader(),
        );
        if (response.isSuccess) break;
        final msg = response.message.toLowerCase();
        final isHardAuth = msg.contains('authorization failed');
        if (isHardAuth || attempt == 2) break;

        debugPrint('⏳ verify-payment retry $attempt after settle...');
        await Future.delayed(const Duration(seconds: 8));
      }

      if (response != null && response.isSuccess) {
        return true;
      }

      Get.snackbar(
        "Payment verification failed",
        (response?.message.isNotEmpty == true)
            ? "${response!.message}\n(Ask backend to fix Datafast entityId/Bearer on GET status — code 800.900.300)"
            : "Backend Datafast status check rejected credentials (800.900.300).",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 8),
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isVerifyingPayment.value = false;
    }
  }

  Map<String, String> _parsePaymentResultUrl(String? resultUrl) {
    if (resultUrl == null || resultUrl.isEmpty) {
      return {};
    }
    final uri = Uri.tryParse(resultUrl);
    if (uri == null) return {};

    final resourcePath = uri.queryParameters['resourcePath'] ?? '';
    final idFromQuery = uri.queryParameters['id'] ?? '';

    String checkoutId = idFromQuery;
    if (checkoutId.isEmpty && resourcePath.isNotEmpty) {
      final match = RegExp(
        r'/checkouts/([^/]+)/payment',
      ).firstMatch(resourcePath);
      checkoutId = match?.group(1) ?? '';
    }

    return {'checkoutId': checkoutId, 'resourcePath': resourcePath};
  }

  String? _extractCheckoutId(dynamic resData) {
    if (resData is! Map) return null;
    final map = Map<String, dynamic>.from(resData);
    final data = map['data'];

    String? fromMap(Map source) {
      final id =
          source['checkoutId']?.toString() ??
          source['sessionId']?.toString() ??
          source['id']?.toString() ??
          source['ndc']?.toString();
      if (id != null && id.isNotEmpty) return id;

      final url =
          source['url']?.toString() ?? source['paymentUrl']?.toString() ?? '';
      final fromPayPath = RegExp(r'/datafast/pay/([^/?&#\s]+)').firstMatch(url);
      if (fromPayPath != null) return fromPayPath.group(1);

      final match = RegExp(r'checkoutId=([^&\s]+)').firstMatch(url);
      if (match != null) return match.group(1);

      final raw = source['raw'];
      if (raw is Map) {
        return raw['id']?.toString() ??
            raw['ndc']?.toString() ??
            raw['checkoutId']?.toString();
      }
      return null;
    }

    if (data is Map) {
      final id = fromMap(Map<String, dynamic>.from(data));
      if (id != null && id.isNotEmpty) return id;
    }
    return fromMap(map);
  }

  /// Prefer backend-hosted pay page: `paymentUrl` / `url`.
  /// Upgrades http → https for public API hosts (Android cleartext / mixed content).
  String? _extractPaymentUrl(dynamic resData) {
    if (resData is! Map) return null;
    final map = Map<String, dynamic>.from(resData);
    final data = map['data'];

    String? normalize(String? raw) {
      if (raw == null || raw.trim().isEmpty) return null;
      var url = raw.trim();
      final uri = Uri.tryParse(url);
      if (uri == null) return url;
      // Backend sometimes returns http://api.jaganaecuador.com — force https
      if (uri.scheme == 'http' &&
          (uri.host.contains('jaganaecuador.com') ||
              uri.host.endsWith('.com') ||
              uri.host.endsWith('.net'))) {
        url = uri.replace(scheme: 'https').toString();
      }
      return url;
    }

    String? fromMap(Map source) {
      final candidates = [
        source['paymentUrl']?.toString(),
        source['url']?.toString(),
      ];
      for (final value in candidates) {
        if (value != null &&
            value.isNotEmpty &&
            value.contains('/datafast/pay/')) {
          return normalize(value);
        }
      }
      final paymentUrl = source['paymentUrl']?.toString();
      if (paymentUrl != null &&
          paymentUrl.isNotEmpty &&
          (paymentUrl.startsWith('http://') ||
              paymentUrl.startsWith('https://'))) {
        return normalize(paymentUrl);
      }
      return null;
    }

    if (data is Map) {
      final url = fromMap(Map<String, dynamic>.from(data));
      if (url != null) return url;
    }
    return fromMap(map);
  }


  Future<void> submitAdvertisement() async {
    try {
      isSubmitting.value = true;
      final int positionValue = _selectedPosition();

      Map<String, dynamic> bodyData = {
        "campaignName": campaignNameController.text.trim(),
        "cityAdConfigId": selectedCityId.value,
        "advertisementType": "featured",
        "slot": selectedSlot.value,
        "position": positionValue,
        "duration": selectedDuration.value,
        "startDate": startDate.value,
      };

      final compressedImage = await _compressFeaturedImage(featuredImage.value);
      Map<String, File?> files = {"featuredImage": compressedImage};

      var response = await ApiService.multipartRequest(
        ApiEndPoint.createAdvertisement,
        bodyData: bodyData,
        files: files,
        method: "POST",
        header: _sellerAuthHeader(),
      );

      if (response.isSuccess) {
        Get.offAll(() => const CampaignSuccessView());
      } else {
        final isTooLarge =
            response.statusCode == 413 ||
            response.message.toLowerCase().contains('too large') ||
            response.message.contains('413');
        Get.snackbar(
          "Error",
          isTooLarge
              ? "Image is still too large for the server. Please pick a smaller photo."
              : response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  /// Shrink featured image so nginx does not reject with 413.
  // Future<File?> _compressFeaturedImage(File? file) async {
  //   if (file == null || !await file.exists()) return file;
  //
  //   final originalBytes = await file.length();
  //   debugPrint(
  //     '📷 featuredImage original: ${(originalBytes / 1024).toStringAsFixed(1)} KB',
  //   );
  //
  //   // Already small enough for typical nginx 1–2MB limits
  //   if (originalBytes <= 700 * 1024) return file;
  //
  //   try {
  //     final tempDir = Directory.systemTemp;
  //     final targetPath =
  //         '${tempDir.path}/featured_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //
  //     XFile? result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path,
  //       targetPath,
  //       quality: 70,
  //       minWidth: 1280,
  //       minHeight: 1280,
  //       format: CompressFormat.jpeg,
  //     );
  //
  //     // Still large → stronger pass
  //     if (result != null && await result.length() > 900 * 1024) {
  //       final strongerPath =
  //           '${tempDir.path}/featured_sm_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //       result = await FlutterImageCompress.compressAndGetFile(
  //         file.absolute.path,
  //         strongerPath,
  //         quality: 55,
  //         minWidth: 1024,
  //         minHeight: 1024,
  //         format: CompressFormat.jpeg,
  //       );
  //     }
  //
  //     if (result == null) return file;
  //     final out = File(result.path);
  //     debugPrint(
  //       '📷 featuredImage compressed: ${(await out.length() / 1024).toStringAsFixed(1)} KB',
  //     );
  //     return out;
  //   } catch (e) {
  //     debugPrint('📷 compress failed: $e');
  //     return file;
  //   }
  // }

  Future<File?> _compressFeaturedImage(File? imageFile) async {
    if (imageFile == null) return null;
    try {
      final targetPath =
          '${imageFile.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: 60,
      );
      return compressedFile != null ? File(compressedFile.path) : imageFile;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return imageFile;
    }
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    final digits = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits);
  }

  List<int> _toIntList(dynamic value) {
    if (value is! List) return [];
    return value.map(_toInt).whereType<int>().toList();
  }
}
