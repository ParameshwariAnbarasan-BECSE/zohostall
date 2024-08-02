import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MediaUtils {
  static Future<String?> pickMedia(String? type) async {
    final picker = ImagePicker();
    XFile? file;

    if (type == 'image') {
      file = await picker.pickImage(source: ImageSource.gallery);
    } else if (type == 'video') {
      file = await picker.pickVideo(source: ImageSource.gallery);
    }

    return file?.path;
  }
}
