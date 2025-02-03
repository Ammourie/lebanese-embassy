import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/widget/waiting_widget.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../service_locator.dart';
import '../../../account/data/remote/models/responses/user_model.dart';
import '../../../home/presentation/screens/home_screen.dart';

class WhoWeScreen extends StatefulWidget {
  WhoWeScreen();

  @override
  State<StatefulWidget> createState() => _WhoWescreenState();
}

class _WhoWescreenState extends State<WhoWeScreen> {
  @override
  void initState() {
    super.initState();
   }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool isRtl = false;




  List<Widget> widgetLsit=[];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body:SafeArea(

            bottom: true,
            top: false,
            maintainBottomViewPadding: false,
            child:  Container(
                color: Styles.colorAppBarBackground,
                width: screenSize.width,
                height: screenSize.height,
                child: Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 0.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(height: 150.h,
                            decoration: Styles.coloredRoundedDecoration(
                              color: Styles.colorAppBarBackground,
                              radius: 0,borderColor: Styles.colorAppBarBackground,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child:    Row(children: [
                              InkWell(
                                onTap: (){


                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                      width: 20.w,
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Styles.colorTextWhite,
                                      )),

                                  // ),
                                   ),
                              Expanded(child:
                              Container(
                                child: CustomText(
                                    textAlign: TextAlign.center,
                                    alignmentGeometry:
                                    Alignment.center,
                                    text: 'من نحن'??'',
                                    style: Styles.w400TextStyle()
                                        .copyWith(
                                        fontSize: 20.sp,
                                        color: Styles
                                            .colorTextWhite)),
                              ),),
                              SizedBox(width: 20.w,)
                            ],),
                          ),

                          Expanded(child:
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),

                            decoration:
                            BoxDecoration(
                                color: Styles.colorUserInfoBackGround,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.r),
                                    topRight: Radius.circular(50.r)
                                ),
                                border: Border(
                                  left: BorderSide( //                   <--- left side
                                    color: Styles.colorUserInfoBackGround,
                                    width: 1.0,
                                  ),

                                )),
                            child:



                            Container(

                                padding: EdgeInsets.symmetric(vertical: 20.w),


                                child:
                                Container(
                                    color: Styles.colorUserInfoBackGround,

                                    child:
                                   SingleChildScrollView(child:  Column(children: [
                                     Container(
                                       decoration: Styles.coloredRoundedDecoration(
                                         radius: 16.r,
                                         borderColor: Styles.colorBackground,
                                         color: Styles.colorBackground,
                                       ),
                                       padding: EdgeInsets.all(16.w),
                                       child: Column(children: [
                                         CommonSizes.vSmallSpace,
                                         Container(
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.start,
                                             crossAxisAlignment:
                                             CrossAxisAlignment.center,
                                             children: [
                                               CustomPicture(
                                                 path: AssetsPath.SVG_familyMember,
                                                 height: 32.w,
                                                 width: 32.w,
                                                 isLocal: true,
                                                 isSVG: true,
                                                 color: Styles.colorActiveText,
                                               ),
                                               Expanded(
                                                 child: CustomText(
                                                   text: 'عن السفارة',
                                                   style: Styles.w700TextStyle()
                                                       .copyWith(
                                                     color: Styles.colorTextAccountColor,
                                                     fontSize: 20.sp,
                                                     height: 29 / 16,
                                                   ),
                                                   alignmentGeometry: !isRtl
                                                       ? Alignment.centerRight
                                                       : Alignment.centerLeft,
                                                   paddingHorizantal: 20.w,
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),

                                         CommonSizes.vSmallestSpace,
                                         CustomText(
                                           text: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد .',
                                           style: Styles.w400TextStyle()
                                               .copyWith(
                                             color: Styles.colorTextAboutUs,
                                             fontSize: 16.sp,
                                             height: 29 / 16,
                                           ),
                                           alignmentGeometry: !isRtl
                                               ? Alignment.centerRight
                                               : Alignment.centerLeft,
                                           paddingHorizantal: 20.w,
                                         ),

                                       ],),
                                     ),

                                     Container(
                                         decoration: Styles.coloredRoundedDecoration(
                                           radius: 16.r,
                                           borderColor: Styles.colorBackground,
                                           color: Styles.colorBackground,
                                         ),
                                         padding: EdgeInsets.all(16.w),
                                         child: Column(children: [
                                           CommonSizes.vSmallSpace,
                                           Container(
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               crossAxisAlignment:
                                               CrossAxisAlignment.center,
                                               children: [
                                                 CustomPicture(
                                                   path: AssetsPath.SVGPrivacy,
                                                   height: 32.w,
                                                   width: 32.w,
                                                   isLocal: true,
                                                   isSVG: true,
                                                   color: Styles.colorActiveText,
                                                 ),
                                                 Expanded(
                                                   child: CustomText(
                                                     text: 'سياسة الخصوصية',
                                                     style: Styles.w700TextStyle()
                                                         .copyWith(
                                                       color: Styles.colorTextAccountColor,
                                                       fontSize: 20.sp,
                                                       height: 29 / 16,
                                                     ),
                                                     alignmentGeometry: !isRtl
                                                         ? Alignment.centerRight
                                                         : Alignment.centerLeft,
                                                     paddingHorizantal: 20.w,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),

                                           CommonSizes.vSmallestSpace,
                                           CustomText(
                                             text: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،',
                                             style: Styles.w400TextStyle()
                                                 .copyWith(
                                               color: Styles.colorTextAboutUs,
                                               fontSize: 16.sp,
                                               height: 29 / 16,
                                             ),
                                             alignmentGeometry: !isRtl
                                                 ? Alignment.centerRight
                                                 : Alignment.centerLeft,
                                             paddingHorizantal: 20.w,
                                           ),

                                         ])),


                                     Container(
                                         decoration: Styles.coloredRoundedDecoration(
                                           radius: 16.r,
                                           borderColor: Styles.colorBackground,
                                           color: Styles.colorBackground,
                                         ),
                                         padding: EdgeInsets.all(16.w),
                                         child: Column(children: [
                                           CommonSizes.vSmallSpace,
                                           Container(
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               crossAxisAlignment:
                                               CrossAxisAlignment.center,
                                               children: [
                                                 CustomPicture(
                                                   path: AssetsPath.SVGUsage,
                                                   height: 32.w,
                                                   width: 32.w,
                                                   isLocal: true,
                                                   isSVG: true,
                                                   color: Styles.colorActiveText,
                                                 ),
                                                 Expanded(
                                                   child: CustomText(
                                                     text: 'شروط الاستخدام',
                                                     style: Styles.w700TextStyle()
                                                         .copyWith(
                                                       color: Styles.colorTextAccountColor,
                                                       fontSize: 20.sp,
                                                       height: 29 / 16,
                                                     ),
                                                     alignmentGeometry: !isRtl
                                                         ? Alignment.centerRight
                                                         : Alignment.centerLeft,
                                                     paddingHorizantal: 20.w,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),

                                           CommonSizes.vSmallestSpace,
                                           CustomText(
                                             text: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،',
                                             style: Styles.w400TextStyle()
                                                 .copyWith(
                                               color: Styles.colorTextAboutUs,
                                               fontSize: 16.sp,
                                               height: 29 / 16,
                                             ),
                                             alignmentGeometry: !isRtl
                                                 ? Alignment.centerRight
                                                 : Alignment.centerLeft,
                                             paddingHorizantal: 20.w,
                                           ),

                                         ])),


                                     Container(
                                         decoration: Styles.coloredRoundedDecoration(
                                           radius: 16.r,
                                           borderColor: Styles.colorBackground,
                                           color: Styles.colorBackground,
                                         ),
                                         padding: EdgeInsets.all(16.w),
                                         child: Column(children: [
                                           CommonSizes.vSmallSpace,
                                           Container(
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               crossAxisAlignment:
                                               CrossAxisAlignment.center,
                                               children: [
                                                 CustomPicture(
                                                   path: AssetsPath.SVGHelpContact,
                                                   height: 32.w,
                                                   width: 32.w,
                                                   isLocal: true,
                                                   isSVG: true,
                                                   color: Styles.colorActiveText,
                                                 ),
                                                 Expanded(
                                                   child: CustomText(
                                                     text: 'التواصل والمساعدة',
                                                     style: Styles.w700TextStyle()
                                                         .copyWith(
                                                       color: Styles.colorTextAccountColor,
                                                       fontSize: 20.sp,
                                                       height: 29 / 16,
                                                     ),
                                                     alignmentGeometry: !isRtl
                                                         ? Alignment.centerRight
                                                         : Alignment.centerLeft,
                                                     paddingHorizantal: 20.w,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),

                                           CommonSizes.vSmallestSpace,
                                           CustomText(
                                             text: 'التواصل والمساعدة',
                                             style: Styles.w400TextStyle()
                                                 .copyWith(
                                               color: Styles.colorTextAboutUs,
                                               fontSize: 16.sp,
                                               height: 29 / 16,
                                             ),
                                             alignmentGeometry: !isRtl
                                                 ? Alignment.centerRight
                                                 : Alignment.centerLeft,
                                             paddingHorizantal: 20.w,
                                           ),
                                         ])),
                                     CommonSizes.vSmallSpace,

                                     CustomText(
                                       text: 'تواصل معنا',
                                       style: Styles.w700TextStyle()
                                           .copyWith(
                                         color: Styles.colorTextAccountColor,
                                         fontSize: 20.sp,
                                         height: 29 / 16,
                                       ),
                                       alignmentGeometry: !isRtl
                                           ? Alignment.centerRight
                                           : Alignment.centerLeft,
                                       paddingHorizantal: 20.w,
                                     ),
                                     Container(
                                         decoration: Styles.coloredRoundedDecoration(
                                           radius: 16.r,
                                           borderColor: Styles.colorBackground,
                                           color: Styles.colorBackground,
                                         ),
                                         padding: EdgeInsets.all(16.w),
                                         child: Column(children: [
                                           CommonSizes.vSmallSpace,
                                           Container(
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               crossAxisAlignment:
                                               CrossAxisAlignment.center,
                                               children: [
                                                 CustomPicture(
                                                   path: AssetsPath.SVGLocation,
                                                   height: 32.w,
                                                   width: 32.w,
                                                   isLocal: true,
                                                   isSVG: true,
                                                   color: Styles.colorActiveText,
                                                 ),
                                                 Expanded(
                                                   child: CustomText(
                                                     text: 'الموقع',
                                                     style: Styles.w700TextStyle()
                                                         .copyWith(
                                                       color: Styles.colorTextAccountColor,
                                                       fontSize: 20.sp,
                                                       height: 29 / 16,
                                                     ),
                                                     alignmentGeometry: !isRtl
                                                         ? Alignment.centerRight
                                                         : Alignment.centerLeft,
                                                     paddingHorizantal: 20.w,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                           CommonSizes.vSmallestSpace,
                                           CustomText(
                                             text: 'الرياض , شارع الرياض 1902',
                                             style: Styles.w400TextStyle()
                                                 .copyWith(
                                               color: Styles.colorTextAboutUs,
                                               fontSize: 16.sp,
                                               height: 29 / 16,
                                             ),
                                             alignmentGeometry: !isRtl
                                                 ? Alignment.centerRight
                                                 : Alignment.centerLeft,
                                             paddingHorizantal: 20.w,
                                           ),
CommonSizes.vSmallSpace,

                                           Container(
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               crossAxisAlignment:
                                               CrossAxisAlignment.center,
                                               children: [
                                                 Icon(Icons.access_time_outlined,size: 32.w,color: Styles.colorPrimary,),
                                                 Expanded(
                                                   child: CustomText(
                                                     text: 'ساعات المكتب',
                                                     style: Styles.w700TextStyle()
                                                         .copyWith(
                                                       color: Styles.colorTextAccountColor,
                                                       fontSize: 20.sp,
                                                       height: 29 / 16,
                                                     ),
                                                     alignmentGeometry: !isRtl
                                                         ? Alignment.centerRight
                                                         : Alignment.centerLeft,
                                                     paddingHorizantal: 20.w,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                           CommonSizes.vSmallestSpace,
                                           CustomText(
                                             text: '5:00 AM to 8:00 PM',
                                             style: Styles.w400TextStyle()
                                                 .copyWith(
                                               color: Styles.colorTextAboutUs,
                                               fontSize: 16.sp,
                                               height: 29 / 16,
                                             ),
                                             alignmentGeometry: !isRtl
                                                 ? Alignment.centerRight
                                                 : Alignment.centerLeft,
                                             paddingHorizantal: 20.w,
                                           ),

                                         ])),
                                     CommonSizes.vBiggestSpace  ,

                                   ],),)
                                   )),





                          )
                          )
                        ])
                )
            ))
    );
  }
}
