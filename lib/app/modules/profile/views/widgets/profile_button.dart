import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utils/localization.dart';

class ProfileButton extends StatelessWidget {
  /// Icon data
  const ProfileButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onTap,
      this.hideArrowIcon = false})
      : super(key: key);

  /// Icon data
  final IconData icon;

  /// Button text string
  final String text;

  /// Hide arrow icon
  final bool hideArrowIcon;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
                color: Color(0xFF1b4170),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                  text,
                  style: TextStyle(
                      fontSize: (Get.locale==LocalizationService.locales[0])?16:14,
                      color: Color(0xFF1b4170),
                  )
              ),
              Spacer(),
              hideArrowIcon
                  ? SizedBox.shrink()
                  : Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
