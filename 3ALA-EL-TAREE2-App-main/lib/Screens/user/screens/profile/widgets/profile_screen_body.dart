import 'package:cabify/Screens/user/screens/profile/provider/profile_provider.dart';
import 'package:cabify/Screens/user/screens/profile/widgets/custom_profile_app_bar.dart';
import 'package:cabify/Screens/user/screens/profile/widgets/profile_image.dart';
import 'package:cabify/Screens/user/screens/profile/widgets/user_details.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:cabify/core/widgets/grey_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: provider.profileModel == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    spacing: 20.h,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomProfileAppBar(
                        enableEdit: provider.enableEdit,
                        onPressed: () => provider.toogleEdit(),
                      ),
                      ProfileImage(
                        onPressed: () =>
                            provider.uploadProfilePic(context: context),
                        selectedImage: provider.selectedImage,
                      ),
                      Column(
                        spacing: 15.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserDetails(
                            controller: provider.nameController,
                            editField: provider.enableEdit,
                            fieldLabel: "type your text here",
                            fieldName: "Your Name",
                          ),
                          UserDetails(
                            controller: provider.emailController,
                            editField: provider.enableEdit,
                            fieldLabel: "type your email here",
                            fieldName: "Email",
                          ),
                          UserDetails(
                            controller: provider.phoneController,
                            editField: provider.enableEdit,
                            fieldLabel: "type your phone number here",
                            fieldName: "Phone Number",
                          ),
                          UserDetails(
                            controller: provider.passwordController,
                            editField: provider.enableEdit,
                            fieldLabel: "type your password here",
                            fieldName: "Password",
                            isPassword: true,
                          ),
                        ],
                      ),
                      !provider.enableEdit
                          ? const GreyContainer(
                              title:
                                  "If you want to edit profile click on icon  ",
                              style: AppTextStyles.title20KBlueColor)
                          : CustomElevatedButton(
                              title: "Done",
                              onPressed: () {
                                provider.updateProfile(context: context);
                              },
                            )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
