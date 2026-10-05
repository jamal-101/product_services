import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product_service/component/bottom_navBar/App_scaffold.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/utils/constants/app_color.dart';
import 'package:product_service/utils/constants/app_string.dart';
import '../../../../utils/constants/api_enpoint.dart';
import '../../../product_store_flow/presentation/screen/store_details_page.dart';
import '../controller/explore_store_controller.dart';
import '../widget/city_dialog.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ExploreStoriesScreen extends StatelessWidget {
  const ExploreStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExploreStoreController controllers = Get.put(
      ExploreStoreController(),
    );

    return AppScaffold(
      selectedIndex: 1,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColor.appBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: AppString.explore.tr,
                    style: GoogleFonts.plusJakartaSans(color: Colors.black),
                  ),
                  TextSpan(
                    text: AppString.stores.tr,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFFE67E22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          _buildTopBarActions(controllers),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (!controllers.isListViewSelected.value) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildToggleButton(
                                title: AppString.productsStores.tr,
                                isSelected:
                                    controllers.isProductStoreSelected.value,
                                onTap: () => controllers.toggleStoreType(true),
                              ),
                            ),
                            Expanded(
                              child: _buildToggleButton(
                                title: AppString.servicesProvider.tr,
                                isSelected:
                                    !controllers.isProductStoreSelected.value,
                                onTap: () => controllers.toggleStoreType(false),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),
                    Obx(() {
                      if (!controllers.isListViewSelected.value) {
                        return const SizedBox.shrink();
                      }
                      return TextFormField(
                        onChanged: (value) {
                          controllers.updateSearchQuery(value);
                        },
                        decoration: InputDecoration(
                          hintText: AppString.searchStores.tr,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          fillColor: const Color(0xFFF5F5F7),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          Obx(
                            () => _buildFilterChip(
                              Icons.location_on_outlined,
                              controllers.selectedCity.value.isEmpty
                                  ? AppString.city.tr
                                  : controllers.selectedCity.value,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.r),
                                    ),
                                  ),
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: SizedBox(
                                      height: 0.5.sh,
                                      child: CityDialog(
                                        selectedCity:
                                            controllers.selectedCity.value,
                                        onCitySelected: (newCity) {
                                          controllers.updateCity(newCity);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Obx(() {
                            if (!controllers.isListViewSelected.value) {
                              return const SizedBox.shrink();
                            }
                            return _buildFilterChip(
                              Icons.access_time_rounded,
                              AppString.openNow.tr,
                              isSelected: controllers.isOpenNow.value,
                              onTap: () {
                                controllers.toggleOpenNow();
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() {
                      if (controllers.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            child: const CircularProgressIndicator(
                              color: Color(0xFFE67E22),
                            ),
                          ),
                        );
                      }

                      if (!controllers.isListViewSelected.value) {
                        return _buildMapViewContent(controllers);
                      }

                      if (controllers.isProductStoreSelected.value) {
                        if (controllers.productStoreList.isEmpty) {
                          return _buildEmptyState();
                        }
                        return ListView.builder(
                          itemCount: controllers.productStoreList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var store = controllers.productStoreList[index];
                            return _buildStoreListItem(
                              storeId: store.sId ?? "",
                              index: index,
                              title: store.displayName ?? AppString.noName.tr,
                              subtitle:
                                  "${store.categoryId?.name ?? 'Store'} • ${store.phone ?? ''}",
                              rating: store.averageRating?.toString() ?? "0.0",
                              logoBg: const Color(0xFFE67E22),
                              isFavorite: store.isFavorite ?? false,
                              storeType: store.storeType ?? "product_store",
                            );
                          },
                        );
                      } else {
                        if (controllers.serviceStoreList.isEmpty) {
                          return _buildEmptyState();
                        }
                        return ListView.builder(
                          itemCount: controllers.serviceStoreList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var store = controllers.serviceStoreList[index];
                            return _buildStoreListItem(
                              storeId: store.sId ?? "",
                              index: index,
                              title: store.displayName ?? AppString.noName.tr,
                              subtitle:
                                  "${store.categoryId?.name ?? 'Service'} • ${store.phone ?? ''}",
                              rating: store.averageRating?.toString() ?? "0.0",
                              logoBg: const Color(0xFF9B59B6),
                              isFavorite: store.isFavorite ?? false,
                              storeType: store.storeType ?? "service_store",
                            );
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE67E22) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    IconData icon,
    String label, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFECECF0)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14.w,
              color: isSelected ? Colors.white : Colors.black54,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreListItem({
    required String title,
    required String subtitle,
    required String rating,
    required Color logoBg,
    bool isFavorite = false,
    required String storeId,
    required String storeType,
    required int index,
  }) {
    final ExploreStoreController controllers =
        Get.find<ExploreStoreController>();
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const ProductDetailsScreen(),
          arguments: {'storeId': storeId, 'storeType': storeType},
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFECECF0)),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: logoBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: const Icon(
                Icons.store_mall_directory,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 2.w),
                    Text(
                      rating,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controllers.handleBookmarkTap(storeId, index);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      color: isFavorite ? const Color(0xFFE67E22) : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Text(
          AppString.noStoresFound.tr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBarActions(ExploreStoreController controllers) {
    return Obx(
      () => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  _buildToggleIconButton(
                    child: Icon(
                      Icons.list,
                      size: 20.sp,
                      color: controllers.isListViewSelected.value
                          ? Colors.white
                          : Colors.grey,
                    ),
                    isSelected: controllers.isListViewSelected.value,
                    onTap: () => controllers.toggleView(true),
                  ),
                  SizedBox(width: 8.w),
                  _buildToggleIconButton(
                    child: Text(
                      AppString.map.tr,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: !controllers.isListViewSelected.value
                            ? Colors.white
                            : Color(0xFF1A1D24),
                      ),
                    ),
                    isSelected: !controllers.isListViewSelected.value,
                    onTap: () => controllers.toggleView(false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleIconButton({
    required Widget child,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: child,
      ),
    );
  }
}

Future<BitmapDescriptor> _createCustomMarkerBitmap(
  String title,
  String rating,
  Color logoBg,
  String? logoUrl,
) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  const Size size = Size(160, 62);

  final Paint shadowPaint = Paint()
    ..color = Colors.black.withValues(alpha: 0.15)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

  final RRect cardRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(4, 4, 152, 46),
    const Radius.circular(10),
  );

  canvas.drawRRect(cardRect, shadowPaint);
  canvas.drawRRect(cardRect, Paint()..color = Colors.white);

  final RRect logoRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(10, 10, 32, 32),
    const Radius.circular(7),
  );
  canvas.drawRRect(logoRect, Paint()..color = logoBg);

  if (logoUrl != null && logoUrl.isNotEmpty) {
    try {
      var file = await DefaultCacheManager().getSingleFile(logoUrl);
      Uint8List bytes = await file.readAsBytes();

      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo fi = await codec.getNextFrame();

      canvas.save();
      canvas.clipRRect(logoRect);
      canvas.drawImageRect(
        fi.image,
        Rect.fromLTWH(
          0,
          0,
          fi.image.width.toDouble(),
          fi.image.height.toDouble(),
        ),
        Rect.fromLTWH(10, 10, 32, 32),
        Paint(),
      );
      canvas.restore();
    } catch (_) {}
  }

  final TextPainter titlePainter = TextPainter(
    text: TextSpan(
      text: title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1D24),
      ),
    ),
    textDirection: TextDirection.ltr,
    maxLines: 1,
  );
  titlePainter.layout(maxWidth: 100);
  titlePainter.paint(canvas, const Offset(48, 10));

  final TextPainter ratingPainter = TextPainter(
    text: TextSpan(
      text: "⭐  $rating",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  ratingPainter.layout();
  ratingPainter.paint(canvas, const Offset(48, 27));

  final Path path = Path();
  path.moveTo(74, 50);
  path.lineTo(86, 50);
  path.lineTo(80, 58);
  path.close();
  canvas.drawPath(path, Paint()..color = Colors.white);

  final ui.Image image = await pictureRecorder.endRecording().toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  final Uint8List uint8List = byteData!.buffer.asUint8List();

  return BitmapDescriptor.bytes(uint8List);
}

Widget _buildMapViewContent(ExploreStoreController controllers) {
  return Obx(() {
    return FutureBuilder<Set<Marker>>(
      future: _loadMarkers(controllers),
      builder: (context, snapshot) {
        Set<Marker> markers = snapshot.data ?? {};

        return SizedBox(
          height: 500.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(23.8103, 90.4122),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController googleMapController) {},
              markers: markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
        );
      },
    );
  });
}

Future<Set<Marker>> _loadMarkers(ExploreStoreController controllers) async {
  Set<Marker> markers = {};

  Color logoBgColor = controllers.isProductStoreSelected.value
      ? const Color(0xFFE67E22)
      : const Color(0xFF9B59B6);

  if (controllers.isProductStoreSelected.value) {
    for (var store in controllers.productStoreList) {
      double lat = 23.8103;
      double lng = 90.4122;

      try {
        lat =
            store.latitude?.toDouble() ??
            store.cityId?.latitude?.toDouble() ??
            23.8103;
        lng =
            store.longitude?.toDouble() ??
            store.cityId?.longitude?.toDouble() ??
            90.4122;
      } catch (_) {
        lat = 23.8103;
        lng = 90.4122;
      }

      String title = store.displayName ?? "Store Name";
      String rating = store.averageRating?.toString() ?? "0.0";
      String? logoUrl;
      if (store.logo != null && store.logo!.isNotEmpty) {
        logoUrl = store.logo!.startsWith('http')
            ? store.logo
            : "${ApiEndPoint.imageUrl}${store.logo}";
      }

      BitmapDescriptor customIcon = await _createCustomMarkerBitmap(
        title,
        rating,
        logoBgColor,
        logoUrl,
      );

      markers.add(
        Marker(
          markerId: MarkerId(store.sId ?? DateTime.now().toString()),
          position: LatLng(lat, lng),
          icon: customIcon,
          onTap: () {
            Get.toNamed(
              AppRoutes.storeDetailsPage,
              arguments: controllers.isProductStoreSelected.value,
            );
          },
        ),
      );
    }
  } else {
    for (var store in controllers.serviceStoreList) {
      double lat = 23.8103;
      double lng = 90.4122;

      try {
        lat = store.cityId?.latitude?.toDouble() ?? 23.8103;
        lng = store.cityId?.longitude?.toDouble() ?? 90.4122;
      } catch (_) {
        lat = 23.8103;
        lng = 90.4122;
      }

      String title = store.displayName ?? "Store Name";
      String rating = store.averageRating?.toString() ?? "0.0";

      String? logoUrl;
      if (store.logo != null && store.logo!.isNotEmpty) {
        logoUrl = store.logo!.startsWith('http')
            ? store.logo
            : "${ApiEndPoint.imageUrl}${store.logo}";
      }

      BitmapDescriptor customIcon = await _createCustomMarkerBitmap(
        title,
        rating,
        logoBgColor,
        logoUrl,
      );

      markers.add(
        Marker(
          markerId: MarkerId(store.sId ?? DateTime.now().toString()),
          position: LatLng(lat, lng),
          icon: customIcon,
          onTap: () {
            Get.toNamed(
              AppRoutes.storeDetailsPage,
              arguments: controllers.isProductStoreSelected.value,
            );
          },
        ),
      );
    }
  }

  return markers;
}

