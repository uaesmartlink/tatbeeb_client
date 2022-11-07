import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/profile/views/widgets/profile_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../widgets/background_container.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        isArrowBack: 0,
        text: 'Profile'.tr,
        widget: Obx(
          () => Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileButton(
                  icon: Icons.person,
                  text: controller.username.value,
                  onTap: () {},
                  hideArrowIcon: true,
                ),
                ProfileButton(
                  icon: Icons.settings,
                  text: 'Profile'.tr,
                  onTap: () {
                    controller.toProfileInfo();
                  },
                ),
                ProfileButton(
                  icon: Icons.language,
                  text: 'Languages'.tr,
                  onTap: () {
                    controller.toChangeLanguage();
                  },
                ),
                ProfileButton(
                  icon: Icons.privacy_tip,
                  text: 'privacy policy'.tr,
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://tatbeeb.app/privacy-policy/'));
                  },
                ),
                /*ProfileButton(
                  icon: Icons.,
                  text: 'terms of service'.tr,
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://tatbeeb.app/term-and-condition/'));
                  },
                ),*/
                ProfileButton(
                  icon: Icons.help,
                  text: 'Help Center'.tr,
                  onTap: () async{
                    await launchUrl(
                        Uri.parse('https://tatbeeb.app/terms-of-use-for-patients/'));
                  },
                ),
                ProfileButton(
                  hideArrowIcon: true,
                  icon: Icons.logout,
                  text: 'Logout'.tr,
                  onTap: () {
                    controller.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: DashboardView(),
    );
  }
}
