import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final permissionServiceProvider = Provider((ref) => PermissionService());

class PermissionService {
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      // Try normal storage first
      var storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) return true;

      // If not granted, try manage external storage (for Android 11+)
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }

      return false;
    }
  }
  // Future<bool> requestStoragePermission() async {
  //   final status = await Permission.photos.request(); // iOS
  //   final storage = await Permission.storage.request(); // Android
  //   return status.isGranted && storage.isGranted;
  // }

  Future<bool> requestFilePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
