import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/controllers/login_controller.dart';
import 'package:hallo_doctor_client/app/service/auth_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  LoginController loginController = Get.find();
  AuthService authService = Get.find();
  final count = 0.obs;
  var formkey = GlobalKey<FormState>();
  var username = '';
  var fullName = '';
  var phone = '';
  var age = '1';
  var gender = 'male';
  var email = '';
  var password = '';
  var passwordVisible = false;
  var isCheck=false.obs;

  @override
  void onClose() {}

  void increment() => count.value++;

  void signUpUser() async {
    if(isCheck.isTrue) {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();

        EasyLoading.show(
            status: 'loading...', maskType: EasyLoadingMaskType.black);
        authService.register(fullName,phone,gender,age,username, email, password).then((value) {
          Get.offAllNamed('/dashboard');
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(
              msg: error.toString(), toastLength: Toast.LENGTH_LONG);
        }).whenComplete(() {
          EasyLoading.dismiss();
        });
      }
    }
    else{
      Fluttertoast.showToast(msg: 'Please check the box of agreement');
    }
  }

  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  /*void loginGoogle() {
    authService.loginGoogle().then((value) => Get.offAllNamed('/dashboard'));
  }*/
}
