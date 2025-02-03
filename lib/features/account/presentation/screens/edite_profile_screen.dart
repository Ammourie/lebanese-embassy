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
import '../../../../core/widget/custom_success_dialog.dart';
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
import 'edit_family_profile_screen.dart';

class EditeProfileScreen extends StatefulWidget {
  EditeProfileScreen({this.isEditeProfile = false});
  bool isEditeProfile;
  @override
  State<StatefulWidget> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<EditeProfileScreen> {
  bool isRtl = false;
  final _formKey = GlobalKey<FormBuilderState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  bool enableSend = false;
  List<GlobalKey<FormState>> _formKeyList = [];

  GetRegisterFieldLoaded? getRegisterFieldLoaded;
  FocusNode _FocusNode = FocusNode();
  AccountBloc _accountBloc = new AccountBloc();
  late TextEditingController textEditingController;
  bool hasError = false;
  String currentText = "";
  bool shouldSaveOnline = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Styles.colorBackground,
            body: WillPopScope(
                onWillPop: () async {
                  // Prevent navigation by returning false
                  return false;
                },
                child: SafeArea(
                    bottom: true,
                    top: false,
                    maintainBottomViewPadding: true,
                    child: Container(
                        color: Styles.colorAppBarBackground,
                        width: screenSize.width,
                        height: screenSize.height,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: Stack(
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 150.h,
                                      decoration:
                                          Styles.coloredRoundedDecoration(
                                        color: Styles.colorAppBarBackground,
                                        radius: 0,
                                        borderColor:
                                            Styles.colorAppBarBackground,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.w),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: SizedBox(
                                                width: 20.w,
                                                child: Icon(
                                                  Icons.arrow_back_ios_new,
                                                  color: Styles.colorTextWhite,
                                                )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: CustomText(
                                                  textAlign: TextAlign.center,
                                                  alignmentGeometry:
                                                      Alignment.center,
                                                  text:
                                                      'المعلومات الشخصية' ?? '',
                                                  style: Styles.w400TextStyle()
                                                      .copyWith(
                                                          fontSize: 20.sp,
                                                          color: Styles
                                                              .colorTextWhite)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.w),
                                        decoration: BoxDecoration(
                                            color:
                                                Styles.colorUserInfoBackGround,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50.r),
                                                topRight:
                                                    Radius.circular(50.r)),
                                            border: Border(
                                              left: BorderSide(
                                                //                   <--- left side
                                                color: Styles
                                                    .colorUserInfoBackGround,
                                                width: 1.0,
                                              ),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CommonSizes.vBiggestSpace,
                                            Container(
                                              height: 37.h,
                                              child: CustomText(
                                                text: (sl<AppStateModel>()
                                                            .user!
                                                            .data!
                                                            .firstName ??
                                                        '') +
                                                    '  ' +
                                                    (sl<AppStateModel>()
                                                            .user!
                                                            .data!
                                                            .lastName ??
                                                        ''),
                                                style: Styles.w700TextStyle()
                                                    .copyWith(
                                                        fontSize: 20.sp,
                                                        color: Styles
                                                            .colorTextAccountColor),
                                                alignmentGeometry:
                                                    Alignment.center,
                                              ),
                                            ),
                                            CommonSizes.vSmallestSpace,
                                            Container(
                                              height: 37.h,
                                              child: CustomText(
                                                text: (sl<AppStateModel>()
                                                        .user!
                                                        .data!
                                                        .phone ??
                                                    ''),
                                                style: Styles.w400TextStyle()
                                                    .copyWith(
                                                        fontSize: 20.sp,
                                                        color: Styles
                                                            .colorTextAccountColor),
                                                alignmentGeometry:
                                                    Alignment.center,
                                                paddingHorizantal: 20.w,
                                              ),
                                            ),
                                            // Expanded(child:

                                            Expanded(
                                                child: Container(

                                                    // padding: EdgeInsets.symmetric(horizontal: 32.w),
                                                    // child: SingleChildScrollView(
                                                    child: BlocConsumer<
                                                            AccountBloc,
                                                            AccountState>(
                                                        bloc: _accountBloc,
                                                        listener: (context,
                                                            AccountState
                                                                state) async {
                                                          if (state
                                                              is GetRegisterFieldLoaded) {
                                                            getRegisterFieldLoaded =
                                                                state;

                                                            String userDatarrr = sl<
                                                                        AppStateModel>()
                                                                    .prefs
                                                                    .getString(
                                                                        SharedPreferencesKeys
                                                                            .USER_Field_Data) ??
                                                                '';

                                                            RequestGroupField
                                                                requestGroupFieldField =
                                                                RequestGroupField
                                                                    .fromJson(
                                                                        jsonDecode(
                                                                            userDatarrr));
                                                            print(
                                                                requestGroupFieldField);
                                                            int field_id=0;
                                                            for (int i = 0;
                                                                i <
                                                                    getRegisterFieldLoaded!
                                                                        .getRegisterFieldEntity!
                                                                        .requestGroupField!
                                                                        .groups!
                                                                        .length;
                                                                i++) {
                                                              for (int j = 0;
                                                                  j <
                                                                      getRegisterFieldLoaded!
                                                                          .getRegisterFieldEntity!
                                                                          .requestGroupField!
                                                                          .groupedFields![getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groups[i] ??
                                                                              '']!
                                                                          .length;
                                                                  j++) {
                                                                field_id= getRegisterFieldLoaded!
                                                                    .getRegisterFieldEntity!
                                                                    .requestGroupField!
                                                                    .groupedFields![
                                                                getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groups[i] ??
                                                                    '']![
                                                                j].id;
                                                                getRegisterFieldLoaded!
                                                                    .getRegisterFieldEntity!
                                                                    .requestGroupField!
                                                                    .groupedFields![
                                                                getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groups[i] ??
                                                                    '']![
                                                                j]

                                                                        .values =requestGroupFieldField.info.where((e)=>e.field_id==field_id).first.value??'';
                                                                    // requestGroupFieldField
                                                                    //     .groupedFields![
                                                                    //         getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groups[i] ??
                                                                    //             '']![
                                                                    //         j]
                                                                    //     .values;
                                                              }
                                                            }

                                                            initParamters();
                                                          } else if (state
                                                              is UpdateInfoFieldLoaded) {
                                                            Utils.showToast(
                                                                'data save');
                                                          }
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is AccountLoading)
                                                            return WaitingWidget();
                                                          if (state
                                                              is AccountError)
                                                            return ErrorWidgetScreen(
                                                              callBack: () {
                                                                getFields();
                                                              },
                                                              message: state
                                                                      .message ??
                                                                  "",
                                                              height: 250.h,
                                                              width: 250.w,
                                                            );
                                                          return getRegisterFieldLoaded ==
                                                                  null
                                                              ? Container(
                                                                  child: CustomText(
                                                                      text:
                                                                          'sss',
                                                                      style: Styles
                                                                          .w600TextStyle()),
                                                                )
                                                              : Container(
                                                                  // child: SingleChildScrollView(
                                                                  child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CommonSizes
                                                                        .vSmallSpace,

                                                                    StepWidget(
                                                                      title:
                                                                          stepName,
                                                                      opnpressed:
                                                                          (value) {
                                                                        activeStep =
                                                                            value;
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      currentStep:
                                                                          activeStep,
                                                                      steps: getRegisterFieldLoaded!
                                                                              .getRegisterFieldEntity!
                                                                              .requestGroupField!
                                                                              .groups
                                                                              .length -
                                                                          2,
                                                                    ),
                                                                    CommonSizes
                                                                        .vSmallerSpace,

                                                                    Expanded(
                                                                        child: Container(
                                                                            child:
                                                                                _buildPageContent())) // _buildBtnSubmit()
                                                                  ],
                                                                ));
                                                        })))
                                            // ,)
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 110.h,
                                  child: CustomPicture(
                                    height: 80.w,
                                    path: AssetsPath.SVG_Logo,
                                    isLocal: true,
                                    isSVG: true,
                                    isCircleShape: true,
                                  )),
                            ],
                          ),
                        ))))));
  }

  //activeStep 0 -> 3 info
  //activeStep 3  and showAddOr Fill to show User Family
  //activeStep >3  and !showAddOr Fill to fill User Family
  _buildTab() {
    List<Widget> widgtLst = [];
    for (int i = 0;
        i <
            getRegisterFieldLoaded!
                    .getRegisterFieldEntity!.requestGroupField!.groups.length -
                1;
        i++) {
      widgtLst.add(Expanded(
          child: Container(
        child: CustomText(
            textAlign: TextAlign.center,
            alignmentGeometry:
                !Provider.of<LocaleProvider>(context, listen: false).isRTL
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
            text: getRegisterFieldLoaded!.getRegisterFieldEntity!
                    .requestGroupField!.groups[activeStep]
                    .contains('-')
                ? getRegisterFieldLoaded!.getRegisterFieldEntity!
                    .requestGroupField!.groups[activeStep]
                    .split('-')
                    .first
                : getRegisterFieldLoaded!.getRegisterFieldEntity!
                        .requestGroupField!.groups[activeStep] ??
                    '',
            numOfLine: 1,
            style: Styles.w700TextStyle()
                .copyWith(fontSize: 16.sp, color: Styles.colorText)),
      )));
    }
    return widgtLst;
  }

  _buildPageContent() {
    return buildStepPage()[activeStep];
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

  List<String> stepName = ['المعلومات الشخصية', 'التواصل و السكن', 'العمل'];
  initParamters() {
    // stepName = getRegisterFieldLoaded!
    //     .getRegisterFieldEntity!.requestGroupField!.groups ??
    //     [];
    // stepName.removeLast();

    for (int i = 0; i < stepName.length; i++) {
      _formKeyList.add(new GlobalKey<FormState>());
    }
  }

  List<Widget> buildStepPage() {
    List<Widget> widgetFull = [];

    for (int i = 0;
        i <
            getRegisterFieldLoaded!
                .getRegisterFieldEntity!.requestGroupField!.groups!.length;
        i++) {
      widgetFull.add(
          // Column(children: [  Text("step Title"+getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField!.groups[i]),
          //   Container(height: 20,),
          Expanded(
              child: buildGroup(
                  getRegisterFieldLoaded!.getRegisterFieldEntity!
                              .requestGroupField!.groupedFields[
                          getRegisterFieldLoaded!.getRegisterFieldEntity!
                              .requestGroupField!.groups[i]] ??
                      [],
                  i))
          // ]
          // )
          );
    }
    return widgetFull;
  }

  FamilyGroupField? familyGroupField = null;

  Widget buildGroup(List<GroupedField> listdata, int index1) {
    return DynamicFormPage(
        formKey: _formKeyList[activeStep],
        pickFile: () {
          // pickFileAndConvertToBase64();
          // pickImageFromCamera();
        },
        isEditeStyle: true,
        listdata: listdata,
        callback: () {
          try {
            // widget.listdata[index].values=value;
            getRegisterFieldLoaded!
                    .getRegisterFieldEntity!.requestGroupField!.groupedFields[
                getRegisterFieldLoaded!.getRegisterFieldEntity!
                    .requestGroupField!.groups[index1]] = listdata;
            String keyDat = '';

            setState(() {
              // getRegisterFieldLoaded!.getRegisterFieldEntity!.requestGroupField.groupedFields[]=requestGroupField;

              //save_field
              String savedData = jsonEncode(getRegisterFieldLoaded!
                  .getRegisterFieldEntity!.requestGroupField!);
              sl<AppStateModel>()
                  .prefs
                  .setString(SharedPreferencesKeys.USER_Field_Data, savedData);

              String userDatarrr = sl<AppStateModel>()
                      .prefs
                      .getString(SharedPreferencesKeys.USER_Field_Data) ??
                  '';

              userDatarrr = sl<AppStateModel>()
                      .prefs
                      .getString(SharedPreferencesKeys.USER_Field_Data) ??
                  '';

              RequestGroupField requestGroupFieldField =
                  RequestGroupField.fromJson(jsonDecode(userDatarrr));
              print(requestGroupFieldField);

              //

              List<GroupedField> lst = [];
              getRegisterFieldLoaded!
                  .getRegisterFieldEntity!.requestGroupField!.info = [];
              for (int i = 0;
                  i <
                      getRegisterFieldLoaded!.getRegisterFieldEntity!
                          .requestGroupField!.groups.length;
                  i++) {
                lst = getRegisterFieldLoaded!.getRegisterFieldEntity!
                        .requestGroupField!.groupedFields[
                    getRegisterFieldLoaded!
                        .getRegisterFieldEntity!.requestGroupField!.groups[i]]!;
                for (int j = 0; j < lst.length; j++) {
                  String val;

                  if (lst[j].type!.compareTo('select') == 0) {
                    List<String> op =
                        lst[j].options!.toString().split('،') ?? [];
                    print('sss');
                    val = op[int.tryParse(lst[j].values ?? '') ?? 0];
                  } else {
                    val = lst[j].values ?? '';
                  }

                  getRegisterFieldLoaded!
                      .getRegisterFieldEntity!.requestGroupField!.info
                      .add(InfoData(
                          field_id: lst[j].id,
                          name: lst[j].name,
                          value: val,
                          group: getRegisterFieldLoaded!.getRegisterFieldEntity!
                                  .requestGroupField!.groups[i] ??
                              ''));
                  if (lst[j].name!.contains('صلة قرابة')) {
                    keyDat = lst[j].name ?? '';
                  }
                }
              }
            });

            RequestGroupField requestGroupField = getRegisterFieldLoaded!
                .getRegisterFieldEntity!.requestGroupField!;
            if (activeStep == 4) {
              requestGroupField.groupedFields = {
                requestGroupField.groups.last: requestGroupField
                        .groupedFields[requestGroupField.groups.last] ??
                    []
              };
              requestGroupField.groups = [requestGroupField.groups.first];
              requestGroupField.info = requestGroupField!.info!
                  .where((e) =>
                      e.group!.compareTo(requestGroupField.groups.last ?? '') ==
                      0)
                  .toList();
            }

            _accountBloc.add(UpdateUpdateInfoFieldEvent(
                updateInfoFieldParams: UpdateInfoFieldParams(
                    body: UpdateInfoFieldParamsBody(
                        familyGroupField: familyGroupField,
                        withFamily: false,
                        lst: requestGroupField!))));
            // post(widget.data);
            // login();
          } on Exception catch (e) {
            print(e);
          }
        }); // re;
  }

  // Widget  buildGroup(List<GroupedField> listdata){
  //
  //   //    List<Widget> re=[];
  //   //    for(int i=0; i<listdata.length;i++){
  //   //
  //   //      if(listdata[i].type.compareTo('text')==0)
  //   //        re.add(addcustomTextField());
  //   //      else if(listdata[i].type.compareTo('select')==0){
  //   //         re.add(addDropDownList(listdata[i].optionsList??[]));}
  //   //
  //   // else if(listdata[i].type.compareTo('checkbox')==0){
  //   //         re.add(addSelectedBox(listdata[i].group??''));
  //   //
  //   //      }
  //   //    }
  //   return DynamicFormPage(
  //       pickFile: (){
  //
  //         pickFileAndConvertToBase64();
  //         // pickImageFromCamera();
  //       },
  //
  //       listdata: listdata,callback: (){
  //     // setState(() {
  //     //   if(activeStep<widget.data.data.groups.length-1)
  //     //   activeStep++;
  //     // });
  //
  //
  //     post(widget.data);
  //     // login();
  //   } );
  //
  //   // re;
  // }
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
}
