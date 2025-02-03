 
 
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../order/data/remote/models/params/get_order_params.dart';
import '../../../order/presentation/blocs/order_bloc.dart';
import '../../../order/presentation/screen/order_card.dart';

import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../service_locator.dart';
import '../../../category/presentation/blocs/category_bloc.dart';
import '../../data/remote/models/responses/family_group_field.dart';
import '../../data/remote/models/responses/get_field_model.dart';
import 'edit_family_profile_screen.dart';

class FamilyScreen  extends StatefulWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen>  {
  bool isRtl = false;


 
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    super.initState();
  }
 

 
   final GlobalKey<FormFieldState<String>> _searchKey =
  new GlobalKey<FormFieldState<String>>();




   List<Widget> widgetLsit=[];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
         body:SafeArea(

            bottom: true,
            top: false,
            maintainBottomViewPadding: true,
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
                                Navigator.pop(context);                                                },
                              child:
                              SizedBox(width: 20.w,
                                  child:
                              Icon(Icons.arrow_back_ios_new,color: Styles
                                  .colorTextWhite,)
                              // ),
                  ,),),
                            Expanded(child:   Container(
                              child: CustomText(
                                  textAlign: TextAlign.center,
                                  alignmentGeometry:
                                  Alignment.center,
                                  text: 'أفراد العائلة'??'',
                                  style: Styles.w400TextStyle()
                                      .copyWith(
                                      fontSize: 20.sp,
                                      color: Styles
                                          .colorTextWhite)),
                            ),),
                            SizedBox(width: 20.w,)
                          ],),
                        ),

                        Expanded(child:    Container(
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


child:_buildAddFamily() ,




                    )
    )
    ])
    )
    ))
    );
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
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (familyGroupField != null)
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    List<GroupedField> tmpList = [];
                    GroupedField? tmp;
                    GroupedField? tmpName;
                    tmpList = familyGroupField!
                        .groupedFields[familyGroupField!.groups[index]]!;

                    int indexed = -1;
                    indexed = tmpList.indexWhere(
                            (e) => e.name!.compareTo('صلة القرابة') == 0);
                    if (indexed != -1) tmp = tmpList[indexed];
if(tmp!=null)tmp.values=
    familyGroupField.info.where((e)=>e.field_id==tmp!.id).first.value??'';
                    int indexedName = -1;
                    indexedName = tmpList.indexWhere(
                            (e) => e.name!.compareTo('الاسم الشخصي') == 0);
                    if (indexedName != -1) tmpName = tmpList[indexedName];
                    if(tmpName!=null)tmpName.values=
                        familyGroupField.info.where((e)=>e.field_id==tmpName!.id).first.value??'';
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
                                      (tmp == null ? "" : (tmpName!.values??'')+' / '+(tmp!.values ?? '')),
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
                                List<GroupedField> tmpList = [];
                                GroupedField? tmp;
                                GroupedField? tmpName;
                                tmpList = familyGroupField!
                                    .groupedFields[familyGroupField!.groups[index]]!;

                                int indexed = -1;
                                indexed = tmpList.indexWhere(
                                        (e) => e.name!.compareTo('صلة القرابة') == 0);
                                if (indexed != -1) tmp = tmpList[indexed];
                                if(tmp!=null)tmp.values=
                                    familyGroupField.info.where((e)=>e.field_id==tmp!.id).first.value??'';
                                int indexedName = -1;
                                indexedName = tmpList.indexWhere(
                                        (e) => e.name!.compareTo('الاسم الشخصي') == 0);
                                if (indexedName != -1) tmpName = tmpList[indexedName];
                                if(tmpName!=null)tmpName.values=
                                    familyGroupField.info.where((e)=>e.field_id==tmpName!.id).first.value??'';

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditeFamilyProfileScreen(
                                              title:
                                              (tmpName!.values??'')+' / '+(tmp!.values ?? ''),
                                              // familyGroupField!
                                              //     .groups[index],
                                              titleToCompare:

                                              familyGroupField!
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

                setState(() {});
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditeFamilyProfileScreen(
                              title: 'اضافة فرد',
                              data: null,isAddMember: true,
                            ))).then((v)=>{
                setState(
                () {
                 }
                )
                });
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

}
