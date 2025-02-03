import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../data/remote/models/params/update_info_field_params.dart';
import '../../data/remote/models/responses/family_group_field.dart';
import 'step_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_check_box.dart';
import '../../../../core/widget/custom_radio_tile.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/dynamic_form.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../data/remote/models/params/get_register_field_params.dart';
import '../../data/remote/models/responses/get_field_model.dart';
import '../../data/remote/models/responses/request_group_field.dart';
import '../blocs/account_bloc.dart';

class EditeFamilyProfileScreen extends StatefulWidget {
  EditeFamilyProfileScreen({
    this.titleToCompare,
    this.title,
    this.isAddMember=false,
    this.data});
  List<GroupedField>? data;
  String? title;
  String? titleToCompare;
  bool isAddMember;
  @override
  State<StatefulWidget> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<EditeFamilyProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  bool enableSend = false;
  late Timer timer;
   FocusNode _FocusNode = FocusNode();
  AccountBloc _accountBloc = new AccountBloc();
  late TextEditingController textEditingController;
  bool isRtl = false;
  GetRegisterFieldLoaded? getRegisterFieldLoaded;
  bool hasError = false;
  String currentText = "";
bool shouldSaveOnline=false;
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
                  // horizontal: CommonSizes.BIGGEST_LAYOUT_W_GAP.w,
                  // vertical: CommonSizes.TINY_LAYOUT_W_GAP.h,
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
                            child: BlocConsumer<AccountBloc, AccountState>(
                                bloc: _accountBloc,
                                listener: (context, AccountState state) async {
                                  // GetRegisterFieldLoaded
if(state is GetRegisterFieldLoaded){
  getRegisterFieldLoaded=state;
}else
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
                                      callBack: () {
                                        getFields();
                                      },
                                      message: state.message ?? "",
                                      height: 250.h,
                                      width: 250.w,
                                    );
                                  return Container(
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
Navigator.pop(context);                                                },
                                                child:
                                              SizedBox(width: 20.w,child:
                                              Icon(Icons.arrow_back_ios_new,)),),
                                             Expanded(child:   Container(
                                                child: CustomText(
                                                    textAlign: TextAlign.center,
                                                    alignmentGeometry:
                                                    Alignment.center,
                                                    text: widget.title??'',
                                                    style: Styles.w700TextStyle()
                                                        .copyWith(
                                                        fontSize: 24.sp,
                                                        color: Styles
                                                            .colorText)),
                                              ),),
                                  SizedBox(width: 20.w,)
                                            ],),
                                            CommonSizes.vBigSpace,
                                            StepWidget(
                                              currentStep: activeStep,
                                              title: [''],
                                              steps:1,

                                            ),
                                            CommonSizes.vSmallSpace,

                                            CustomText(
                                                textAlign: TextAlign.center,
                                                alignmentGeometry:
                                                    !Provider.of<LocaleProvider>(
                                                                context,
                                                                listen: false)
                                                            .isRTL
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                text:widget.title??'',
                                                style: Styles.w700TextStyle().copyWith(fontSize: 16.sp, color: Styles.colorText)),

                                            CommonSizes.vSmallerSpace,

                                            Expanded(
                                              child: Container(
                                                  child:
                                                  _buildPageContent()
                                            )
                                            )         // _buildBtnSubmit()
                                          ],
                                        ));
                                }))
                      ],
                    ),
                  )),
            ))
            )));
  }



  //activeStep 0 -> 3 info
  //activeStep 3  and showAddOr Fill to show User Family
  //activeStep >3  and !showAddOr Fill to fill User Family



_buildPageContent(){
    return
    buildStepPage();
}
  @override
  void initState() {
    super.initState();

    getFields();
  }

  getFields() {
    _accountBloc.add(GetRegisterFieldEvent(
        getRegisterFieldParams:
            GetRegisterFieldParams(body: GetRegisterFieldParamsBody())));
  }

  @override
  void dispose() {
    _accountBloc.close();
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

       _formKeyList=new GlobalKey<FormState>();
   }

  bool showAddMember = false;
  bool showAddOrFill=false;
  int selectFamilyIndex=-1;
  _buildAddFamily() {
    String family=sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Family_Data)??'';
      FamilyGroupField? familyGroupField;

    if(family.isEmpty){
      // "name": "صلة القرابة",


      familyGroupField=null;
    }else{


      familyGroupField=FamilyGroupField.fromJson(jsonDecode(family));



  }




    return Container(
        child:  buildStepPage() );

  }

  Widget  buildStepPage() {
if(widget.data==null&&getRegisterFieldLoaded!=null){
  widget.data=getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groupedFields[
  getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groups.last
  ];
}
    return  Expanded(
              child: buildGroup(
                  widget.data ??
                      [])  )
           ;

   }
    FamilyGroupField? familyGroupField=null;

  Widget buildGroup(List<GroupedField> listdata) {
    //    List<Widget> re=[];
    //    for(int i=0; i<listdata.length;i++){
    //
    //      if(listdata[i].type.compareTo('text')==0)
    //        re.add(addcustomTextField());
    //      else if(listdata[i].type.compareTo('select')==0){
    //         re.add(addDropDownList(listdata[i].optionsList??[]));}
    //
    // else if(listdata[i].type.compareTo('checkbox')==0){
    //         re.add(addSelectedBox(listdata[i].group??''));
    //
    //      }
    //    }

    return DynamicFormPage(
        formKey: _formKeyList,
        pickFile: () {
          // pickFileAndConvertToBase64();
          // pickImageFromCamera();
        },
        listdata: listdata,
        callback: () {
try{
  //

  String family=sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Family_Data)??'';




    familyGroupField=FamilyGroupField.fromJson(jsonDecode(family));



if(widget.isAddMember){
  // for(int i=0;i<familyGroupField!.groups.length;i++){
    // if(familyGroupField!.groups[i].compareTo(widget.title??'')==0) {
      familyGroupField!.groups.add(familyGroupField!.groups.length.toString());
      listdata ?? [];
      familyGroupField!.groupedFields.addAll(
          { familyGroupField!.groups.last:listdata});

  // }


}else{
  for(int i=0;i<familyGroupField!.groups.length;i++){
    if(familyGroupField!.groups[i].compareTo(widget.titleToCompare??'')==0) {
      familyGroupField!.groupedFields[familyGroupField!.groups[i]]
      =listdata ?? [];
    }

  }
}
  _accountBloc.add(UpdateUpdateInfoFieldEvent(
      updateInfoFieldParams: UpdateInfoFieldParams(
          body: UpdateInfoFieldParamsBody(
              familyGroupField: familyGroupField,
              withFamily: true,
                ))));

        }
on Exception catch (e){

  print(e);
}

        }); // re;
  }
bool checkFamilyMember(){
    bool res=false;

    return res;
}
   Widget addSelectedBox(String text) {
    return Container(
        width: 200.w,
        child: CustomCheckBox(
          onChanged: (value) {},
          checkBoxValue: false,
          trailer: text,
        ));
  }

  Widget addDropDownList(List<String> options) {
    return Container(
        height: 56.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w), // Add some padding
        padding: EdgeInsets.symmetric(horizontal: 16.w), // Add some padding
        decoration: Styles.coloredRoundedDecoration(
            borderColor: Styles.colorBorderTextField,
            color: Styles.colorBackground,
            radius: 8.r),
        child: DropdownButton<String>(
          value: null,
          underline: Container(color: Colors.transparent),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 16.w,
            color: Styles.colorSecondry,
          ),
          onChanged: (newValue) {
            setState(() {
              // selectedValue = newValue!;
            });
          },
          items: options.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ));
  }

  // Widget addcustomTextField()
  // {conrllerList.add(TextEditingController());
  // keys.add(GlobalKey<FormFieldState<String>>());
  // return   CustomTextField(
  //   width: 250,
  //   height: 50,
  //   textKey: keys.last,
  //   textStyle: TextStyle(fontSize: 55),
  //   controller: conrllerList.last,
  //   textInputAction: TextInputAction.done,
  //   keyboardType:TextInputType.text ,
  //   onFieldSubmitted: (String value) {  },
  //   onChanged: (String value) {  }, hintText: '', minLines: 1, textAlign: TextAlign.start,);
  // }

  final dashImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }

   GlobalKey<FormState> _formKeyList = new GlobalKey<FormState>() ;
}

// class DynamicFormPage extends StatefulWidget {
//   final List<GroupedField> listdata;
//   final GlobalKey<FormState> formKey;
//
//   final VoidCallback callback;
//   final VoidCallback? pickFile;
//
//   DynamicFormPage(
//       {required this.listdata,
//       required this.formKey,
//       this.pickFile,
//       required this.callback});
//
//   @override
//   _DynamicFormPageState createState() => _DynamicFormPageState();
// }
//
// class _DynamicFormPageState extends State<DynamicFormPage> {
//   final Map<String, dynamic> _formData = {}; // Store form data here
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeFormFields();
//   } // Store form data for all steps
//
//   void _initializeFormFields() {
//     for (var field in widget.listdata) {
//       _formData[field.name ?? ''] = ''; // Initialize with empty values
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       // SingleChildScrollView(
//       // child:
//     Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: Form(
//           key: widget.formKey,
//           child: Column(
//             children: [
//            Expanded(child:     SingleChildScrollView(child: Column(children: [
//               ...getLsitWidgte(),],),),),
//               SizedBox(height: 20),
//                CustomButton(
//                 width: double.infinity,
//
//                 text: 'حفظ',
//
//                 style: Styles.w700TextStyle().copyWith(
//                   fontSize: 16.sp,
//                   height: 24/16,
//                   color: Styles.colorTextWhite,
//                 ),
//                 raduis: 8.r,
//                 textAlign: TextAlign.center,
//                 color: Styles.colorPrimary,
//                 fillColor: Styles.colorPrimary,
//                 // width: 350.w,
//                 height: 54.h,
//                 alignmentDirectional: AlignmentDirectional.center,
//                 onPressed:   _submitForm,
//
//               ),
//               CommonSizes.vBigSpace ,
//             ],
//           ),
//         ),
//       );
//   }
//
//   List<Widget> l = [];
//
//   getLsitWidgte() {
//     l = [];
//     int index = 0;
//     widget.listdata
//         .map((field) => {
//               index++,
//               l.addAll(_buildField(field, index)),
//             })
//         .toList();
//     return l;
//   }
//
//   List<Widget> _buildField(GroupedField field, int index) {
//     if (field.country!.compareTo('الكل') == 0 ||
//         field.country!
//                 .compareTo(Provider.of<LocaleProvider>(context).country) ==
//             0) {
//       switch (field.type) {
//         case 'text':
//         case 'email':
//           List<Widget> wdgetLst = [];
//           if (field.group!.contains('بيانات التواصل و السكن')) {
//             List<String> lst = field.group!.split('-');
//             if (lst.length == 1 && field.description != null) {
//               lst = field.description!.split('-');
//             }
//
//             if (field.field_sort!.compareTo('1') == 0)
//               wdgetLst.addAll([
//                 CustomText(
//                   text: lst.last ?? '',
//                   style: Styles.w400TextStyle()
//                       .copyWith(fontSize: 16.sp, color: Styles.colorText),
//                   alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   textAlign: Provider.of<LocaleProvider>(context).isRTL
//                       ? TextAlign.right
//                       : TextAlign.left,
//                 ),
//                 CommonSizes.vSmallestSpace,
//               ]);
//
//             wdgetLst.addAll([
//               CustomTextField(
//                 // height: 60.h,
//
//                 // width: 217.w,
//                 initialValue: field.values ?? "",
//
//                 isRtl: Provider.of<LocaleProvider>(context).isRTL,
//                 // textKey: _usernameKey,
//                 // controller: _usernameController,
//
//                 textInputAction: TextInputAction.next,
//
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
//
//                   widget.listdata[indexed].values = value;
//                   if ((value == null || value.isEmpty) && field.required == 1) {
//                     return '${field.name} is required';
//                   }
//                   return null;
//                 },
//
//                 // onSaved: (value) => _formData[field.name ?? ''] = value,
//                 // if (Validators.isValidEmail(value ?? '')) {
//                 //   return null;
//                 // }
//                 // return "${S.of(context).validationMessage} ${S.of(context).userName}";
//                 // },
//
//                 prefixIcon: Icon(
//                   Icons.person_2_outlined,
//                   color: Styles.colorPrimary,
//                 ),
//                 textStyle: Styles.w400TextStyle().copyWith(
//                     fontSize: 16.sp, color: Styles.colorTextTextField),
//                 textAlign: Provider.of<LocaleProvider>(context).isRTL
//                     ? TextAlign.right
//                     : TextAlign.left,
//                 // focusNode: _usernameFocusNode,
//                 hintText: field.name ?? '',
//                 minLines: 1,
//                 onChanged: (String value) {
//                   widget.formKey.currentState?.validate();
//                   int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
//
//                   field.values = value;
//                   widget.listdata[indexed].values = value;
//
//                   _formData[field.name ?? ''] = value;
//                   //   if (_usernameKey.currentState!.validate()) {}
//                   //   setState(() {});
//                 },
//                 maxLines: 1,
//                 onFieldSubmitted: (String value) {
//                   field.values = value;
//                   int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
//
//                   widget.listdata[indexed].values = value;
//
//                   _formData[field.name ?? ''] = value;
//                 },
//               ),
//               CommonSizes.vSmallerSpace,
//             ]);
//           } else {
//             wdgetLst.addAll([
//               CustomText(
//                 text: field.name ?? '',
//                 style: Styles.w400TextStyle()
//                     .copyWith(fontSize: 16.sp, color: Styles.colorText),
//                 alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                     ? Alignment.centerRight
//                     : Alignment.centerLeft,
//                 textAlign: Provider.of<LocaleProvider>(context).isRTL
//                     ? TextAlign.right
//                     : TextAlign.left,
//               ),
//               CommonSizes.vSmallestSpace,
//               CustomTextField(
//                 // height: 60.h,
//
//                 // width: 217.w,
//                 initialValue: field.values ?? "",
//
//                 isRtl: Provider.of<LocaleProvider>(context).isRTL,
//                 // textKey: _usernameKey,
//                 // controller: _usernameController,
//
//                 textInputAction: TextInputAction.next,
//
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                  // [index].values = ;
//                  int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
//                  widget.listdata[indexed].values=value;
//                   if ((value == null || value.isEmpty) && field.required == 1) {
//                     return '${field.name} is required';
//                   }
//                   return null;
//                 },
//
//                 // onSaved: (value) => _formData[field.name ?? ''] = value,
//                 // if (Validators.isValidEmail(value ?? '')) {
//                 //   return null;
//                 // }
//                 // return "${S.of(context).validationMessage} ${S.of(context).userName}";
//                 // },
//
//                 prefixIcon: Icon(
//                   Icons.person_2_outlined,
//                   color: Styles.colorPrimary,
//                 ),
//                 textStyle: Styles.w400TextStyle().copyWith(
//                     fontSize: 16.sp, color: Styles.colorTextTextField),
//                 textAlign: Provider.of<LocaleProvider>(context).isRTL
//                     ? TextAlign.right
//                     : TextAlign.left,
//                 // focusNode: _usernameFocusNode,
//                 hintText: field.name ?? '',
//                 minLines: 1,
//                 onChanged: (String value) {
//                   widget.formKey.currentState?.validate();
//                   int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
//                   widget.listdata[indexed].values=value;
//
//                   _formData[field.name ?? ''] = value;
//                   //   if (_usernameKey.currentState!.validate()) {}
//                   //   setState(() {});
//                 },
//                 maxLines: 1,
//                 onFieldSubmitted: (String value) {
//                   field.values = value;
//                   int indexed=widget.listdata.indexWhere((e)=>e.id==field.id);
//                   widget.listdata[indexed].values=value;
//                   _formData[field.name ?? ''] = value;
//                 },
//               ),
//               CommonSizes.vSmallerSpace,
//             ]);
//           }
//           return wdgetLst;
//
//
//         case 'number':
//
//           return [
//             CustomText(
//               text: field.name ?? '',
//               style: Styles.w400TextStyle()
//                   .copyWith(fontSize: 16.sp, color: Styles.colorText),
//               alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               textAlign: Provider.of<LocaleProvider>(context).isRTL
//                   ? TextAlign.right
//                   : TextAlign.left,
//             ),
//             CommonSizes.vSmallestSpace,
//             CustomTextField(
//               height: 56.h,
//               // width: 217.w,
//
//               isRtl: Provider.of<LocaleProvider>(context).isRTL,
//               // textKey: _usernameKey,
//               // controller: _usernameController,
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if ((value == null || value.isEmpty) && field.required == 1) {
//                   return '${field.name} is required';
//                 }
//                 return null;
//               },
//               // onSaved: (value) => _formData[field.name ?? ''] = value,
//               // if (Validators.isValidEmail(value ?? '')) {
//               //   return null;
//               // }
//               // return "${S.of(context).validationMessage} ${S.of(context).userName}";
//               // },
//
//               prefixIcon: Icon(
//                 Icons.person_2_outlined,
//                 color: Styles.colorPrimary,
//               ),
//               textStyle: Styles.w400TextStyle()
//                   .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
//               textAlign: Provider.of<LocaleProvider>(context).isRTL
//                   ? TextAlign.right
//                   : TextAlign.left,
//               // focusNode: _usernameFocusNode,
//               hintText: field.name ?? '',
//               minLines: 1,
//               onChanged: (String value) {
//                 widget.formKey.currentState?.validate();
//
//                 //   if (_usernameKey.currentState!.validate()) {}
//                 //   setState(() {});
//               },
//               maxLines: 1,
//               onFieldSubmitted: (String value) {},
//             ),
//             CommonSizes.vSmallerSpace,
//
//           ];
//         case 'select':
//          int selectedIndex=0;
//            return [
//             CustomText(
//               text: field.name ?? '',
//               style: Styles.w400TextStyle()
//                   .copyWith(fontSize: 16.sp, color: Styles.colorText),
//               alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               textAlign: Provider.of<LocaleProvider>(context).isRTL
//                   ? TextAlign.right
//                   : TextAlign.left,
//             ),
//             CommonSizes.vSmallestSpace,
//
//             // Container(
//             //     height: 56.h,
//             //     decoration: Styles.coloredRoundedDecoration(
//             //         radius: 8.r, borderColor: Styles.colorBorderTextField),
//             //     // width: 91.w,
//             //     // child: ,
//             //
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.start,
//             //       crossAxisAlignment: CrossAxisAlignment.center,
//             //       children: [
//             //         Expanded(
//             //           child: DropdownButton<String>(
//             //
//             //             value: selectedIndex == -1 ? null : genderString[selectedIndex],
//             //             hint: CustomText(
//             //               text: 'الجنسية',
//             //               paddingHorizantal: 20.w,
//             //               alignmentGeometry:Provider.of<LocaleProvider>(context).isRTL
//             //                   ? Alignment.centerRight
//             //                   : Alignment.centerLeft,
//             //               textAlign: Provider.of<LocaleProvider>(context).isRTL
//             //                   ? TextAlign.right
//             //                   : TextAlign.left,
//             //               style: Styles.w400TextStyle().copyWith(fontSize: 14.sp),
//             //             ),
//             //             style: Styles.w400TextStyle().copyWith(fontSize: 14.sp),
//             //             onChanged: genderString.length == 0
//             //                 ? null
//             //                 : (String? newValue) {
//             //               newValue != null
//             //                   ? selectedIndex = genderString
//             //                   .indexWhere((element) => element == newValue!)
//             //                   : selectedIndex = -1;
//             //               setState(() {});
//             //             },
//             //             underline: Container(),
//             //             isExpanded: true,
//             //             items:
//             //             genderString.map<DropdownMenuItem<String>>((String value) {
//             //               return DropdownMenuItem<String>(
//             //                 value: value,
//             //                 child: // Expanded( child:CustomSVGPicture(path: value.flagPath, height: 18.w, width: 18.w)),
//             //
//             //                 Row(children: [
//             //                   Expanded(
//             //                     child: Text(value,
//             //                         maxLines: 1,
//             //                         overflow: TextOverflow.clip,
//             //                         textAlign: TextAlign.center,
//             //                         style: Styles.w400TextStyle().copyWith(
//             //                             fontSize: 16.sp,
//             //                             color: Styles.colorTextTextField)),
//             //                   )
//             //                 ],),
//             //               );
//             //             }).toList(),
//             //           ),
//             //           // )
//             //         ),
//             //       ],
//             //     )),
//             Container(                height: 56.h,
//             child:
//             DropdownButtonFormField<String>(
//                           value:    field.optionsList![1],
//               decoration: InputDecoration(labelText: '',
// contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.w),
//                   border:OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8.r)), )),
//               items: (field.optionsList ?? [])
//                   .map((option) =>
//                       DropdownMenuItem(value: option, child: Text(option)))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _formData[field.name ?? ''] = value;
//                 });
//               },
//               validator: (value) {
//                 if ((value == null || value.isEmpty) && field.required == 1) {
//                   return 'Please select ${field.name}';
//                 }
//                 return null;
//               },
//             )),
//              CommonSizes.vSmallerSpace,
//           ];
//         case 'checkbox':
//           if( _formData[field.name ?? '']==null)
//             _formData[field.name ?? '']=false;
//           return [
//             // CustomText(
//             //   text: field.name ?? '',
//             //   style: Styles.w400TextStyle()
//             //       .copyWith(fontSize: 16.sp, color: Styles.colorText),
//             //   alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//             //       ? Alignment.centerRight
//             //       : Alignment.centerLeft,
//             //   textAlign: Provider.of<LocaleProvider>(context).isRTL
//             //       ? TextAlign.right
//             //       : TextAlign.left,
//             // ),
//             CommonSizes.vSmallestSpace,
//             CheckboxListTile(
//               contentPadding: EdgeInsets.zero,
//               controlAffinity: ListTileControlAffinity.leading, // Checkbox on the right
// activeColor: Styles.colorPrimary,
//               title:
//
//               CustomText(
//                 text: field.name ?? '',
//                 style: Styles.w400TextStyle()
//                     .copyWith(fontSize: 16.sp, color: Styles.colorText),
//                 alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                     ? Alignment.centerRight
//                     : Alignment.centerLeft,
//                 textAlign: Provider.of<LocaleProvider>(context).isRTL
//                     ? TextAlign.right
//                     : TextAlign.left,
//               ),
//                value:  _formData[field.name ?? ''].toString().compareTo('1')==1,
//               onChanged: (value) {
//                 setState(() {
//                   _formData[field.name ?? ''] = value;
//                 });
//               },
//             ),
//              CommonSizes.vSmallerSpace,
//           ];
//         case 'radio':
//           if(_formData[field.name ?? ''] ==null)
//           _formData[field.name ?? ''] = field.optionsList![0];
//           List<Widget> lst = [];
//
//           for (int i = 0; i < field.optionsList!.length!; i++) {
//             lst.add(
//               CustomRadioTile(
//                 groupVal: i,
//                 val: field.optionsList!.indexWhere((e)=>e.compareTo(_formData[field.name ?? '']??'') ==0 ),
//                 onChange: (int) {
//                   _formData[field.name ?? ''] =field.optionsList![i]??''  ;
// setState(() {
//
// });
//                 },
//                 top: 0,
//                 bottom: 0,
//
//                 child:
//
//                 CustomText(
//                   paddingHorizantal: 10.w,
//                   text: field.optionsList![i] ?? '' ,
//                   style: Styles.w400TextStyle()
//                       .copyWith(fontSize: 16.sp, color: Styles.colorText),
//                   alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   textAlign: Provider.of<LocaleProvider>(context).isRTL
//                       ? TextAlign.right
//                       : TextAlign.left,
//                 ),
//                ),
//             );lst.add(
// CommonSizes.hSmallerSpace,            );
//           }
//           return [
//             CustomText(
//               text: field.name ?? '',
//               style: Styles.w400TextStyle()
//                   .copyWith(fontSize: 16.sp, color: Styles.colorText),
//               alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               textAlign: Provider.of<LocaleProvider>(context).isRTL
//                   ? TextAlign.right
//                   : TextAlign.left,
//             ),
//             CommonSizes.vSmallestSpace,
//             Row(
//               children: lst,
//             ),
//              CommonSizes.vSmallerSpace,
//           ];
//
//         // CheckboxListTile(
//         // title: Text(field.name ?? ''),
//         // value:   false,
//         //
//         // onChanged: (value) {
//         //   setState(() {
//         //     _formData[field.name ?? ''] = value;
//         //   });
//         // },
//         // );
//         case 'file':
//           return [
//             CustomText(
//               text: field.name ?? '',
//               style: Styles.w400TextStyle()
//                   .copyWith(fontSize: 16.sp, color: Styles.colorText),
//               alignmentGeometry: Provider.of<LocaleProvider>(context).isRTL
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               textAlign: Provider.of<LocaleProvider>(context).isRTL
//                   ? TextAlign.right
//                   : TextAlign.left,
//             ),
//             CommonSizes.vSmallestSpace,
//             ElevatedButton(
//               onPressed: () async {
//                 widget.pickFile!(); // Notify parent widget
//               },
//               child: Text('Upload ${field.name}'),
//             ),
//              CommonSizes.vSmallerSpace,
//           ];
//         default:
//           return [SizedBox.shrink()];
//       }
//     } else {
//       return [SizedBox.shrink()];
//     }
//   }
//
//   void _submitForm() {
//     if (widget.formKey.currentState?.validate() ?? false) {
//       // _formKey.currentState?.save();
//       widget.callback(); // Notify parent widget
//       //   showDialog(
//       //     context: context,
//       //     builder: (context) => AlertDialog(
//       //       title: Text('Form Data'),
//       //       content: Text(_formData.toString()),
//       //       actions: [
//       //         TextButton(
//       //           onPressed: () => Navigator.pop(context),
//       //           child: Text('OK'),
//       //         ),
//       //       ],
//       //     ),
//       //   );
//     }
//   }
// }
