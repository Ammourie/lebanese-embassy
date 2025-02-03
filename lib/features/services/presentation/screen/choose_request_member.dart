import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../account/data/remote/models/params/update_info_field_params.dart';
import '../../../account/data/remote/models/responses/family_group_field.dart';
import '../../../account/presentation/screens/step_widget.dart';
import 'continuation_service_request.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';

import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_text.dart';
 import '../../../../core/widget/error_widget.dart';
 import '../../../../l10n/locale_provider.dart';

import '../../../../service_locator.dart';
import '../../../order/data/remote/models/responses/get_order_model.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../../data/remote/models/responses/get_service_model.dart';
import '../blocs/service_bloc.dart';


class ChooseRequestMemberScreen extends StatefulWidget {
  ChooseRequestMemberScreen({
    required this.tittle,
    this.isEdite=false,
    this.orderModel ,
    this.selectedService ,
    required this.getServicesLoaded ,
    required this.categoryId});
String tittle;
  OrderModel? orderModel;
  ServiceModel? selectedService;
  GetServicesLoaded getServicesLoaded;
  int categoryId;
bool isEdite;
  @override
  State<StatefulWidget> createState() => _ChooseRequestMemberState();
}

class _ChooseRequestMemberState extends State<ChooseRequestMemberScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  bool enableSend = false;

  bool isRtl = false;
  // initParamters() {
  //   stepName = widget.selectedService!.groups ??
  //       [];
  //   fullStepNum=stepName.length;
  //   for(int i=0;i<widget.selectedService!.groups!.length;i++)
  //     if(widget.selectedService!.groups![i].contains('السؤال الرئيسي')){
  //       fullStepNum--;
  //     }
  //
  //   for (int i = 0; i < fullStepNum; i++) {
  //     _formKeyList.add(new GlobalKey<FormState>());
  //   }
  //   for(int i=0;i<widget.serviceModelList!.groups!.length;i++)
  //     listdataTmp.addAll(widget.serviceModelList!.groupedFields![widget.serviceModelList!.groups![i]??'']??[]);
  //
  //
  //
  // }

   @override
  Widget build(BuildContext context) {
    isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

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
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    // child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                        child:    Container(
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
                                      Utils.popNavigate(context,popsCount: 1);                                                },
                                    child:
                                    SizedBox(width: 20.w,child:
                                    Icon(Icons.arrow_back_ios_new,)),),
                                  Expanded(child:   Container(
                                    child: CustomText(
                                        textAlign: TextAlign.center,
                                        alignmentGeometry:
                                        Alignment.center,
                                        text:
                                        widget.isEdite?
                                            widget.orderModel!.service!.name??widget.tittle:

                                        widget.selectedService!.name??widget.tittle,
                                        style: Styles.w700TextStyle()
                                            .copyWith(
                                            fontSize: 24.sp,
                                            color: Styles
                                                .colorText)),
                                  ),),
                                  SizedBox(width: 20.w,)
                                ],),
                                CommonSizes.vBigSpace,


                                CommonSizes.vSmallerSpace,


                                Expanded(child:
                                SingleChildScrollView(child:
                                Column(children: [
                                  ... _buildPageContent(),],),),),
                                SizedBox(height: 20),
                                CustomButton(
                                  width: double.infinity,

                                  text: 'استكمال البيانات',

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
                                  onPressed:   (){
                                    if(selecteFamilyMember==-1){
                                      Utils.showToast('plaes choose type');
                                    }

                                    else{
                                      if(widget.isEdite){
                                        // PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                                        //   context,
                                        //   settings: RouteSettings(name:
                                        //   RoutePaths.CreateServiceRequestScreen
                                        //   ),
                                        //   screen:  ContinuationServiceRequestScreen(
                                        //     serviceModelList: getServicesLoaded!.getServiceEntity!
                                        //         .serviceModelList[selecteType],
                                        //     getServicesLoaded: getServicesLoaded!,
                                        //     isEdite: widget.isEdite,
                                        //     orderModel: widget.orderModel,
                                        //     selecteFamilyMember: selecteFamilyMember,
                                        //   ),
                                        //
                                        //   withNavBar: false,
                                        //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                        // );

                                      }else{
                                        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                                          context,
                                          settings: RouteSettings(name:
                                          RoutePaths.CreateServiceRequestScreen
                                          ),
                                          screen:  ContinuationServiceRequestScreen(
                                            serviceModelList: widget.selectedService,
                                            getServicesLoaded: widget.getServicesLoaded!,
                                            isEdite: widget.isEdite,
                                            selecteFamilyMember: selecteFamilyMember,
                                          ),

                                          withNavBar: false,
                                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                        );

                                      }

                                      // Utils.pushNewScreenWithRouteSettings(context, screen:
                                      //
                                      // ContinuationServiceRequestScreen(
                                      //
                                      //   serviceModelList: getServicesLoaded!.getServiceEntity!
                                      //       .serviceModelList[selecteType],
                                      // ),
                                      //     settings: RouteSettings(
                                      //         name: RoutePaths.CreateServiceRequestScreen
                                      //     )) ;
                                    }
                                  },

                                ),
                                CommonSizes.vBigSpace ,
                              ],
                            )
                        ),)
                      ],
                    ),
                  )),
            )))));
  }



  //activeStep 0 -> 3 info
  //activeStep 3  and showAddOr Fill to show User Family
  //activeStep >3  and !showAddOr Fill to fill User Family



_buildPageContent() {

  return [
    CustomText(
      text: 'يرجى ملء جميع الحقول المطلوبة بدقة وتأكد من صحة المعلومات قبل التقديم.' ?? '',
      style: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorText),
      alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
    ),
    CommonSizes.vSmallestSpace,
    CustomText(
      text:'اختر احد افراد العائلة:',
      style: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorText),
      alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
    ),
    CommonSizes.vSmallestSpace,

    Container(                height: 56.h,
        child:
        DropdownButtonFormField<String>(
          value:   selecteFamilyMember==-1? null:sl<AppStateModel>().user!.data!.family!.groups[selecteFamilyMember],
          decoration: InputDecoration(labelText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.w),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)), )),
          items: (sl<AppStateModel>().user!.data!.family!.groups  ?? [])
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {
             selecteFamilyMember=
                sl<AppStateModel>().user!.data!.family!.groups.indexWhere(
                      (element) =>
                          element.compareTo(value??'')==0);


            setState(() {

              // _formData[field.name ?? ''] = value;
            });
          },
          validator: (value) {


          },
        )),
    CommonSizes.vSmallerSpace,
    // ..._buildTypeRequest()
  ];
}
int selecteType=-1;
int selecteFamilyMember=-1;
  ServiceModel? selecteServiceModelType=null;
   @override
  void initState() {
    super.initState();

   }



  @override
  void dispose() {
     super.dispose();
  }

  int activeStep = 0;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};

  List<String> stepName = [];
  initParamters() {

  }




  List<GlobalKey<FormState>> _formKeyList = [];
}

