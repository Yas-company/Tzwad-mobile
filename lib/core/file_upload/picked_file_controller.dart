import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tzwad_mobile/core/file_upload/file_picker_service.dart';
import 'package:tzwad_mobile/core/file_upload/permission_service.dart';



final pickedFileProvider = StateNotifierProvider<PickedFileController, File?>(
      (ref) => PickedFileController(ref),
);

final imagePickerServiceProvider = Provider((ref) => ImagePickerService());

class ImagePickerService {
  final picker = ImagePicker();

  Future<File?> pickFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> pickFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}


class PickedFileController extends StateNotifier<File?> {
  final Ref ref;
  PickedFileController(this.ref) : super(null);

  Future<void> pickImageFromCamera() async {
    final hasPermission = await ref.read(permissionServiceProvider).requestCameraPermission();
    if (!hasPermission) return;

    final file = await ref.read(imagePickerServiceProvider).pickFromCamera();
    if (file != null) state = file;
  }

  Future<void> pickImageFromGallery() async {
    final hasPermission = await ref.read(permissionServiceProvider).requestStoragePermission();
    if (!hasPermission) return;

    final file = await ref.read(imagePickerServiceProvider).pickFromGallery();
    if (file != null) state = file;
  }

  void reset() {
    state = null;
  }
}

