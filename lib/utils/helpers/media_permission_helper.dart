import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPermissionHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Pick Image from Camera with platform-specific permission check
  static Future<File?> pickImageFromCamera() async {
    bool hasPermission = false;
    if (Platform.isAndroid) {
      hasPermission = await _handleAndroidCameraPermission();
    } else if (Platform.isIOS) {
      hasPermission = await _handleIOSCameraPermission();
    }

    if (!hasPermission) {
      _showPermissionSettingsDialog("Camera");
      return null;
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Pick Image from Gallery with platform-specific permission check
  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      bool hasPermission = false;
      if (Platform.isAndroid) {
        hasPermission = await _handleAndroidGalleryPermission();
      } else if (Platform.isIOS) {
        hasPermission = await _handleIOSGalleryPermission();
      }

      if (!hasPermission) {
        _showPermissionSettingsDialog("Gallery / Photo Library");
      }
      return null;
    }
  }

  /// Android Camera Permission Handler
  static Future<bool> _handleAndroidCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) return true;

    status = await Permission.camera.request();
    return status.isGranted;
  }

  /// iOS Camera Permission Handler
  static Future<bool> _handleIOSCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) return true;

    status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Android Gallery / Photo Permission Handler
  static Future<bool> _handleAndroidGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted) return true;

    var storageStatus = await Permission.storage.status;
    if (storageStatus.isGranted) return true;

    status = await Permission.photos.request();
    if (status.isGranted) return true;

    storageStatus = await Permission.storage.request();
    return storageStatus.isGranted;
  }

  /// iOS Gallery / Photo Permission Handler
  static Future<bool> _handleIOSGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted || status.isLimited) return true;

    status = await Permission.photos.request();
    return status.isGranted || status.isLimited;
  }

  /// Dialog when permission is denied -> redirect to App Settings
  static void _showPermissionSettingsDialog(String permissionName) {
    Get.defaultDialog(
      title: "Permission Required",
      middleText:
          "$permissionName permission is required to select photos. Please allow access in App Settings.",
      textConfirm: "Open Settings",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF27AE60),
      onConfirm: () {
        Get.back();
        openAppSettings();
      },
      onCancel: () => Get.back(),
    );
  }

  /// Show Bottom Sheet to choose between Camera and Gallery
  static Future<File?> showImageSourceBottomSheet(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF27AE60)),
                title: const Text("Take Photo (Camera)"),
                onTap: () async {
                  final file = await pickImageFromCamera();
                  if (ctx.mounted) {
                    Navigator.pop(ctx, file);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF27AE60)),
                title: const Text("Choose from Gallery"),
                onTap: () async {
                  final file = await pickImageFromGallery();
                  if (ctx.mounted) {
                    Navigator.pop(ctx, file);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
