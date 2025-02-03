import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_path.dart';
import '../styles.dart';
import '../utils.dart';
import 'custom_svg_picture.dart';
import 'custom_text.dart';
import 'show_dialog.dart';
import 'waiting_widget.dart';

import '../../features/account/data/remote/models/params/update_info_field_params.dart';
import '../../features/account/data/remote/models/responses/family_group_field.dart';
import '../../features/account/presentation/blocs/account_bloc.dart';
import '../../features/order/data/remote/models/params/delete_order_params.dart';
import '../../features/order/data/remote/models/params/get_order_params.dart';
import '../../features/order/presentation/blocs/order_bloc.dart';
import '../../service_locator.dart';
import '../shared_preferences_items.dart';
import '../state/appstate.dart';
import '../utils/common_sizes.dart';
import 'custom_button.dart';
import 'custom_rich_text.dart';
import 'error_widget.dart';


class DialgContent extends StatelessWidget {

  bool isConfirmDelete;
  String nameToDelete;
  Function(BuildContext context) onButtonPressed;
  Function(BuildContext context) onCancelPressed;

  DialgContent(
      {
      required this.onButtonPressed,
      required this.onCancelPressed,
        required this.isConfirmDelete,
        required this.nameToDelete,
    });
  AccountBloc _accountBloc = new AccountBloc();

  @override
  Widget build(BuildContext context) {

       return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        child: Container(
            width: 350.w,
            height: 445.h,
            padding: EdgeInsets.all(CommonSizes.Size_16_HGAP),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
            child:

        Stack(
          children: [

            Positioned(
                left: 0,
                top: 0,

                child:  InkWell(
               onTap: (){
                 Utils.popNavigate(context);
               },
               child:   Icon(Icons.close,color: Styles.colorPrimary,))),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  CustomPicture(
                    width: 200.w,height: 150.w,
                    path: AssetsPath.SVGDialogExcuseImage,isLocal: true,isSVG: true,),
                  CommonSizes.vSmallSpace,
                  CustomText(
                      paddingHorizantal: 16.w,
                      alignmentGeometry: Alignment.center,
                      textAlign: TextAlign.center,
                      text:
                      isConfirmDelete?
                          'هل أنت متأكد من عملية  الحذف؟'
                          :
                      '"عذرًا، لا يمكنك التقدم للحصول على الخدمات حاليًا. يرجى الانتظار حتى يتم التحقق من حسابك لضمان تجربة آمنة وموثوقة.”',
                      style: Styles.w600TextStyle().copyWith(
                        fontSize: 16.sp,color: Styles.colorText,
                      )),
                  CommonSizes.vSmallSpace,

                  if(isConfirmDelete)


                    Container(padding: EdgeInsets.symmetric(horizontal
           :20.w),child:

    BlocConsumer<AccountBloc, AccountState>(
    bloc: _accountBloc,
    listener: (context, AccountState state) async {
    if (state is AccountLoading) {
    print('loading');
    }
    if(state is UpdateInfoFieldLoaded){
    String family=jsonEncode( state.getRegisterFieldEntity!.userModel!.data!.family);

    sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Family_Data,family);


    Utils.popNavigate(context);

    }

    },
    builder: (context, state) {
    if (state is AccountLoading)
    return WaitingWidget();
    if (state is AccountError)
    return ErrorWidgetScreen(
    callBack: () {},
    message: state.message ?? "",
    height: 250.h,
    width: 250.w,
    );
    return
    Center(
    child:Row(children: [


      Expanded(child:  Center(
      child: CustomButton(
        width: double.infinity,

        text: 'حذف',

        style: Styles.w700TextStyle().copyWith(
          fontSize: 16.sp,
          height: 24/16,
          color: Styles.colorTextWhite,
        ),
        raduis: 8.r,
        textAlign: TextAlign.center,
        color: Styles.colorTextError,
        fillColor: Styles.colorTextError,
        // width: 350.w,
        height: 54.h,
        alignmentDirectional: AlignmentDirectional.center,
        onPressed:(){
          String family=sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Family_Data)??'';



          FamilyGroupField  familyGroupField=FamilyGroupField.fromJson(jsonDecode(family));


              familyGroupField!.groups.removeWhere((e)=>e.compareTo(nameToDelete??'')==0);
              familyGroupField!.groupedFields.removeWhere((key, value) => key.compareTo(nameToDelete??'')==0,);
              ;

          _accountBloc.add(UpdateUpdateInfoFieldEvent(
              updateInfoFieldParams: UpdateInfoFieldParams(
                  body: UpdateInfoFieldParamsBody(
                    familyGroupField: familyGroupField,
                    withFamily: true,
                  ))));
          // Utils.popNavigate(context);

        },
      ),
    )),
      CommonSizes.hBigSpace,
      Expanded(child:
      Center(
        child: CustomButton(
          width: double.infinity,

          text: 'الغاء',

          style: Styles.w700TextStyle().copyWith(
            fontSize: 16.sp,
            height: 24/16,
            color: Styles.colorPrimary,
          ),
          raduis: 8.r,
          textAlign: TextAlign.center,
          color: Styles.colorPrimary,
          fillColor: Styles.colorBackground,
          // width: 350.w,
          height: 54.h,
          alignmentDirectional: AlignmentDirectional.center,
          onPressed:(){
            Utils.popNavigate(context);
          },
        ),
      )
      )
                    ],));}
    )
                    ),
                  if(!isConfirmDelete)
                  Container(padding: EdgeInsets.symmetric(horizontal
                      :70.w),
                    child:  Center(
                    child:
                    CustomButton(
                      width: double.infinity,

                      text: 'موافق',

                      style: Styles.w700TextStyle().copyWith(
                        fontSize: 16.sp,
                        height: 24/16,
                        color: Styles.colorTextWhite,
                      ),
                      raduis: 8.r,
                      textAlign: TextAlign.center,
                      color: Styles.colorPrimary,
                      fillColor: Styles.colorPrimary,
                      // width: 350.w,
                      height: 54.h,
                      alignmentDirectional: AlignmentDirectional.center,
                      onPressed:(){
                        Utils.popNavigate(context);
                      },
                    ),
                  ),)
                ]),
          ],
        )),


      );

   }
}

Future<void> showCustomMessageDialog({
  required Function(BuildContext context) onButtonPressed,
  required Function(BuildContext context) onCancelPressed,
    required BuildContext context,
  required bool isConfirmDelete,
  required String nameToDelete
}) async {
  await ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {
      return DialgContent(
        isConfirmDelete:isConfirmDelete,
        nameToDelete:nameToDelete,
          onButtonPressed: onButtonPressed,
          onCancelPressed: onCancelPressed,
          );
    },
  );
}

Future<void> showCustomEditeMessageDialog({
    required BuildContext context,
}) async {
  await ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {
      return  Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        child: Container(
            width: 350.w,
            height: 445.h,
            padding: EdgeInsets.all(CommonSizes.Size_16_HGAP),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
            child:

            Stack(
              children: [

                Positioned(
                    left: 0,
                    top: 0,

                    child:  InkWell(
                        onTap: (){
                          Utils.popNavigate(context);
                        },
                        child:   Icon(Icons.close,color: Styles.colorPrimary,))),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      CustomPicture(
                        width: 200.w,height: 150.w,
                        path: AssetsPath.SVGDialogExcuseImage,isLocal: true,isSVG: true,),
                      CommonSizes.vSmallSpace,
                      CustomText(
                          paddingHorizantal: 16.w,
                          alignmentGeometry: Alignment.center,
                          textAlign: TextAlign.center,
                          text:
                           'هذا الطلب متعلق بموعد لا يمكن تعديله',

                          style: Styles.w600TextStyle().copyWith(
                            fontSize: 16.sp,color: Styles.colorText,
                          )),
                      CommonSizes.vSmallSpace,




                        Container(padding: EdgeInsets.symmetric(horizontal
                            :70.w),
                          child:  Center(
                            child: CustomButton(
                              width: double.infinity,

                              text: 'موافق',

                              style: Styles.w700TextStyle().copyWith(
                                fontSize: 16.sp,
                                height: 24/16,
                                color: Styles.colorTextWhite,
                              ),
                              raduis: 8.r,
                              textAlign: TextAlign.center,
                              color: Styles.colorPrimary,
                              fillColor: Styles.colorPrimary,
                              // width: 350.w,
                              height: 54.h,
                              alignmentDirectional: AlignmentDirectional.center,
                              onPressed:(){
                                Utils.popNavigate(context);
                              },
                            ),
                          ),)
                    ]),
              ],
            )),


      );
    },
  );
}
Future<void> showCustomDeleteMessageDialog({
    required BuildContext context,
  required int id,
  required bool isDelete
}) async {
  await ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {
      OrderBloc _orderBloc=new OrderBloc();


      return  Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        child: Container(
            width: 350.w,
            height: 445.h,
            padding: EdgeInsets.all(CommonSizes.Size_16_HGAP),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
            child:

            Stack(
              children: [

                Positioned(
                    left: 0,
                    top: 0,

                    child:  InkWell(
                        onTap: (){
                          Utils.popNavigate(context);
                        },
                        child:   Icon(Icons.close,color: Styles.colorPrimary,))),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      CustomPicture(
                        width: 200.w,height: 150.w,
                        path: AssetsPath.SVGDialogExcuseImage,isLocal: true,isSVG: true,),
                      CommonSizes.vSmallSpace,
                      CustomText(
                          paddingHorizantal: 16.w,
                          alignmentGeometry: Alignment.center,
                          textAlign: TextAlign.center,
                          text:
                          isDelete?
                          'هل أنت متأكد من عملية  الحذف؟'
                              :  'هذا الطلب متعلق بموعد لا يمكن تعديله',

                          style: Styles.w600TextStyle().copyWith(
                            fontSize: 16.sp,color: Styles.colorText,
                          )),
                      CommonSizes.vSmallSpace,



  Container(
  child: BlocConsumer<OrderBloc , OrderState>(
  bloc: _orderBloc,
  listener: (context, OrderState state) async {
  if (state is OrderLoading) {
  print('loading');
  } else if (state is DeleteOrdersLoaded ) {
  sl<OrderBloc>().add(GetOrdersEvent(
  getOrderParams: GetOrderParams(
  body:GetOrderParamsBody(
  ))));
  Utils.popNavigate(context);

  }else if (state is OrderError ) {
    Utils.popNavigate(context,popsCount: 2);
  }




  //
  },
  builder: (context, state) {
  if (state is OrderLoading)
  return WaitingWidget();
  if (state is OrderError)
  return ErrorWidgetScreen(
  callBack: () {

  },
  message: state.message ?? "",
  // height: 150.h,
  width: 250.w,
  );
  return
                        Container(padding: EdgeInsets.symmetric(horizontal
                            :70.w),

                          child: Center(
                              child:Row(children: [


                                Expanded(child:  Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'حذف',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorTextWhite,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorTextError,
                                    fillColor: Styles.colorTextError,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:(){

                                      _orderBloc.add(DeleteOrdersEvent(
                                          deleteOrderParams: DeleteOrderParams(
                                              body: DeleteOrderParamsBody(

                                              ))));
                                      // Utils.popNavigate(context);

                                    },
                                  ),
                                )),
                                CommonSizes.hBigSpace,
                                Expanded(child:
                                Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'الغاء',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorPrimary,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorPrimary,
                                    fillColor: Styles.colorBackground,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:(){
                                      Utils.popNavigate(context);
                                    },
                                  ),
                                )
                                )
                              ],))
                        );
  }
  ))

                    ]),
              ],
            )),


      );
    },
  );
}
Future<void> showCustomErrorMessageDialog({
    required BuildContext context,
    required String message,
    required Function callBack,

}) async {
  await ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {


      return  Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        child: Container(
            width: 350.w,
            height: 445.h,
            padding: EdgeInsets.all(CommonSizes.Size_16_HGAP),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
            child:

            Stack(
              children: [

                Positioned(
                    left: 0,
                    top: 0,

                    child:  InkWell(
                        onTap: (){
                          Utils.popNavigate(context);
                        },
                        child:   Icon(Icons.close,color: Styles.colorPrimary,))),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      CustomPicture(
                        width: 200.w,height: 150.w,
                        path: AssetsPath.SVGDialogExcuseImage,isLocal: true,isSVG: true,),
                      CommonSizes.vSmallSpace,
                      CustomText(
                          paddingHorizantal: 16.w,
                          alignmentGeometry: Alignment.center,
                          textAlign: TextAlign.center,
                          text:message,

                          style: Styles.w600TextStyle().copyWith(
                            fontSize: 16.sp,color: Styles.colorText,
                          )),
                      CommonSizes.vSmallSpace,



                        Container(padding: EdgeInsets.symmetric(horizontal
                            :20.w),

                          child: Center(
                              child:Row(children: [


                                Expanded(child:  Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'اعادة طلب',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorTextWhite,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorTextError,
                                    fillColor: Styles.colorTextError,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:callBack,
                                  ),
                                )),
                                CommonSizes.hBigSpace,
                                Expanded(child:
                                Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'الغاء',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorPrimary,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorPrimary,
                                    fillColor: Styles.colorBackground,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:(){
                                      Utils.popNavigate(context);
                                    },
                                  ),
                                )
                                )
                              ],))


                            )
                    ]
                        ),
              ],
            )),


      );
    },
  );
}
Future<void> showCustomDialogServeMessageDialog({
    required BuildContext context,
    required String message,
    required Function callBack,

}) async {
  await ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {


      return  Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        child: Container(
            width: 350.w,
            height: 300.h,
            padding: EdgeInsets.all(CommonSizes.Size_16_HGAP),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
            child:

            Stack(
              children: [

                Positioned(
                    left: 0,
                    top: 0,

                    child:  InkWell(
                        onTap: (){
                          Navigator.pop(context);                                                },
                        child:   Icon(Icons.close,color: Styles.colorPrimary,))),
            Positioned(
              left: 20.w,
              right: 20.w,
              top: 20.w,

             child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    CustomRichText(
                    alignmentGeometry: Alignment.center,
                    textAlign: TextAlign.center,


                    text: [


                      TextSpan(
                        text:  "يمكنك الحصول عىل التاشيرة عند الوصول. لمعلومات اكثر يرجى مراجعة موقع",
                        style: Styles.w400TextStyle().copyWith(
                            color: Styles.colorTextAccountColor,
                            fontSize: 16.sp,

                            height: 33/16

                        ),
                      ),
                      TextSpan(
                          text: "\n"+" الأمن العام اللبناني.",

                          style: Styles.w700TextStyle().copyWith(
                              color: Styles.colorPrimary,
                              fontSize: 16.sp,
                              height: 33/16,

                          ))]),
                             CommonSizes.vSmallSpace,




                        Container(padding: EdgeInsets.symmetric(horizontal
                            :20.w),

                          child: Center(
                              child:Row(children: [


                                Expanded(child:  Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'موافق',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorTextWhite,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorPrimary,
                                    fillColor: Styles.colorPrimary,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:callBack,
                                  ),
                                )),

                              ],))


                            )
                    ]
                        ),)
              ],
            )),


      );
    },
  );
}
Future<void> showCustomBookMessageDialog({
    required BuildContext context,
    required String date,
    required String time,
    required Function callBack,

}) async {
  await ShowDialog().showElasticDialog(
    context: context,
    builder: (BuildContext myContext) {


      return  Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        child: Container(
            width: 350.w,
            height: 372.h,
            padding: EdgeInsets.all(CommonSizes.Size_16_HGAP),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
            child:

            Stack(
              children: [


                Positioned(
                    left: 0,
                    top: 0,

                    child:  InkWell(
                        onTap: (){
                          Navigator.pop(context);                                                },
                        child:   Icon(Icons.close,color: Styles.colorPrimary,))),
            Positioned(
              left: 20.w,
              right: 20.w,
              top: 20.w,

             child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPicture(
                        width: 60.w,height: 60.w,
                        path: AssetsPath.SVGconfirmBook,isLocal: true,isSVG: true,),
                      CommonSizes.vSmallSpace,

                      CustomRichText(
                    alignmentGeometry: Alignment.center,
                    textAlign: TextAlign.center,


                    text: [


                      TextSpan(
                        text:  "هل تريد بالتأكيد جدولة الموعد في :",
                        style: Styles.w400TextStyle().copyWith(
                            color: Styles.colorTextAccountColor,
                            fontSize: 16.sp,

                            height: 33/16

                        ),
                      ),
                        ]
                    ),

                            Container(
                                child:
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                               Expanded(child:  CustomText(text: date,
                                   alignmentGeometry: Alignment.centerLeft,
                                   textAlign: TextAlign.end,
                                   style: Styles.w700TextStyle().copyWith(
                                     color: Styles.colorTextAboutUs,fontSize: 18.sp,
                                   ))),
                                 CommonSizes.hSmallestSpace,
                                 Container(
height: 25.h,
                                   width: 1,color: Styles.colorTextAboutUs.withOpacity(0.25),),
                                 CommonSizes.hSmallestSpace,
Expanded(child:
                                   CustomText(
                                       alignmentGeometry: Alignment.centerRight,
                                       textAlign: TextAlign.start,                                       text: time,
                                     style: Styles.w700TextStyle().copyWith(
                                       color: Styles.colorTextAboutUs,fontSize: 18.sp,
                                     )  )),
                             ],)),
                             CommonSizes.vSmallSpace,




                        Container(padding: EdgeInsets.symmetric(horizontal
                            :20.w),

                          child: Center(
                              child:Row(children: [


                                Expanded(child:  Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'اعادة جدولة',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorTextWhite,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorbtnGray,
                                    fillColor: Styles.colorbtnGray,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:() {
      Navigator.pop(context);

    },
                                  ),
                                )),
                                CommonSizes.hSmallestSpace,
                                Expanded(child:  Center(
                                  child: CustomButton(
                                    width: double.infinity,

                                    text: 'موافق',

                                    style: Styles.w700TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      height: 24/16,
                                      color: Styles.colorTextWhite,
                                    ),
                                    raduis: 8.r,
                                    textAlign: TextAlign.center,
                                    color: Styles.colorPrimary,
                                    fillColor: Styles.colorPrimary,
                                    // width: 350.w,
                                    height: 54.h,
                                    alignmentDirectional: AlignmentDirectional.center,
                                    onPressed:callBack,
                                  ),
                                )),

                              ],))


                            )
                    ]
                        ),)
              ],
            )),


      );
    },
  );
}
