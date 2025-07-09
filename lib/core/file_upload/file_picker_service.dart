// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final filePickerServiceProvider = Provider((ref) => FilePickerService());
//
// class FilePickerService {
//   Future<File?> pickPdfFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     return result != null && result.files.single.path != null
//         ? File(result.files.single.path!)
//         : null;
//   }
// }
