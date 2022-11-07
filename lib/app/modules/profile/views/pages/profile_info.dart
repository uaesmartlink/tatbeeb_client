import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/widgets/profile_button.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/display_image_widget.dart';

class ProfileInfo extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(
          () => Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              DisplayImage(
                imagePath: controller.profilePic.value,
                onPressed: () {
                  controller.toEditImage();
                },
              ),
              Card(
                margin: EdgeInsets.only(top: 25, left: 5, right: 5),
                elevation: 3,
                child: Column(
                  children: [
                    ProfileButton(
                      icon: Icons.person,
                      text: controller.username.value,
                      onTap: () {},
                      hideArrowIcon: true,
                    ),
                    ProfileButton(
                      icon: Icons.email,
                      text: controller.email.value,
                      onTap: () {
                        controller.toUpdateEmail();
                      },
                    ),
                    ProfileButton(
                      icon: Icons.password,
                      text: 'Change Password'.tr,
                      onTap: () {
                        controller.toChangePassword();
                      },
                    ),
                    //uncomment if you wanto test something
                    // ElevatedButton(
                    //   onPressed: () {
                    //     controller.testButton();
                    //     //LocalizationService().changeLocale('France');
                    //   },
                    //   child: Text('test button'),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
