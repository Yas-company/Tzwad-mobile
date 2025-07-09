import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagePickerServiceProvider = Provider((ref) => ImagePickerService());

class ImagePickerService {
  final _picker = ImagePicker();

  Future<File?> pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
