// ignore_for_file: use_build_context_synchronously

import 'package:cabify/Screens/user/widgets/image_type.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/function/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

AlertDialog showAlertDialog({required BuildContext context}) {
  return AlertDialog(
    title: const Text("Select Image"),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageType(
            icon: Icons.camera_alt_outlined,
            title: "Camera",
            onTap: () async {
              Navigator.pop(context);
              final image = await pickImage(source: ImageSource.camera);
              if (image != null) {
                await locator<CacheHelper>()
                    .saveData(key: 'profile', value: image.path);
              }
            },
          ),
          ImageType(
            icon: Icons.image,
            title: "Gallery",
            onTap: () async {
              Navigator.pop(context);
              final image = await pickImage(source: ImageSource.gallery);
              if (image != null) {
                await locator<CacheHelper>()
                    .saveData(key: 'profile', value: image.path);
              }
            },
          ),
        ],
      )
    ],
  );
}
