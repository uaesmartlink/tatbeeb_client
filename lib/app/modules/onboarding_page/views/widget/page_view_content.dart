import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewContent extends StatelessWidget{
  final String? image;
  final String? title;
  final String? text;
  final VoidCallback onTap;

  const PageViewContent({Key? key,required this.image,required this.title,required this.text,required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                image!,
              ),
              fit: BoxFit.cover
          )
      ),
      child: Column(
        children: [
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.height/3,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Color(0xFF1b4170),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(51),
                    topRight:Radius.circular(51)
                )
            ),
            child: Column(
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 12,),
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    Get.toNamed('/login');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 54,
                    margin: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color(0xFF0faa9a)
                    ),
                    child: Text(
                      'Get Started'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: onTap,
                    child: Text(
                      'Skip'.tr,
                      style: TextStyle(
                          color: Color(0xFF0faa9a)
                      ),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}