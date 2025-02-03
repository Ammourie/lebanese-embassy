import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/utils.dart';
import '../../../account/data/remote/models/params/update_info_field_params.dart';
import '../../../account/data/remote/models/responses/family_group_field.dart';
import '../../../account/presentation/screens/step_widget.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import 'book_appointment_widget.dart';
import 'waiting_for_review_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';

import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/dynamic_info_question_form.dart';
import '../../../../core/widget/dynamic_question_form.dart';
import '../../../../core/widget/error_widget.dart';
 import '../../../../core/widget/waiting_widget.dart';
import '../../../../l10n/locale_provider.dart';

import '../../../../service_locator.dart';
import '../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../order/data/remote/models/responses/get_order_model.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../../data/remote/models/responses/get_service_model.dart';
import '../blocs/service_bloc.dart';
import 'connected_price_card.dart';


class OrderPreveiwServiceRequestScreen extends StatefulWidget {
  OrderPreveiwServiceRequestScreen({
    required this.service_id,
    required  this.client_id,
    required this.id,
    required this.needDate,
    required this.date,required this.info,required this.file
  });
  int? service_id;
  int? client_id;
  int? id;
bool needDate;
  DateTime? date;
  List<InfoData>? info;
  FilesModelDataList file;
  @override
  State<StatefulWidget> createState() => _ContinuationServiceRequestState();
}

class _ContinuationServiceRequestState extends State<OrderPreveiwServiceRequestScreen> {

  ServiceBloc _serviceBloc = new ServiceBloc();

  Map<String,List<InfoData>>groupedMap={};
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Styles.colorBackground,
            body:
            WillPopScope(
            onWillPop: () async {
    // Prevent navigation by returning false
    return false;
    },child:

            SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(

                  ),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    color: Styles.colorUserInfoBackGround,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    // child: SingleChildScrollView(
                    child:   Container(
                            // child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  CommonSizes.vLargerSpace,
                                  Row(children: [
                                    InkWell(
                                      onTap: (){

                                          Navigator.of(context).pop();
                                                                     },
                                      child:
                                      SizedBox(width: 20.w,child:
                                      Icon(Icons.arrow_back_ios_new,)),),





                                    Expanded(child:   Container(
                                      child:

                                       CustomText(
                                          textAlign: TextAlign.center,
                                          alignmentGeometry:
                                          Alignment.center,
                                          text:
                                          'تأكيد الطلب'
                                          ,
                                          // 'استكمال البيانات'??'',
                                          style: Styles.w700TextStyle()
                                              .copyWith(
                                              fontSize: 20.sp,
                                              color: Styles
                                                  .colorText))
                                    ),),
                                    SizedBox(width: 20.w,)
                                  ],),
                                  CommonSizes.vSmallerSpace,
Expanded(child: SingleChildScrollView(child:  Column(children: [

                                 ... getSortInfo(),
                                   SizedBox(height: 20),

],))
),
                                  SizedBox(height: 20),

    BlocConsumer<ServiceBloc, ServiceState>(
    bloc: _serviceBloc,
    listener: (context, ServiceState state) async {
    if (state is CreateServicesRequestLoaded) {

    Utils.popNavigate(context,popsCount: 3);
    }



    },
    builder: (context, state) {
    if (state is ServiceLoading)
    return WaitingWidget();
    if (state is ServiceError)
    return ErrorWidgetScreen(
    callBack: () {
    _serviceBloc.add(CreateOrderServicesEvent(
    createOrderServiceParams:
    CreateOrderServiceParams(body:
    CreateOrderServiceParamsBody(
    info: widget.info,
    client_id: sl<AppStateModel>().user!.data!.id ?? 0,
    date:widget.date,
    file: widget.file,
    service_id: widget.service_id  ?? 0,

    // categoryId:
    ))
    ));

    },
    message: state.message ?? "",
    height: 250.h,
    width: 250.w,
    );
    return
    CustomButton(
                                    width: double.infinity,

                                    text: 'التالي',

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
                                    onPressed:  () {

                                      if( !widget.needDate)
                                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(name:
                                        RoutePaths.WaitingForReviewScreen
                                        ),
                                        screen:  WaitingForReviewScreen(
                                            createOrderServiceParamsBody:
                                            CreateOrderServiceParamsBody(
                                              info: widget.info,

                                              client_id: sl<AppStateModel>().user!.data!.id ?? 0,
                                              date:widget.date,
                                              file: widget.file,
                                              service_id: widget.service_id  ?? 0,
                                            )
                                        ),

                                        withNavBar: false,
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );
                                      else {

                                        _serviceBloc.add(
                                            CreateOrderServicesEvent(
                                                createOrderServiceParams:
                                                CreateOrderServiceParams(body:
                                                CreateOrderServiceParamsBody(
                                                  info: widget.info,
                                                  client_id: sl<AppStateModel>()
                                                      .user!.data!.id ?? 0,
                                                  date: widget.date,
                                                  file: widget.file,
                                                  service_id: widget
                                                      .service_id ?? 0,

                                                  // categoryId:
                                                ))
                                            ));
                                      }
                                    },

                                  );}),
                                  CommonSizes.vBigSpace ,
                                ],
                              )
                           ),
                  )),
            )))));
  }
  List<Widget> getSortInfo(){
  List<Widget> lstWidget=[];

  groupedMap={};
  try {

    List<InfoData> uniqueList = [];
    Set<int> seenIds = {};

    for (var info in widget.info??[]) {
      if (!seenIds.contains(info.field_id)) {
        seenIds.add(info.field_id);
        uniqueList.add(info);
      }
    }
    widget.info=uniqueList;
    for (var item in widget.info ?? []) {
      if (groupedMap.containsKey(item.group ?? '')) {
        groupedMap[item.group ?? '']!.add(item);
      } else {
        groupedMap[item.group ?? ''] = [item];
      }
    }
    List<String> keys = groupedMap.keys.toList();
     print('e');
    for(int i=0;i<keys.length;i++){
      List<InfoData> items=groupedMap[keys[i]??'']??[];

      lstWidget.add(
          CommonSizes.vBigSpace);

      lstWidget.add(CustomText(
        text: keys[i] ?? '',
        style: Styles.w600TextStyle()
            .copyWith(fontSize: 20.sp, color: Styles.colorPrimary),
        alignmentGeometry: Provider
            .of<LocaleProvider>(context)
            .isRTL
            ? Alignment.centerRight
            : Alignment.centerLeft,
        textAlign: Provider
            .of<LocaleProvider>(context)
            .isRTL
            ? TextAlign.right
            : TextAlign.left,
      ),);
      lstWidget.add(
          CommonSizes.vSmallSpace);
      lstWidget.add(
        // Expanded(child:

          buildGroup(items
          )
        // )
      );
    }
     return lstWidget;
  }catch(e){

    print(e);
  return [];
  }
}


  Widget buildGroup( List<InfoData> infoListTmp) {


    try{





      return      DynamicInfoQuestionFormPage(infoList: infoListTmp,
      ); // re;

    }
    on Exception catch(e){
      print(e);
      return Container();

    }

  }




  @override
  void initState() {

     super.initState();

  }



  @override
  void dispose() {
    _serviceBloc.close();
    super.dispose();
  }

  int activeStep = 0;
  int activeStepLast = 0;
  int fullStepNum = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};

  List<String> stepName = [];





 }

