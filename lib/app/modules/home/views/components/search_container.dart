import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/localization.dart';

class SearchContainer extends StatelessWidget{
  final VoidCallback? onTap;

  const SearchContainer({Key? key,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: onTap,
       child: Container(
                height:60,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top:30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 40,
                      ),
                    ]
                ),
                child: Row(
                  children: [
                       Icon(
                          Icons.search,
                          color: Color(0xFF677294),
                          size: 15,
                       ),
                        const SizedBox(width: 7,),
                        Expanded(
                          child: Text('Search Doctor'.tr,
                              style: TextStyle(
                                  color: Color(0xFF677294),
                                  fontSize: (Get.locale==LocalizationService.locales[0])?15:13,
                              )
                          ),
                        ),

                  ],
                ),
              ),
    );
  }
}