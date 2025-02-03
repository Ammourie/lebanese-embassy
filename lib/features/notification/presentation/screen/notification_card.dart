import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';

import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../service_locator.dart';
import '../../../services/presentation/screen/book_notification_appointment_widget.dart';
import '../../../services/presentation/screen/create_service_request.dart';
import '../../data/remote/models/responses/get_notification_model.dart';

class NotificationCard extends StatefulWidget {
    NotificationCard({required this.notificationModel,super.key});
  NotificationModel notificationModel;
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool showAll = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<AppStateModel>().decreaseNumOfNotificaiotn();

  }
  @override
  Widget build(BuildContext context) {
    return
      InkWell(

          onTap: () {
            if(widget.notificationModel.title=='تم تأكيد الطلب'){
PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                settings: RouteSettings(name:
                RoutePaths.BookNotificationAppointmentWidget),
                screen:  BookNotificationAppointmentWidget(

                   orderId:int.tryParse( widget.notificationModel.orderId??'')??0
                )
            );
            }
// PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//                 context,
//                 settings: RouteSettings(name:
//                 RoutePaths.CreateServiceRequestScreen),
//                 screen:  CreateServiceRequestScreen(
//
//                     isEdite:true,orderByID:
//                 )
//             );
          },
          // child:
          // LimitedBox(
          // maxHeight: 200,
            child:
             Container(
                // height: showAll==false?53.h:null,
                padding: EdgeInsets.symmetric(
                  vertical: 16.w,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(

                    borderRadius:
                    BorderRadius.all(Radius.circular(16.r)),
                    color: Styles.colorBackgroundWhite),
                child:
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,

                        child:CustomPicture(
                          width: 24.w,
                          height: 24.w,
                          path: AssetsPath.SVGDoneUploadImage,
                          isSVG: true,isLocal: true,),
                      ),
                      CommonSizes.hSmallestSpace,

                      Expanded(
                          child: CustomText(
                            text: widget.notificationModel.title?? '',
                            style: Styles.w700TextStyle().copyWith(
                              fontSize: 20.sp,
                              color: Styles.colorText,
                            ),
                            alignmentGeometry: Alignment.centerRight,
                          )),
                    ],
                  ),
                     CommonSizes.vSmallerSpace,
                     CustomText(
                     text: widget.notificationModel.text ?? '',
                     style: Styles.w400TextStyle().copyWith(
                       fontSize: 16.sp,
                       color: Styles.colorText,
                     ),
                     alignmentGeometry: Alignment.centerRight,
                   ),
                     CommonSizes.vSmallerSpace,
Row(children: [


                     Container(
                     // width: 100.w,
                       padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.w),
                       alignment: Alignment.centerRight ,
                       decoration:
                       Styles.coloredRoundedDecoration(
                         color: Styles.colorIconCardFamilyMember,
                         borderColor:
                         Styles.colorIconCardFamilyMember,
                         radius: 10.r,
                       ),
                       child:   RichText(

                         textAlign: TextAlign.center,
                         text: new TextSpan(
                             style: Styles.w300TextStyle()
                                 .copyWith(fontSize: 16.sp, color: Styles.colorTextTitle),
                             children: [
                               TextSpan(

                                 text:
                                 widget.notificationModel.title?? '',

                                 style: Styles.w600TextStyle().copyWith(
                                   color: Styles.colorPrimary,
                                   // height: 33/16,
                                   fontSize: 16.sp,
                                   //       color: Styles.colorText,

                                 ),
                               ),
                               WidgetSpan(
                                 child:
                                 Container(
                                   width: 24.w,
                                   height: 24.w,

                                   child:CustomPicture(
                                     width: 24.w,
                                     height: 24.w,
                                     path: AssetsPath.SVGArrow45,
                                     isSVG: true,isLocal: true,),
                                 ),
                               )
                             ]),
                       ),
                      )],)

                   // Row(children: [
                   //   CustomText(
                   //     text:widget.notificationModel.title?? '',
                   //     style: Styles.w700TextStyle().copyWith(
                   //       fontSize: 16.sp,
                   //       color: Styles.colorText,
                   //     ),
                   //     alignmentGeometry: Alignment.centerRight,
                   //   ),
                   //
                   //   Container(
                   //     width: 24.w,
                   //     height: 24.w,
                   //
                   //     child:CustomPicture(
                   //       width: 24.w,
                   //       height: 24.w,
                   //       path: AssetsPath.SVGArrow45,
                   //       isSVG: true,isLocal: true,),
                   //   ),
                   //
                   //
                   // ],
                   //   )
                 ],)
             )

          // )
    );
  }

 }