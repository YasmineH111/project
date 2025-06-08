// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/function/show_alerat_dialog.dart';
import 'package:cabify/core/services/api/api_consumer.dart';
import 'package:cabify/core/services/api/end_points.dart';
import 'package:cabify/model/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiConsumer apiConsumer;
  bool enableEdit = false;
  ProfileModel? profileModel;
  final formKey = GlobalKey<FormState>();
  ProfileProvider({required this.apiConsumer}) {
    getProifleData();
  }

  getProifleData() async {
    final data = await apiConsumer.get(
      '${EndPoints.getUserProfile}${await locator<CacheHelper>().getData(key: "userId")}',
    );
    profileModel = ProfileModel.fromJson(data);
    locator<CacheHelper>().saveData(key: "name", value: profileModel?.name);
    nameController.text = profileModel!.name;
    emailController.text = profileModel!.email;
    phoneController.text = profileModel!.mobileNumber;
    passwordController.text = profileModel!.passengerId.toString();
    notifyListeners();
  }

  //////////////////////
  File? selectedImage;
  void uploadProfilePic({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return showAlertDialog(context: context);
      },
    ).then((_) async {
      await updateImage();
      notifyListeners();
    });
  }

  updateImage() async {
    final profileImagePath =
        await locator<CacheHelper>().getData(key: 'profile');
    if (profileImagePath != null) {
      selectedImage = File(profileImagePath);
    }
    notifyListeners();
    log(selectedImage.toString());
  }

  //////////////////////////////////
  updateProfile({required BuildContext context}) async {
    profileModel = null;
    notifyListeners();
    try {
      final data = await apiConsumer.put(
          '${EndPoints.updateProfile}${locator<CacheHelper>().getData(key: "userId")}',
          data: {
            "name": nameController.text,
            "mobileNumber": phoneController.text,
            "email": emailController.text,
            "password": passwordController.text
          });
      profileModel = ProfileModel.fromJson(data["passenger"]);
      nameController.text = profileModel!.name;
      emailController.text = profileModel!.email;
      phoneController.text = profileModel!.mobileNumber;
      passwordController.text = profileModel!.passengerId.toString();
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update profile${e.toString()}"),
        ),
      );
    }
  }

///////////////////////
  void toogleEdit() {
    enableEdit = !enableEdit;
    notifyListeners();
  }
}
