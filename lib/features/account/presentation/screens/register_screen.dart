import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/widget/custom_text.dart';
import '../../data/remote/models/params/register_params.dart';
import 'verification_code_screen.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_check_box.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../data/remote/models/responses/request_group_field.dart';
import '../blocs/account_bloc.dart';
import 'complete_profile_screen.dart';
import 'package:country_flags/country_flags.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final bloc = AccountBloc();
  int index = 0;

   final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _confirmPasswodFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _passwordKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _firtsNameKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _lastsNameKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _phoneNumberKey =
      new GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _usernameKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _confirmPasswordKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _phoneKey =
      new GlobalKey<FormFieldState<String>>();

  @override
  void dispose() {
     _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Styles.colorPrimary,
        //   title: CustomText(
        //     text: S.of(context).login,
        //     style: Styles.w700TextStyle()
        //         .copyWith(fontSize: 20.sp, color: Styles.colorTextTitle),
        //   ),
        // ),
        body: SafeArea(
            child: FormBuilder(
          key: _formKey,
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: Styles.colorBackground,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 66.h,
                    ),


                    CustomText(
                      text: 'تسجيل مستخدم جديد',
                      style: Styles.w700TextStyle().copyWith(
                          fontSize: 24.sp, color: Styles.colorText),
                      alignmentGeometry:
                        Alignment.center,
                      textAlign: Provider.of<LocaleProvider>(context).isRTL
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                    CommonSizes.vBiggestSpace,

                    ..._buildfirstName(),
                    CommonSizes.vSmallSpace,
                   ... _buildPhoneNumber(),
                    CommonSizes.vSmallSpace,

                    ..._buildEmail(),
                    CommonSizes.vSmallSpace,
                    ..._buildPassword(),
                    CommonSizes.vSmallSpace,
                   ... _buildConfirmPassword(),
                    CommonSizes.vSmallSpace,

                    ..._buildCountry(context),
                    CommonSizes.vSmallSpace,

                    _buildBtnRegister(context),
                    CommonSizes.vBigSpace,
                  ],
                ),
              )),
        )),
      ),
    );
  }


  @override
  void initState() {
    _phoneNumberController.text = "1111111";
    super.initState();
  }

  List<Widget> _buildfirstName() {
    return
      [
        Container( alignment: Provider.of<LocaleProvider>(context).isRTL
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child:
        RichText(

          textAlign: Provider.of<LocaleProvider>(context).isRTL
              ? TextAlign.right
              : TextAlign.left,
       softWrap: true,
       textDirection:
      !Provider.of<LocaleProvider>(context, listen: false)
          .isRTL
          ? TextDirection.ltr
          : TextDirection.rtl,
      text: new TextSpan(

        style: Styles.w300TextStyle().copyWith(
            fontSize: 14.sp, color: Styles.colorTextTitle),
        children: <TextSpan>[
          new TextSpan(
              text: 'الاسم الشخصي',style:  Styles.w400TextStyle()
              .copyWith(fontSize: 16.sp, color: Styles.colorText)),
          new TextSpan(
              text: " * ",
              style:  Styles.w400TextStyle()
                  .copyWith(fontSize: 16.sp, color: Styles.colorPrimary)),
        ],
      ),
    )
        ),
        CommonSizes.vSmallestSpace,
      CustomTextField(
      height: 56.h,
      // width: 217.w,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      textKey: _firtsNameKey,
      controller: _firstNameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${S.of(context).validationMessage} ${S.of(context).userName}";
      },
      prefixIcon: Icon(
        Icons.person_2_outlined,
        color: Styles.colorPrimary,
      ),
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorText),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
      focusNode: _firstNameFocusNode,
      labelText: '',
      hintText: 'اسم المستخدم ',

      minLines: 1,
      onChanged: (String value) {
        if (_firtsNameKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    )];
  }
  _buildPhoneNumber() {
    return
    [
      Container( alignment: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
          child:
          RichText(

            textAlign: Provider.of<LocaleProvider>(context).isRTL
                ? TextAlign.right
                : TextAlign.left,
            softWrap: true,
            textDirection:
            !Provider.of<LocaleProvider>(context, listen: false)
                .isRTL
                ? TextDirection.ltr
                : TextDirection.rtl,
            text: new TextSpan(

              style: Styles.w300TextStyle().copyWith(
                  fontSize: 14.sp, color: Styles.colorTextTitle),
              children: <TextSpan>[
                new TextSpan(
                    text: 'رقم الجوال: ',style:  Styles.w400TextStyle()
                    .copyWith(fontSize: 16.sp, color: Styles.colorText)),
                new TextSpan(
                    text: " * ",
                    style:  Styles.w400TextStyle()
                        .copyWith(fontSize: 16.sp, color: Styles.colorPrimary)),
              ],
            ),
          )
      ),
      CommonSizes.vSmallestSpace,
       CustomTextField(
        // height: 48.h,
        textKey: _phoneNumberKey,
        isRtl: !Provider.of<LocaleProvider>(context).isRTL,

        textStyle: Styles.w400TextStyle()
            .copyWith(fontSize: 16.sp, color: Styles.colorText),
        textAlign: Provider.of<LocaleProvider>(context).isRTL
            ? TextAlign.right
            : TextAlign.left,
        controller: _phoneNumberController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,


        focusNode: _phoneNumberFocusNode,
        hintText: S.of(context).enterHere(S.of(context).phoneNumber),

        onFieldSubmitted: (String value) {},
        minLines: 1,
        prefixIcon:

        InkWell(
    onTap: (){
      _showCountryPiker();
    },
    child:  Container(
      decoration:   BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(0.r)),
            border: Border(
              left: BorderSide( //                   <--- left side
                color: Styles.colorBorderTextField,
                width: 1.0,
              ),

            )),
        padding: EdgeInsets.symmetric(vertical: 8.w,horizontal: 8.w),
            width: 63.w,
            height: 20.w,
            child:  Container( width: 20.w,
              height: 20.w,child: FittedBox(
              fit: BoxFit.contain,
                // width: 20.w,
                // height: 20.w,
                child: CountryFlag.fromCountryCode(
              // shape: RoundedRectangle(8.r) ,
              _country.countryCode,              width: 20.w,
              height: 20.w,
            )),))),
        onChanged: (String value) {
          if (_phoneNumberKey.currentState!.validate()) {}
          setState(() {});
        },

        height: 56.h,
      )
    ];
  }

  _buildEmail() {
    return
   [
     Container( alignment: Provider.of<LocaleProvider>(context).isRTL
         ? Alignment.centerRight
         : Alignment.centerLeft,
         child:
         RichText(

           textAlign: Provider.of<LocaleProvider>(context).isRTL
               ? TextAlign.right
               : TextAlign.left,
           softWrap: true,
           textDirection:
           !Provider.of<LocaleProvider>(context, listen: false)
               .isRTL
               ? TextDirection.ltr
               : TextDirection.rtl,
           text: new TextSpan(

             style: Styles.w300TextStyle().copyWith(
                 fontSize: 14.sp, color: Styles.colorTextTitle),
             children: <TextSpan>[
               new TextSpan(
                   text: 'البريد الإلكتروني: ',style:  Styles.w400TextStyle()
                   .copyWith(fontSize: 16.sp, color: Styles.colorText)),
               new TextSpan(
                   text: " * ",
                   style:  Styles.w400TextStyle()
                       .copyWith(fontSize: 16.sp, color: Styles.colorPrimary)),
             ],
           ),
         )
     ),
     CommonSizes.vSmallestSpace,
     CustomTextField(
      height: 56.h,
      // width: 217.w,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      textKey: _emailKey,
      controller: _emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isValidEmail(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${S.of(context).validationMessage} ${S.of(context).email}";
      },
      prefixIcon: Icon(
        Icons.email,
        color: Styles.colorPrimary,
      ),
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
      focusNode: _emailFocusNode,
      hintText: S.of(context).enterHere(S.of(context).email),
      minLines: 1,
      onChanged: (String value) {
        if (_emailKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    )];
  }

  _buildPassword() {
    return [
      Container( alignment: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
          child:
          RichText(

            textAlign: Provider.of<LocaleProvider>(context).isRTL
                ? TextAlign.right
                : TextAlign.left,
            softWrap: true,
            textDirection:
            !Provider.of<LocaleProvider>(context, listen: false)
                .isRTL
                ? TextDirection.ltr
                : TextDirection.rtl,
            text: new TextSpan(

              style: Styles.w300TextStyle().copyWith(
                  fontSize: 14.sp, color: Styles.colorTextTitle),
              children: <TextSpan>[
                new TextSpan(
                    text: 'كلمة المرور:  ',style:  Styles.w400TextStyle()
                    .copyWith(fontSize: 16.sp, color: Styles.colorText)),
                new TextSpan(
                    text: " * ",
                    style:  Styles.w400TextStyle()
                        .copyWith(fontSize: 16.sp, color: Styles.colorPrimary)),
              ],
            ),
          )
      ),
      CommonSizes.vSmallestSpace,
      CustomTextField(
      height: 56.h,
      textKey: _passwordKey,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      controller: _passwordController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${S.of(context).validationMessage} ${S.of(context).password}";
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorText),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,

      focusNode: _passwordFocusNode,
        hintText: "*******",
      minLines: 1,
      onChanged: (String value) {
        if (_passwordKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    )];
  }

  _buildConfirmPassword() {
    return [
    Container( alignment: Provider.of<LocaleProvider>(context).isRTL
        ? Alignment.centerRight
        : Alignment.centerLeft,
        child:
        RichText(

          textAlign: Provider.of<LocaleProvider>(context).isRTL
              ? TextAlign.right
              : TextAlign.left,
          softWrap: true,
          textDirection:
          !Provider.of<LocaleProvider>(context, listen: false)
              .isRTL
              ? TextDirection.ltr
              : TextDirection.rtl,
          text: new TextSpan(

            style: Styles.w300TextStyle().copyWith(
                fontSize: 14.sp, color: Styles.colorTextTitle),
            children: <TextSpan>[
              new TextSpan(
                  text: 'تأكيد كلمة المرور ',style:  Styles.w400TextStyle()
                  .copyWith(fontSize: 16.sp, color: Styles.colorText)),
              new TextSpan(
                  text: " * ",
                  style:  Styles.w400TextStyle()
                      .copyWith(fontSize: 16.sp, color: Styles.colorPrimary)),
            ],
          ),
        )
    ),
    CommonSizes.vSmallestSpace,
      CustomTextField(
      height: 56.h,
      textKey: _confirmPasswordKey,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      controller: _confirmPasswordController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isValidConfirmPassword(_passwordController.text,value ?? '')) {
          return null;
        }
         return "${S.of(context).validationMessage} ${S.of(context).confirmPassword}";
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorText),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
      // prefixIcon: Icon(
      //   Icons.lock,
      //   color: Styles.colorTextInactive,
      // ),
      focusNode: _confirmPasswodFocusNode,
      hintText: "*******",
      minLines: 1,
      onChanged: (String value) {
        if (_confirmPasswordKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    )];
  }
  Country _country= Country(
    phoneCode: '966',
    countryCode: 'sa',
    e164Sc: -1,
    geographic: false,
    level: -1,
    name: 'saudi',
    example: '',
    displayName: 'World Wide (WW)',
    displayNameNoCountryCode: 'World Wide',
    e164Key: '',
  ) ;
_showCountryPiker(){

  showCountryPicker(

    context: context,

    showPhoneCode: true, // optional. Shows phone code before the country name.
    onSelect: (Country country) {
      _country=country;
      setState(() {

      });
      print('Select country: ${country.countryCode}');
    },
  );

}
  int selectedIndex = -1;
  List<String> genderString = ['غير ذلك','لبناني', 'فلسطيني'];
  _buildCountry(BuildContext context) {
    return
[
      Container( alignment: Provider.of<LocaleProvider>(context).isRTL
          ? Alignment.centerRight
          : Alignment.centerLeft,
          child:
          RichText(

            textAlign: Provider.of<LocaleProvider>(context).isRTL
                ? TextAlign.right
                : TextAlign.left,
            softWrap: true,
            textDirection:
            !Provider.of<LocaleProvider>(context, listen: false)
                .isRTL
                ? TextDirection.ltr
                : TextDirection.rtl,
            text: new TextSpan(

              style: Styles.w300TextStyle().copyWith(
                  fontSize: 14.sp, color: Styles.colorTextTitle),
              children: <TextSpan>[
                new TextSpan(
                    text: 'الجنسية :',style:  Styles.w400TextStyle()
                    .copyWith(fontSize: 16.sp, color: Styles.colorText)),
                new TextSpan(
                    text: " * ",
                    style:  Styles.w400TextStyle()
                        .copyWith(fontSize: 16.sp, color: Styles.colorPrimary)),
              ],
            ),
          )
      ),
    CommonSizes.vSmallestSpace,
      Container(
        height: 56.h,
        decoration: Styles.coloredRoundedDecoration(
            radius: 8.r, borderColor: Styles.colorBorderTextField),
        // width: 91.w,
        // child: ,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: selectedIndex == -1 ? null : genderString[selectedIndex],
                hint: CustomText(
                  text: 'الجنسية',
paddingHorizantal: 20.w,
alignmentGeometry:Provider.of<LocaleProvider>(context).isRTL
    ? Alignment.centerRight
    : Alignment.centerLeft,
                  textAlign: Provider.of<LocaleProvider>(context).isRTL
                      ? TextAlign.right
                      : TextAlign.left,
                  style: Styles.w400TextStyle().copyWith(fontSize: 14.sp),
                ),
                style: Styles.w400TextStyle().copyWith(fontSize: 14.sp),
                onChanged: genderString.length == 0
                    ? null
                    : (String? newValue) {
                        newValue != null
                            ? selectedIndex = genderString
                                .indexWhere((element) => element == newValue!)
                            : selectedIndex = -1;
                        setState(() {});
                      },
                underline: Container(),
                isExpanded: true,
                items:
                    genderString.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: // Expanded( child:CustomSVGPicture(path: value.flagPath, height: 18.w, width: 18.w)),

                       Row(children: [
                         Expanded(
                           child: Text(value,
                               maxLines: 1,
                               overflow: TextOverflow.clip,
                               textAlign: TextAlign.center,
                               style: Styles.w400TextStyle().copyWith(
                                   fontSize: 16.sp,
                                   color: Styles.colorTextTextField)),
                         )
                       ],),
                  );
                }).toList(),
              ),
              // )
            ),
          ],
        ))];
  }

  bool showPhoneValiadtion = false;
  bool showGenderValiadtion = false;


  _buildBtnRegister(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: sl<AccountBloc>(),
        listener: (context, AccountState state) async {
    if (state is AccountLoading) {
    print('loading');
    } else if (state is RegisterLoaded) {
    try{


    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => VerificationCodeScreen(
    //           email: _emailController.text,
    //              )));


    sl<AppStateModel>().setUser(state.registerEntity!.userModel!);
    String userData=jsonEncode(state.registerEntity!.userModel!.data);
    sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Model, userData);
    sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Nationalty_Data, genderString[selectedIndex]);
    sl<AppStateModel>().setNationalty(genderString[selectedIndex]);

    String userDatarrr=
    sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Model)??'';
    if(state.registerEntity!.userModel!.data!.info !=null){
    String info=jsonEncode(state.registerEntity!.userModel!.data!.info);

    sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Info_Data, info);

    sl<AppStateModel>()
        .prefs
        .setString(SharedPreferencesKeys.USER_Field_Data,'');
    sl<AppStateModel>()
        .prefs
        .setString(SharedPreferencesKeys.USER_Family_Data,'');
      // RequestGroupField requestGroupFieldField=RequestGroupField.fromJson(  jsonDecode( info));
    // print(requestGroupFieldField);
    }


    WidgetsBinding.instance!.addPostFrameCallback((_) {


    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => CompleteProfileScreen(

    // mobile: '222222',
    // country_code: '111',
    )));});
    //
    }

    on Exception catch(e){
    print(e);
    }
    }
        },
        builder: (context, state) {
          if (state is AccountLoading)
            return WaitingWidget(size: 56.r,);
          if (state is AccountError)
            return ErrorWidgetScreen(
              callBack: () {
                if(
                _firstNameController.text.isNotEmpty&&
                    _emailController.text.isNotEmpty&&
                _phoneNumberController.text.isNotEmpty
                 )
                  {
                    if(_passwordController.text.compareTo(_confirmPasswordController.text)==0)
                      {


                        //
                //         'first_name':'first_name_tetwithFile',
                // 'email':'semal@5gai.t',
                // 'last_name':'lastFile',
                // 'country':'syria',
                // 'phone':'1234566',
                // 'password':'123456',
                // 'password_confirmation':'123456',
                // 'name':'neamewwq',
                // 'birth':'neamewwq',
                        //
                        sl<AccountBloc>().add(RegisterEvent(
                            regsiterParams: RegisterParams(
                                body: RegisterParamsBody(
                                  country: genderString[selectedIndex],
                                  phone: _country.phoneCode+_phoneNumberController.text,
                                  email: _emailController.text,
                                  // first_name: _firstNameController.text,
                                  // last_name: _lastNameController.text,
                                  username: _firstNameController.text,
                                  password: _passwordController.text ,
                                  password_confirmation: _confirmPasswordController.text,
                                  // birth: '1992/4/25',
                                ))));

                      }
                  }

              },
              message: state.message ?? "",
              height: 250.h,
              width: 250.w,
            );
          return Center(
            child: CustomButton(
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
    onPressed: () async {

                FocusManager.instance.primaryFocus?.unfocus();


                if(
                _firstNameController.text.isNotEmpty&&
                    _emailController.text.isNotEmpty&&
                    _phoneNumberController.text.isNotEmpty )
                {
                  if(_passwordController.text.compareTo(_confirmPasswordController.text)==0)
                  {
                    sl<AccountBloc>().add(RegisterEvent(
                        regsiterParams: RegisterParams(
                            body: RegisterParamsBody(
                              country: genderString[selectedIndex],
                              phone: _country.phoneCode+_phoneNumberController.text,
                              email: _emailController.text,
                              // first_name: _firstNameController.text,
                              // last_name: _lastNameController.text,
                              username: _firstNameController.text,
                              password: _passwordController.text ,
                              password_confirmation: _confirmPasswordController.text,
                              // birth: '1992/4/25',
                            ))));

                  }
                }
              },
            ),
          );
        });
  }
}
