import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../services/presentation/screen/edite_waiting_for_review_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/constants.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/show_dialog.dart';
import '../../../../service_locator.dart';
import '../../../services/data/remote/models/params/create_order_service_params.dart';
import '../../../services/presentation/screen/book_appointment_widget.dart';
import '../../../services/presentation/screen/create_service_request.dart';
import '../../data/remote/models/responses/get_order_model.dart';

class OrderCard extends StatefulWidget {
    OrderCard({required this.orderModel,super.key});
  OrderModel orderModel;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
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
            ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 450.h),
            child: Container(
                // height: showAll==false?53.h:null,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(8.r)),
                    border: Border(
                      right: BorderSide(
                        //                   <--- left side
                        color: Styles.colorPrimary,
                        width: 3.0,
                      ),
                    )),
                child:SingleChildScrollView(

                    physics:ClampingScrollPhysics() ,
                    child:
                 Column(children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: CustomText(
                            text: widget.orderModel.service!.name ?? '',
                            style: Styles.w600TextStyle().copyWith(
                              fontSize: 16.sp,
                              color: Styles.colorText,
                            ),
                            alignmentGeometry: Alignment.centerRight,
                          )),
                      InkWell(

                        onTap: () {

                        },
                        child: Container(
                          height: 24.w,
                           decoration:Styles.coloredOrderStatusRoundedDecoration( widget.orderModel.orderStatus!),
                          // Styles.coloredRoundedDecoration(
                          //   color: Styles.colorIconCardFamilyMember,
                          //   borderColor:
                          //   Styles.colorIconCardFamilyMember,
                          //   radius: 24.w,
                          // ),
                          padding: EdgeInsets.symmetric(horizontal: 10.w,),
                          child: CustomText(
                              text: (widget.orderModel!.status ?? '').compareTo('1')==0?'قيد المعالجة':widget.orderModel!.status ?? '',
                              style: Styles.coloredTextStyleOrderStatus(widget.orderModel.orderStatus!)),
                        ),
                      ),
                      CommonSizes.hSmallestSpace,
                      InkWell(
                        onTap: () async {
if(widget.orderModel.date!=null){
  showCustomDeleteMessageDialog(context:context,id:widget.orderModel.id??0,isDelete: true);

}else{
  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(name:
      RoutePaths.CreateServiceRequestScreen),
                          screen:  CreateServiceRequestScreen(
                          categoryId:int.tryParse( widget.orderModel.service!.categoryId??'0')??0
                            ,title: widget.orderModel.service!.name??'',
                          )
  );

}
                        },
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration:
                          Styles.coloredRoundedDecoration(
                            color: Styles.colorIconCardFamilyMember,
                            borderColor:
                            Styles.colorIconCardFamilyMember,
                            radius: 24.w,
                          ),
                          child: Icon(
                            Icons.delete_outline_outlined,
                            color: Styles.colorTextError,
                            size: 24.r,
                          ),
                        ),
                      ),
                      CommonSizes.hSmallestSpace,
                      InkWell(
                        onTap: () {
                          if(   (widget.orderModel!.status ?? '')
                              .compareTo('1')==0 ||   (widget.orderModel!.status ?? '')
                              .compareTo('قيد المعالجة')==0){
                            //go to waite
                            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(name:
                              RoutePaths.EditeWaitingForReviewScreen
                              ),
                              screen:  EditeWaitingForReviewScreen(

                              ),

                              withNavBar: false,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          }
                          else{

                            //go to book

                            // String? file;
                            // String? name;
                            // String? field_id;
                            FilesModelDataList fileMode=new FilesModelDataList(files: []);
                             for(int i=0;i< widget.orderModel.files!.length;i++){
                               fileMode.files!.add(
                                   FilesModelData(
                                     file: widget.orderModel!.files![i].path??'',
                                       name:widget.orderModel!.files![i].name??'' ,
                                       field_id:widget.orderModel!.files![i].fieldId.toString()
                                   )
                               );
                            }
                            Utils.pushNewScreenWithRouteSettings(context,
                                screen: BookAppointmentScreen(

                                  createOrderServiceParamsBody:
                                  CreateOrderServiceParamsBody(
                                    info: widget.orderModel.info,
id: widget.orderModel.id,
                                    client_id: sl<AppStateModel>().user!.data!.id ?? 0,
                                    date:
                                    // true
                                    //     ?

                                      DateTime.tryParse(widget.orderModel!.date??'')
                                        // :
                                    // DateTime.now()
                                    ,
                                    file:fileMode ,
                                    service_id: widget.orderModel.serviceId ?? 0,
                                  )
                                  ,
                                ), settings: RouteSettings(
                                    name: RoutePaths.BookAppointmentScreen));

                          }
                          //   showCustomEditeMessageDialog(context:context);
                          //
                          // }else{
                          //
                          // }
                          // PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                          //     context,
                          //     settings: RouteSettings(name:
                          //     RoutePaths.CreateServiceRequestScreen),
                          //     screen:  CreateServiceRequestScreen(
                          //       orderModel:  widget.orderModel,
                          //       categoryId:int.tryParse(
                          //
                          //           widget.orderModel.service!.categoryId??'0')??0
                          //       ,tittle: widget.orderModel.service!.name??'',
                          //         isEdite:true
                          //     )
                          // );
                        },
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration:
                          Styles.coloredRoundedDecoration(
                            color: Styles.colorIconCardFamilyMember,
                            borderColor:
                            Styles.colorIconCardFamilyMember,
                            radius: 24.w,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Styles.colorPrimary,
                            size: 24.r,
                          ),
                        ),
                      )
                    ],
                  ),
                  if(showAll) ..._buildShowAll()
                ],)
             ))
            ),
          // )
    );
  }

  _buildShowAll() {
    List<InfoData> lst = widget.orderModel.info??[];
     // if (jsonDecode(widget.orderModel.info ?? '') != null) {
     //  //   json['info']=json['info'].runtimeType is String?
     //  // :json['info'];
     //
     //  jsonDecode(widget.orderModel.info ?? '').forEach((v) {
     //    lst.add(new InfoData.fromJson(v));
     //  });
    // }

     lst.sort((a, b) => a.group!.compareTo(b.group ?? ''));



    List<Widget> lstWidget = [];
    for (int i = 0; i < lst.length; i++) {
      lstWidget.addAll([
        CommonSizes.vSmallSpace,
    Container(

        alignment:  Alignment.centerRight,
      child:     RichText(

          // alignmentGeometry: Alignment.centerRight,
          textAlign: TextAlign.right,
    text: new TextSpan(

    style: Styles.w300TextStyle().copyWith(
    fontSize: 14.sp, color: Styles.colorTextTitle),
    children:   [


        TextSpan(
            text: (lst[i].name??'')   +"  :  ",
            style: Styles.w600TextStyle().copyWith(
                color: Styles.colorPrimary,
                height: 33/16

            )
        ),
        lst[i].value!.contains('pdf')?
        WidgetSpan(child:
        buildPreviewFile(lst[i].value??'',lst[i].field_id??0)
        ) :
        Utils.isImageFile(
            lst[i].value!)
            ?
        WidgetSpan(child:
        buildPreviewFile(lst[i].value??'',lst[i].field_id??0)
        ) :
        TextSpan(
            text:lst[i].value??'',
            style: Styles.w600TextStyle().copyWith(
                color: Styles.colorText,
                height: 33/16

            )),

      ],

    ) ),
    ),
    //     CustomRichText(
    //       alignmentGeometry: Alignment.centerRight,
    //       textAlign: TextAlign.right,
    //
    //       text: [
    //
    //
    //          TextSpan(
    //             text: (lst[i].name??'')   +"  :  ",
    //             style: Styles.w600TextStyle().copyWith(
    //                 color: Styles.colorPrimary,
    //                 height: 33/16
    //
    //             )
    //         ),
    //  lst[i].value!.contains('pdf')?
    // WidgetSpan(child:
    // buildPreviewFile(lst[i].value??'',lst[i].field_id??0)
    // ) :
    //     Utils.isImageFile(
    //         lst[i].value!)?
    // TextSpan(
    // text:lst[i].value??'',
    // style: Styles.w600TextStyle().copyWith(
    // color: Styles.colorText,
    // height: 33/16
    //
    // )):
    // TextSpan(
    // text:lst[i].value??'',
    // style: Styles.w600TextStyle().copyWith(
    // color: Styles.colorText,
    // height: 33/16
    //
    // )),
    //
    //       ],
    //
    //     ),


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
 Widget buildPreviewFile(String path,int fieldId){
    String onlinePath='';

    for(int i=0;i<widget.orderModel.files!.length;i++){
      if(fieldId==widget.orderModel.files![i].fieldId){
        onlinePath=widget.orderModel.files![i].path??'';
      }
    }
    onlinePath=onlinePath.replaceAll('*','.');
    if(!Utils.isImageFile(onlinePath))
    {
      return  Container(
          height: 250.w,
          // width: 200.w,
          child:Center(child:
          SfPdfViewer.network(AppConfigurationsImageUrl+path)
          )
        // key: _pdfViewerKey,
      ) ;
    }
    else{
      return CustomPicture(path:path ,
        isSVG: false,
        isLocalFile: false,


        raduis: 8.r,
        fit: BoxFit.fill,
        height: 200.w,width: 200.w,);}
  }

}