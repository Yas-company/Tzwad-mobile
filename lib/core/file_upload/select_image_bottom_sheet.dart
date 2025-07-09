import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';

void showSelectImageBottomSheet(BuildContext context, WidgetRef ref, {bool allowFiles = false}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    builder: (_) {
      return Container(
        height: allowFiles ? 200 : 150,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.blue, width: 2)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_back),
              title: const Text('اضافة صورة من ملف الصور'),
              onTap: () {
                Navigator.pop(context);
                ref.read(pickedFileProvider.notifier).pickImageFromGallery();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('افتح الكاميرا'),
              onTap: () {
                Navigator.pop(context);
                ref.read(pickedFileProvider.notifier).pickImageFromCamera();
              },
            ),
            if (allowFiles) const Divider(),
            if (allowFiles)
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('اختر ملف PDF'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(pickedFileProvider.notifier).pickPdfFile();
                },
              ),
          ],
        ),
      );
    },
  );
}
