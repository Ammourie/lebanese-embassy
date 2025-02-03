import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import 'complete_profile_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/widget/custom_text.dart';
import 'register_screen.dart';
import '../../../../core/assets_path.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/loading_overlay.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../navigation/presentation/screens/nav_main_screen.dart';
import '../../data/remote/models/params/login_params.dart';
import '../../data/remote/models/responses/get_field_model.dart';
import '../../data/remote/models/responses/request_group_field.dart';
import '../../data/remote/models/responses/user_model.dart';
import '../blocs/account_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen();

  @override
  State<StatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final bloc = AccountBloc();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _passwordKey =
      new GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _usernameKey =
      new GlobalKey<FormFieldState<String>>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CustomPicture(
                      path: AssetsPath.SVG_register_login_image,
                      isSVG: true,
                      width: 300.w,
                      height: 300.w,
                    ),
                    CustomText(
                      text: 'تسجيل الدخول',
                      style: Styles.w600TextStyle().copyWith(
                          fontSize: 24.sp, color: Styles.colorText),
                      alignmentGeometry:
                          Provider.of<LocaleProvider>(context).isRTL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      textAlign: Provider.of<LocaleProvider>(context).isRTL
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                    CommonSizes.vSmallSpace,
                    _buildUsername(),
                    CommonSizes.vSmallerSpace,
                    _buildPassword(),
                    CommonSizes.vSmallestSpace,
                    CustomText(
                      text: S.of(context).forgotPassword,
                      style: Styles.w600TextStyle().copyWith(
                          fontSize: 14.sp, color: Styles.colorPrimary),
                      alignmentGeometry:
                         ! Provider.of<LocaleProvider>(context).isRTL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      textAlign: !Provider.of<LocaleProvider>(context).isRTL
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                    CommonSizes.vSmallSpace,
                    _buildBtnLogin(context),
              CommonSizes.vSmallerSpace,


                    _buildBtnRegister(context),
                  ],
                ),
              )),
        )),
      ),
    );
  }

  _buildBtnRegister(BuildContext context) {
    return Center(
      child: CustomButton(
        width: double.infinity,
        text:  'حساب جديد',

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
        onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()));

          //
          // Utils.pushNewScreenWithRouteSettings(
          //   context,
          //   settings: const RouteSettings(
          //     name: RoutePaths.Register,
          //   ),
          //   withNavBar: false,
          //   screen: const RegisterScreen(),
          // );
        },
      ),
    );
  }

  @override
  void initState() {
    _usernameController.text='info@lebanon.org';
    _passwordController.text='104520';
    super.initState();
  }

  _buildUsername() {
    return CustomTextField(
      height: 56.h,
      // width: 217.w,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      textKey: _usernameKey,
      controller: _usernameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isValidEmail(value ?? '')) {
          return null;
        }
         return "${S.of(context).validationMessage} ${S.of(context).userName}";
      },
      prefixIcon: Icon(
        Icons.person_2_outlined,
        color: Styles.colorPrimary,
      ),
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
      focusNode: _usernameFocusNode,
      hintText: S.of(context).userName,
      minLines: 1,
      onChanged: (String value) {
        if (_usernameKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
  }

  _buildPassword() {
    return CustomTextField(
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
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: Provider.of<LocaleProvider>(context).isRTL
          ? TextAlign.right
          : TextAlign.left,
      prefixIcon: Icon(
        Icons.lock,
        color: Styles.colorPrimary,
      ),
      focusNode: _passwordFocusNode,
      hintText: S.of(context).password,
      minLines: 1,
      onChanged: (String value) {
        if (_passwordKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
  }

  _buildBtnLogin(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: sl<AccountBloc>(),
        listener: (context, AccountState state) async {
          if (!loading && state is AccountLoading) {
            LoadingOverlay.of(context).show();
            loading = true;          }
          else if (state is LogInLoaded) {
             sl<AppStateModel>().setUser(state.logInEntity!.userModel!);
            String userData=jsonEncode(state.logInEntity!.userModel!.data);
            sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Model, userData);

             String userDatarrr=
             sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Model)??'';
             if(state.logInEntity!.userModel!.data!.info !=null){
               String info=jsonEncode(state.logInEntity!.userModel!.data!.info);

               sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Info_Data, info);
                 info= sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Info_Data  )??'';
               List<InfoData>? infoData= [];
                jsonDecode( info).forEach((v) {
                 infoData!.add(new InfoData.fromJson(v));
               });
                 print(infoData);

               sl<AppStateModel>().setNationalty(state.logInEntity!.userModel!.data!.country??'');

             }
             if(state.logInEntity!.userModel!.data!.fields !=null){
               String fileds=jsonEncode(state.logInEntity!.userModel!.data!.fields);

               sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Field_Data, fileds);
               fileds= sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Field_Data  )??'';

               RequestGroupField requestGroupFieldField=RequestGroupField.fromJson(  jsonDecode( fileds));
                print(requestGroupFieldField);


             }
if(state.logInEntity!.userModel.data!.family!=null){
  String family=jsonEncode(state.logInEntity!.userModel!.data!.family);

  sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Family_Data, family);

}

if(state.logInEntity!.userModel.data!.info==null){
  Utils.pushNewScreenWithRouteSettings(context,
      withNavBar: false,
      screen: CompleteProfileScreen(isEditeProfile: false,),
      settings: RouteSettings(name: RoutePaths.CompleteProfileScreen));


}else{
  Utils.pushNewScreenWithRouteSettings(context,
      withNavBar: false,
      screen: NavMainScreen(),
      settings: RouteSettings(name: RoutePaths.NavMainScreen));


}
               //
        }
          else if(state is AccountError){
            LoadingOverlay.of(context).hide();
            loading = false;
            Utils.showToast(state.message.toString());

            showCustomErrorMessageDialog(
                context:context,
                message: state.message??'',callBack: (){


              sl<AccountBloc>().add(LogInEvent(
                            logInParams: LogInParams(
                                body: LogInParamsBody(
                          username:_usernameController.text,
                          password: _passwordController.text,
                        ))));

              Navigator.of(context).pop();

            });

          }
        },
        builder: (context, state) {
          // if (state is AccountLoading)
          //   return WaitingWidget(size: 50.r,);
          // if (state is AccountError)
          //   return ErrorWidgetScreen(
          //     callBack: () {
          //       sl<AccountBloc>().add(LogInEvent(
          //           logInParams: LogInParams(
          //               body: LogInParamsBody(
          //         username:_usernameController.text,
          //         password: _passwordController.text,
          //       ))));
          //     },
          //     message: state.message ?? "",
          //     height: 250.h,
          //     width: 250.w,
          //   );
          return Center(
            child: CustomButton(
              width: double.infinity,

              text:  'تسجيل دخول',

              style: Styles.w600TextStyle()
                  .copyWith(fontSize: 16.sp,

                  height: 24/16,
                  color: Styles.colorTextWhite),
              raduis: 8.r,
              textAlign: TextAlign.center,
              color: Styles.colorPrimary,
              fillColor: Styles.colorPrimary,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                color: Styles.colorPrimary,


              ),
              // width: 350.w,
              height: 56.h,
              alignmentDirectional: AlignmentDirectional.center,
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                sl<AccountBloc>().add(LogInEvent(
                    logInParams: LogInParams(
                        body: LogInParamsBody(
                          username:_usernameController.text,
                          password: _passwordController.text,
                ))));
          //       Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //       builder: (context) => NavMainScreen(
          // // mobile: '222222',
          // // country_code: '111',
          // )));

                // Utils.pushNewScreenWithRouteSettings(
                //       context,
                //       settings: const RouteSettings(
                //         name: RoutePaths.LogIn,
                //       ),
                //       withNavBar: false,
                //       screen: const LogInScreen(),
                //     );
              },
            ),
          );
        });
  }
}
