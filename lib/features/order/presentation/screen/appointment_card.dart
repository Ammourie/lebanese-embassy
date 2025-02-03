import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../account/data/remote/models/responses/get_field_model.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/show_dialog.dart';
import '../../../services/presentation/screen/create_service_request.dart';
import '../../data/remote/models/responses/get_order_model.dart';

class AppointmentCard extends StatefulWidget {
    AppointmentCard({required this.orderModel,required this.isFinished,super.key});
  OrderModel orderModel;
  bool isFinished;
  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return
      InkWell(

          onTap: () {
            setState(() {
              showAll = !showAll;
            });
          },
          // child:
          // LimitedBox(
          // maxHeight: 200,
            child:
              Container(
                // height: showAll==false?53.h:null,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                decoration:Styles.coloredRoundedDecoration(
                    borderColor:
                    Styles.colorTextWhite  ,
                    color: Styles.colorTextWhite ,radius:8.r
                ),

                    child:
                 Column(children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child:  CustomRichText(
                              alignmentGeometry: Alignment.centerRight,
                              textAlign: TextAlign.right,

                              text: [


                                TextSpan(
                                    text:  "الخدمة:"   +"\n",
                                    style: Styles.w600TextStyle().copyWith(
                                        color: Styles.colorTextAccountColor,
                                        fontSize: 14.sp,

                                        height: 33/16

                                    ),
                                ),
                                TextSpan(
                                    text:widget.orderModel.service!.name??'',
                                    style: Styles.w600TextStyle().copyWith(
                                        color: Styles.colorTextAccountColor,
                                        fontSize: 14.sp,
                                        height: 33/16

                                    ))]),),
                      Expanded(
                          child:  CustomRichText(
                              alignmentGeometry: Alignment.centerLeft,
                              textAlign: TextAlign.left,

                              text: [


                                TextSpan(
                                    text: (widget.orderModel.date??'') +" \n  ",
                                    style: Styles.w600TextStyle().copyWith(
                                        color: Styles.colorTextAccountColor,
                                        fontSize: 14.sp,

                                        height: 33/16

                                    )
                                ),
                                TextSpan(
                                    text:widget.orderModel.date??'',
                                    style: Styles.w600TextStyle().copyWith(
                                        color: Styles.colorTextAccountColor,
                                        fontSize: 14.sp,
                                        height: 33/16

                                    ))]),),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(!widget.isFinished)Container(
                        height: 35.h,
                        padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h) ,
                        decoration:


                        Styles.coloredRoundedDecoration(
                            borderColor:

                            Styles.colorTextAccountColor,
                            color:

                            Styles.colorTextWhite  ,radius:12.r
                        ),
                        child:

                        CustomText(text: 'الغاء',
                            alignmentGeometry: Alignment.center,
                            style: Styles.w600TextStyle().copyWith(
                                fontSize: 12.sp,
                                color:
                                Styles.colorTextAccountColor
                            )),
                      ),
                      CommonSizes.hSmallestSpace,

                      Container(
              height: 35.h,
                        padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h) ,
                        decoration:


                        Styles.coloredRoundedDecoration(
                            borderColor:

                            Styles.colorPrimary ,
                            color:

                            Styles.colorPrimary  ,radius:12.r
                        ),
                        child:

                        CustomText(text:
                        widget.isFinished?  'انهاء':
                        'اعادة جدولة',
                            alignmentGeometry: Alignment.center,
                            style: Styles.w600TextStyle().copyWith(
                                fontSize: 12.sp,
                                color:
                                Styles.colorTextWhite
                            )),
                      ),

                    ],
                  ),
                 ],)
             )
           // )
    );
  }

  _buildShowAll() {
    List<InfoData> lst =widget.orderModel.info??[];
    //  if (jsonDecode(widget.orderModel.info ?? '') != null) {
    //   //   json['info']=json['info'].runtimeType is String?
    //   // :json['info'];
    //
    //   jsonDecode(widget.orderModel.info ?? '').forEach((v) {
    //     lst.add(new InfoData.fromJson(v));
    //   });
    // }

     lst.sort((a, b) => a.group!.compareTo(b.group ?? ''));



    List<Widget> lstWidget = [];
    for (int i = 0; i < lst.length; i++) {
      lstWidget.addAll([
        CommonSizes.vSmallSpace,

        CustomRichText(
          alignmentGeometry: Alignment.centerRight,
          textAlign: TextAlign.right,

          text: [


             TextSpan(
                text: (lst[i].name??'')   +"  :  ",
                style: Styles.w600TextStyle().copyWith(
                    color: Styles.colorPrimary,
                    height: 33/16

                )
            ),
    TextSpan(
    text:lst[i].value??'',
    style: Styles.w600TextStyle().copyWith(
    color: Styles.colorText,
    height: 33/16

    ))

          ],

        ),


        CommonSizes.vSmallerSpace,






      ]);
    }
    for (int i = 0; i <       widget.orderModel.files!.length; i++) {
      lstWidget.addAll([
        CommonSizes.vSmallSpace,

        CustomRichText(
          alignmentGeometry: Alignment.centerRight,
          textAlign: TextAlign.right,

          text: [


            TextSpan(
                text: ( widget.orderModel.files![i].name??'')   +"  :  ",
                style: Styles.w600TextStyle().copyWith(
                    color: Styles.colorPrimary,
                    height: 33/16

                )
            ),


          ],

        ),
        CommonSizes.vSmallerSpace,

CustomPicture(path:  (widget.orderModel.files![i].path??''),isSVG: false,isLocal: false,),

        CommonSizes.vSmallerSpace,






      ]);
    }
    return lstWidget;
  }
}