import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../blocs/account_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen();

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final bloc = AccountBloc();

  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  FocusNode _newPasswordFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _passwordKey =
      new GlobalKey<FormFieldState<String>>();

  final GlobalKey<FormFieldState<String>> _newPasswordKey =
      new GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
            child: FormBuilder(
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Row(children: [
                      SizedBox(
                          height: 20.w,width: 20.w,
                          child:   Icon(Icons.arrow_back_ios_new)),
                      CommonSizes.hSmallestSpace,
                      CustomText(
                        text: S.of(context).back,
                        style: Styles.w300TextStyle().copyWith(
                            fontSize: 16.sp,
                            color: Styles.colorPrimary),
                        alignmentGeometry:
                        Provider.of<LocaleProvider>(context)
                            .isRTL
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        textAlign:
                        Provider.of<LocaleProvider>(context)
                            .isRTL
                            ? TextAlign.right
                            : TextAlign.left,
                      ),
                    ],),
                    CustomPicture(
                      path:
                      AssetsPath.SVG_new_password_image,
                      isSVG: true,
                      width: 265.w,
                      height: 265.h,
                    ),
                    CustomText(
                      text: S.of(context).newPasswordTitle,
                      style: Styles.w300TextStyle().copyWith(
                          fontSize: 24.sp, color: Styles.colorPrimary),
                      alignmentGeometry:
                          Provider.of<LocaleProvider>(context).isRTL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      textAlign: Provider.of<LocaleProvider>(context).isRTL
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                    CommonSizes.vSmallSpace,
                    _buildPassword(),
                    CommonSizes.vSmallSpace,
                    _buildnewPassword(),
                    CommonSizes.vSmallSpace,
                    _buildBtnVerify(),
                     CommonSizes.vBigSpace,
                  ],
                ),
              )),
        )),
      ),
    );
  }
  _buildBtnVerify() {
    return BlocConsumer<AccountBloc, AccountState>(
        bloc: sl<AccountBloc>(),
        listener: (context, AccountState state) async {
          if (state is AccountLoading) {
            print('loading');
          }
          else if (state is VerficationLoaded) {
            sl<AppStateModel>().setUser(state.verificationEntity!.userModel!);
            String userData=jsonEncode(state.verificationEntity!.userModel!.data);
            sl<AppStateModel>().prefs.setString(SharedPreferencesKeys.USER_Model, userData);

            String userDatarrr=
                sl<AppStateModel>().prefs.getString(SharedPreferencesKeys.USER_Model)??'';





          }

        },
        builder: (context, state) {
          if (state is AccountLoading)
            return WaitingWidget(  );
          if (state is AccountError)
            return ErrorWidgetScreen(
              callBack: () {},
              message: state.message ?? "",
              height: 250.h,
              width: 250.w,
            );
          return Center(
            child: CustomButton(
              width: double.infinity,

              text: S.of(context).changePassword,

              style: Styles.w500TextStyle()
                  .copyWith(fontSize: 20.sp, color: Styles.colorTextWhite),
              raduis: 14.r,
              textAlign: TextAlign.center,
              color: Styles.colorPrimary,
              fillColor: Styles.colorPrimary,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(6.r),
                ),
                gradient: LinearGradient(
                  colors: [
                    Styles.colorGradientBlueStart,
                    Styles.colorGradientBlueEnd
                  ],
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                ),
              ),
              // width: 350.w,
              height: 54.h,
              alignmentDirectional: AlignmentDirectional.center,
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();

//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomeScreen()));

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        color: Styles.colorTextInactive,
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

  _buildnewPassword() {
    return CustomTextField(
      height: 56.h,
      textKey: _newPasswordKey,
      isRtl: Provider.of<LocaleProvider>(context).isRTL,
      controller: _newPasswordController,
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
        color: Styles.colorTextInactive,
      ),
      focusNode: _newPasswordFocusNode,
      hintText: S.of(context).password,
      minLines: 1,
      onChanged: (String value) {
        if (_newPasswordKey.currentState!.validate()) {}
        setState(() {});
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
  }
}
