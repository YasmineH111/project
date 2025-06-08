import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({required ImageSource source}) async {
  final picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    return File(image.path);
  }
  return File('');
}
