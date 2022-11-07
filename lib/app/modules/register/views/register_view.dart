import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/login/views/widgets/label_button.dart';
import 'package:hallo_doctor_client/app/modules/widgets/submit_button.dart';
import 'package:hallo_doctor_client/app/utils/helpers/validation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/log_container.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {

  static const List<String> gender=['male','female'];
  var dropDownGender=gender.map((e) {
    return DropdownMenuItem(
      value: e,
      child: Text(e),
    );
  }).toList();

   var dropDownAge= List<int>.generate(100, (i) => i+1).map((e) {
     return DropdownMenuItem(
       value: e.toString(),
       child: Text(e.toString()),
     );
   }).toList();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: LogContainer(
        widget: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 71),
                      Text(
                        'Register'.tr,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          if (value!.length <= 3) {
                            return 'Full name must be  3 or more characters'.tr;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (fullName) {
                          controller.fullName = fullName!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Full Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          if (!value!.isPhoneNumber) {
                            return 'Phone must be a valid phone number'.tr;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (phone) {
                          controller.phone = phone!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:Get.width/2.5,
                            child: FormBuilderDropdown(
                              initialValue: controller.gender,
                              name: 'Gender',
                              items: dropDownGender,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )),
                                fillColor: Colors.grey[200],
                                filled: true
                              ),
                              onChanged: (gender) {
                                controller.gender = gender.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          SizedBox(
                            width:Get.width/2.5,
                            child: FormBuilderDropdown(
                              initialValue: controller.age,
                              name: 'Age',
                              items: dropDownAge,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  fillColor: Colors.grey[200],
                                  filled: true
                              ),
                              onChanged: (age) {
                                controller.age = age.toString();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          if (value!.length < 3) {
                            return 'Name must be  3 or more characters'.tr;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (username) {
                          controller.username = username!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          return Validation().validateEmail(value);
                        }),
                        onSaved: (email) {
                          controller.email = email!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GetBuilder<RegisterController>(
                          builder: (controller) => TextFormField(
                                obscureText: controller.passwordVisible,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () {
                                  node.nextFocus();
                                },
                                validator: ((value) {
                                  if (value!.length < 6) {
                                    return 'Password must be more than six characters'.tr;
                                  } else {
                                    return null;
                                  }
                                }),
                                onSaved: (password) {
                                  controller.password = password!;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          controller.passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Color(0xFF1b4170)),
                                      onPressed: () {
                                        controller.passwordIconVisibility();
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        )),
                                    fillColor: Colors.grey[200],
                                    filled: true),
                              )),
                      const SizedBox(height:7,),
                      SizedBox(
                        height: height/35,
                        child: Obx(
                          ()=> Row(
                            children: [
                              Checkbox(
                                fillColor: MaterialStateProperty.all(Colors.white),
                                value:controller.isCheck.value ,
                                onChanged: (v){
                                    controller.isCheck.value=!controller.isCheck.value;
                                },
                              ),
                              Text(
                                'I agree with the '.tr,
                                style:TextStyle(
                                  color:Colors.white,
                                  fontSize: height/71,
                                ),
                              ),
                              InkWell(
                                onTap: ()async{
                                  await launchUrl(Uri.parse('https://tatbeeb.app/term-and-condition/'));
                                },
                                child: Text(
                                  'terms of service'.tr,
                                  style:TextStyle(
                                    color:Colors.white,
                                    fontSize: height/71,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Text(
                                ' and '.tr,
                                style:TextStyle(
                                  color:Colors.white,
                                  fontSize: height/71,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              InkWell(
                                onTap: ()async{
                                  await launchUrl(Uri.parse('https://tatbeeb.app/privacy-policy/'));
                                },
                                child: Text(
                                  'privacy policy'.tr,
                                  style:TextStyle(
                                    color:Colors.white,
                                    fontSize: height/71,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      submitButton(
                          onTap: () {
                            controller.signUpUser();
                          },
                          text: 'Register Now'.tr),
                      SizedBox(height: height * .01),
                      //DividerOr(),
                      /*Container(
                        width: Get.width,
                        height: 50,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            controller.loginGoogle();
                          },
                        ),
                      ),*/
                      LabelButton(
                        onTap: () {
                          Get.offAndToNamed("/login");
                        },
                        title: 'Already have an account ?'.tr,
                        subTitle: 'Login'.tr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
