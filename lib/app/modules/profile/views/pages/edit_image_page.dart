import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hallo_doctor_client/app/modules/profile/controllers/profile_controller.dart';
import '../../../dashboard/views/dashboard_view.dart';

class EditImagePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {


    final VoidCallback onPressed = () async {
      final ImagePicker _picker = ImagePicker();
      XFile? image;
      File? imageFile;
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imageFile = File(image!.path);
      var imageCropped = await ImageCropper().cropImage(
          sourcePath: image!.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square]);
      if (imageCropped == null) return;
      imageFile = File(imageCropped.path);
      controller.updateProfilePic(imageFile!);
    };
    final color = Color.fromRGBO(64, 105, 225, 1);

    final oldImage = NetworkImage(controller.profilePic.value);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Image'.tr,
          //style: appbarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 330,
            child: Text(
              'Upload a photo of yourself '.tr,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              child: Container(
                child: Center(
                  child: Stack(children: [
                    buildImage(color, oldImage),
                    Positioned(
                      child: buildEditIcon(color, onPressed),
                      right: 0,
                      top: 0,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: DashboardView(),
    );
  }

  Widget buildImage(Color color, NetworkImage image) {
    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  Widget buildEditIcon(Color color, VoidCallback onPressed) => buildCircle(
      all: 0.5,
      child: IconButton(
        icon: Icon(
          Icons.edit,
        ),
        iconSize: 20,
        color: color,
        onPressed: onPressed,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
