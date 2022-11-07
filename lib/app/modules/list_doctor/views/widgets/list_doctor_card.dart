import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/utils/constants/style_constants.dart';

class DoctorCard extends StatelessWidget {
  final String doctorPhotoUrl;
  final String doctorName;
  final String doctorHospital;
  final String doctorPrice;
  final String doctorCategory;
  final VoidCallback onTap;
  const DoctorCard(
      {Key? key,
      required this.doctorPhotoUrl,
      required this.doctorName,
      required this.doctorHospital,
      required this.doctorPrice,
      required this.doctorCategory,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:20),
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
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(doctorPhotoUrl)),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            doctorName,
                            style: doctorNameStyle,
                          ),
                        ),
                        TextWithIcon(
                          text: doctorCategory,
                          imageAsset: 'assets/icons/Stethoscope.png',
                        ),
                        TextWithIcon(
                          text: doctorHospital,
                          imageAsset: 'assets/icons/hospital_icon.png',
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                                rating: 4.5,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                            ),
                            const SizedBox(width: 17,),
                            Text(
                              '$doctorPrice/hr',
                              style: priceNumberTextStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                margin: EdgeInsets.all(13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xFF125a9a),),
                child: Text(
                  'Book Consultation'.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({Key? key, required this.text, required this.imageAsset})
      : super(key: key);

  final String text;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Image.asset(
              imageAsset,
              height: 20,
              width: 20,
              color: Color(0xFF0faa9a),
            ),
          ),
          WidgetSpan(
              child: SizedBox(
            width: 6,
          )),
          TextSpan(
              text: text,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
