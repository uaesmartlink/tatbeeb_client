import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/modules/dashboard/views/dashboard_view.dart';
import 'package:hallo_doctor_client/app/modules/widgets/background_container.dart';
import '../controllers/balance_controller.dart';

class BalanceView extends GetView<BalanceController> {
  BalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
          isArrowBack: 0,
          text: 'Charge Balance'.tr,
          widget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 40,
                            )
                          ]
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Balance'.tr,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFF125a9a),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Obx(
                                ()=> Text(
                                '${controller.balance.value.toString()} USD',
                                style: TextStyle(
                                    color:Colors.white ,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Text(
                            'Purchase consulting credits and consult more with our packages'.tr,
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                  ),
                  const SizedBox(height: 17,),
                  Text(
                    'Our Packages'.tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 12,),
                  PackageContainer(
                    text1: '25',
                    onTap: (){
                      controller.chargeBalance(25.0);
                    },
                  ),
                  PackageContainer(
                    text1: '50',
                    onTap: (){
                      controller.chargeBalance(50.0);
                    },
                  ),
                  PackageContainer(
                    text1: '100',
                    onTap: (){
                      controller.chargeBalance(100.0);
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

class PackageContainer extends StatelessWidget{
  final String text1;
  final VoidCallback onTap;
  PackageContainer({Key? key,required this.text1,required this.onTap}):super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 7),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              Text(
                'Pay $text1 USD',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF333333),
                ),
              ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF125a9a),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Text(
                'Buy Package'.tr,
                style: TextStyle(
                    color:Colors.white ,
                    fontSize: 11,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}