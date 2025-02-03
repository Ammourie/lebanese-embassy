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

class CompleteProfileScreen extends StatefulWidget {
  CompleteProfileScreen({this.isEditeProfile=false
  });
bool isEditeProfile;
  @override
  State<StatefulWidget> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int secondsRemaining = 60;
  bool enableResend = false;
  bool enableSend = false;
  late Timer timer;
  GetRegisterFieldLoaded? getRegisterFieldLoaded;
  FocusNode _FocusNode = FocusNode();
  AccountBloc _accountBloc = new AccountBloc();
  late TextEditingController textEditingController;
  bool isRtl = false;

  bool hasError = false;
  String currentText = "";
  bool shouldSaveOnline = false;
  @override
  Widget build(BuildContext context) {
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
                                    listener:
                                        (context, AccountState state) async {
                                      if (state is GetRegisterFieldLoaded) {
                                        getRegisterFieldLoaded = state;

                                        String userDatarrr = sl<AppStateModel>()
                                                .prefs
                                                .getString(SharedPreferencesKeys
                                                    .USER_Field_Data) ??
                                            '';

                                        RequestGroupField
                                            requestGroupFieldField =userDatarrr.compareTo('')==0?
                                        RequestGroupField(groups: [],
                                            groupedFields: {}, info: [])
                                            :
                                            RequestGroupField.fromJson(
                                                jsonDecode(userDatarrr));

                                        print(requestGroupFieldField);
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
                                                      .groupedFields![
                                                          getRegisterFieldLoaded!
                                                                  .getRegisterFieldEntity!
                                                                  .requestGroupField!
                                                                  .groups[i] ??
                                                              '']!
                                                      .length;
                                              j++) {

                                            if(requestGroupFieldField!
                                                .groupedFields
                                                .length==0){}
                                            else{
                                            getRegisterFieldLoaded!
                                                    .getRegisterFieldEntity!
                                                    .requestGroupField!
                                                    .groupedFields![
                                                        getRegisterFieldLoaded!
                                                                .getRegisterFieldEntity!
                                                                .requestGroupField!
                                                                .groups[i] ??
                                                            '']![j]
                                                    .values =

                                                requestGroupFieldField
                                                    .groupedFields![
                                                        getRegisterFieldLoaded!
                                                                .getRegisterFieldEntity!
                                                                .requestGroupField!
                                                                .groups[i] ??
                                                            '']![j]
                                                    .values;
                                          }
                                          }
                                        }

                                        initParamters();
                                      } else if (state
                                          is UpdateInfoFieldLoaded) {
                                        // sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Family_Data,
                                        //     jsonEncode(familyGroupField)
                                        // ) ;
                                        if (showAddMember) activeStep--;

                                        showAddOrFill = !showAddOrFill;
                                        if (showAddMember == true) {
                                          Utils.popNavigateToFirst(context);
                                          Utils.pushReplacementNavigateTo(
                                            context,
                                            RoutePaths.NavMainScreen,
                                          );
                                        }
                                        showAddMember = false;
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
                                      return getRegisterFieldLoaded == null
                                          ? Container()
                                          : Container(
                                              // child: SingleChildScrollView(
                                              child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CommonSizes.vLargerSpace,
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (activeStep == 0) {
                                                        } else if (activeStep <
                                                            3) {
                                                          activeStep--;
                                                        } else if (activeStep ==
                                                                3 &&
                                                            showAddMember) {
                                                        } else {
                                                          activeStep--;
                                                        }
                                                        setState(() {});
                                                      },
                                                      child: SizedBox(
                                                          width: 20.w,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_back_ios_new,
                                                          )),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: CustomText(
                                                            textAlign: TextAlign
                                                                .center,
                                                            alignmentGeometry:
                                                                Alignment
                                                                    .center,
                                                            text:
                                                                ' الملف الشخصي',
                                                            style: Styles
                                                                    .w700TextStyle()
                                                                .copyWith(
                                                                    fontSize:
                                                                        24.sp,
                                                                    color: Styles
                                                                        .colorText)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    )
                                                  ],
                                                ),
                                                CommonSizes.vBigSpace,
                                                StepWidget(
                                                  currentStep: activeStep,
                                                  steps: getRegisterFieldLoaded!
                                                      .getRegisterFieldEntity!
                                                      .requestGroupField!
                                                      .groups
                                                      .length,
                                                  // title: [],


                                                ),
                                                CommonSizes.vSmallSpace,

                                                CustomText(
                                                    textAlign: TextAlign.center,
                                                    alignmentGeometry: !Provider.of<LocaleProvider>(context, listen: false)
                                                            .isRTL
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                    text: getRegisterFieldLoaded!
                                                            .getRegisterFieldEntity!
                                                            .requestGroupField!
                                                            .groups[activeStep]
                                                            .contains('-')
                                                        ? getRegisterFieldLoaded!
                                                            .getRegisterFieldEntity!
                                                            .requestGroupField!
                                                            .groups[activeStep]
                                                            .split('-')
                                                            .first
                                                        : getRegisterFieldLoaded!
                                                                    .getRegisterFieldEntity!
                                                                    .requestGroupField!
                                                                    .groups[
                                                                activeStep] ??
                                                            '',
                                                    style: Styles.w700TextStyle()
                                                        .copyWith(
                                                            fontSize: 16.sp,
                                                            color: Styles.colorText)),

                                                CommonSizes.vSmallerSpace,

                                                Expanded(
                                                    child: Container(
                                                        child:
                                                            _buildPageContent())) // _buildBtnSubmit()
                                              ],
                                            ));
                                    }))
                          ],
                        ),
                      )),
                )))));
  }

  //activeStep 0 -> 3 info
  //activeStep 3  and showAddOr Fill to show User Family
  //activeStep >3  and !showAddOr Fill to fill User Family

  _buildPageContent() {
    return activeStep == 3 && showAddOrFill
        ? _buildAddFamily()
        : buildStepPage()[activeStep];
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

  bool showAddMember = false;
  bool showAddOrFill = false;
  bool isAddMember = false;
  initParamters() {
    stepName = getRegisterFieldLoaded!
        .getRegisterFieldEntity!.requestGroupField!.groups ??
        [];
    for (int i = 0; i < stepName.length; i++) {
      _formKeyList.add(new GlobalKey<FormState>());
    }

  }

  int selectFamilyIndex = -1;
  _buildAddFamily() {

    String family = sl<AppStateModel>()
            .prefs
            .getString(SharedPreferencesKeys.USER_Family_Data) ??
        '';
    FamilyGroupField? familyGroupField;

    if (family.isEmpty || family.compareTo('null') == 0) {
      // "name": "صلة القرابة",

      familyGroupField = null;
    } else {
      familyGroupField = FamilyGroupField.fromJson(jsonDecode(family));
    }

    return Container(
        child: !showAddOrFill
            ? buildStepPage()[activeStep]
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (familyGroupField != null)
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          List<GroupedField> tmpList = [];
                          GroupedField? tmp;
                          tmpList = familyGroupField!
                              .groupedFields[familyGroupField!.groups[index]]!;

                          int indexed = -1;
                          indexed = tmpList.indexWhere(
                              (e) => e.name!.compareTo('اللقب') == 0);
                          if (indexed != -1) tmp = tmpList[indexed];

                          return Container(
                            child: Container(
                              height: 53.h,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: CustomText(
                                    text: familyGroupField!.groups[index] +
                                        (tmp == null ? "" : (tmp!.name ?? '')),
                                    style: Styles.w600TextStyle().copyWith(
                                      fontSize: 16.sp,
                                      color: Styles.colorText,
                                    ),
                                    alignmentGeometry: Alignment.centerRight,
                                  )),
                                  InkWell(
                                    onTap: () {
                                      showCustomMessageDialog(
                                        isConfirmDelete: true,
                                        nameToDelete:
                                            familyGroupField!.groups[index],
                                        onButtonPressed:
                                            (BuildContext context) =>
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop(),
                                        onCancelPressed:
                                            (BuildContext context) {
                                          Utils.popNavigate(context);
                                        },
                                        context: context,
                                      ).then((value) => {
                                            setState(() {}),
                                          });
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
                                      selectFamilyIndex = index;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditeFamilyProfileScreen(
                                                    title: familyGroupField!
                                                        .groups[index],
                                                    data: familyGroupField!
                                                            .groupedFields[
                                                        familyGroupField!
                                                            .groups[index]],
                                                  )));
                                      // setState(() {
                                      //
                                      // });
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
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            CommonSizes.vSmallerSpace,
                        itemCount: familyGroupField!.groupedFields.length),
                  if (familyGroupField != null) CommonSizes.vBigSpace,
                  InkWell(
                    onTap: () {
                      showAddMember = !showAddMember;
                      showAddOrFill = false;
                      isAddMember = true;
                      activeStep++;
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Color(0xff095E32),
                        ),
                        CustomText(
                            text: 'إضافة فرد ',
                            style: Styles.w600TextStyle().copyWith(
                                fontSize: 16.sp,
                                color: Color(0xff095E32),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xff095E32)))
                      ],
                    ),
                  )
                ],
              ));
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




    if (isAddMember) {
      for (int i = 0; i < listdata.length; i++) {
        listdata[i].values = null;
      }
    }
    return DynamicFormPage(
        formKey: _formKeyList[activeStep],
        pickFile: () {
          // pickFileAndConvertToBase64();
          // pickImageFromCamera();
        },
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

              // RequestGroupField requestGroupFieldField =
              //     RequestGroupField.fromJson(jsonDecode(userDatarrr));
              // print(requestGroupFieldField);

              //
              if (activeStep <
                  getRegisterFieldLoaded!.getRegisterFieldEntity!
                          .requestGroupField!.groups.length -
                      2) {
                activeStep++;

                _formKey.currentState?.reset();
              } else {
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
                      getRegisterFieldLoaded!.getRegisterFieldEntity!
                          .requestGroupField!.groups[i]]!;
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
                            group: getRegisterFieldLoaded!
                                    .getRegisterFieldEntity!
                                    .requestGroupField!
                                    .groups[i] ??
                                ''));
                    if (lst[j].name!.contains('صلة قرابة')) {
                      keyDat = lst[j].name ?? '';
                    }
                  }
                }
              }
            });
            if (getRegisterFieldLoaded!
                .getRegisterFieldEntity!.requestGroupField!.groups[index1]
                .contains('بيانات العائلة')) {
              String family = sl<AppStateModel>()
                      .prefs
                      .getString(SharedPreferencesKeys.USER_Family_Data) ??
                  '';

              if (family.isEmpty || family.compareTo('null') == 0) {
                // "name": "صلة القرابة",

                //first famlly mmember
                familyGroupField = FamilyGroupField(
                    groupedFields: {keyDat + '1': listdata},
                    groups: [keyDat + '1'],
                    info: getRegisterFieldLoaded!
                        .getRegisterFieldEntity!.requestGroupField!.info
                        .where((e) => e.group == '1')
                        .toList());
              } else {
                familyGroupField =
                    FamilyGroupField.fromJson(jsonDecode(family));
                int memberIndex = 1;
                for (int i = 0; i < familyGroupField!.groups.length; i++) {
                  if (familyGroupField!.groups[i].contains(keyDat)) {
                    memberIndex++;
                  }
                }
                familyGroupField!.groupedFields
                    .addAll({keyDat + memberIndex.toString(): listdata});
                familyGroupField!.groups
                    .addAll([keyDat + memberIndex.toString()]);
                familyGroupField!.info.addAll(getRegisterFieldLoaded!
                    .getRegisterFieldEntity!.requestGroupField!.info
                    .where((e) => e.group == keyDat + memberIndex.toString())
                    .toList());
              }
            }

            if (getRegisterFieldLoaded!
                    .getRegisterFieldEntity!.requestGroupField!.groups[index1]
                    .contains('بيانات العائلة') ||
                getRegisterFieldLoaded!
                    .getRegisterFieldEntity!.requestGroupField!.groups[index1]
                    .contains('بيانات العمل')) {
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
                        e.group!
                            .compareTo(requestGroupField.groups.last ?? '') ==
                        0)
                    .toList();

                String family = sl<AppStateModel>()
                        .prefs
                        .getString(SharedPreferencesKeys.USER_Family_Data) ??
                    '';

                // if(family.isNotEmpty  ){
                //
                //
                //   familyGroupField=FamilyGroupField.fromJson(jsonDecode(family));
                //   requestGroupField.groups.addAll(familyGroupField!.groups??[]);
                //   requestGroupField.groupedFields.addAll(familyGroupField!.groupedFields);
                //   requestGroupField.info.addAll(familyGroupField!.info);
                //
                //
                // }

                // sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Family_Data,
                //     jsonEncode(familyGroupField)
                // ) ;
                // familyGroupField!.info=[];
                // familyGroupField!.groupedFields.clear();
                // familyGroupField!.groups=[];
                // requestGroupField.groupedFields.clear();
                // requestGroupField.groups=[];
                // requestGroupField.info=[];
              }

              _accountBloc.add(UpdateUpdateInfoFieldEvent(
                  updateInfoFieldParams: UpdateInfoFieldParams(
                      body: UpdateInfoFieldParamsBody(
                          familyGroupField: familyGroupField,
                          withFamily: activeStep == 4,
                          lst: requestGroupField!))));
            }
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

  List<GlobalKey<FormState>> _formKeyList = [];
}
