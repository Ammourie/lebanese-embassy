import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../data/remote/models/params/verificationn_params.dart';
import '../blocs/account_bloc.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({  required this.email});

   final String email;

  @override
  State<StatefulWidget> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final bloc = AccountBloc();
  int secondsRemaining = 60;
  bool enableResend = false;
  bool enableSend = false;
  late Timer timer;

  FocusNode _FocusNode = FocusNode();
  AccountBloc _accountBloc = new AccountBloc();
  late TextEditingController textEditingController;
  bool isRtl = false;
  StreamController<ErrorAnimationType>? errorController;

  String _printDuration(int duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.remainder(60));
    if (duration > 59) {
      return "01:$twoDigitSeconds";
    } else {
      return "00:$twoDigitSeconds";
    }
  }

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    isRtl = Provider.of<LocaleProvider>(context, listen: false).isRTL;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Styles.colorBackground,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    // horizontal: CommonSizes.BIGGEST_LAYOUT_W_GAP.w,
                    // vertical: CommonSizes.TINY_LAYOUT_W_GAP.h,
                    ),
                child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 32.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,

                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).padding.top,
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
                                            AssetsPath.SVG_otp_image,
                                        isSVG: true,
                                        width: 265.w,
                                        height: 265.h,
                                      ),
                                      CustomText(
                                        text: S.of(context).verificationTitle,
                                        style: Styles.w700TextStyle().copyWith(
                                            fontSize: 18.sp,
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
                                      CommonSizes.vBigSpace,
                                      Container(
                                        height: 56.h,
                                        child: Form(
                                          key: formKey,
                                          child: Directionality(
                                              textDirection: isRtl
                                                  ? TextDirection.ltr
                                                  : TextDirection.ltr,
                                              child: PinCodeTextField(
                                                appContext: context,
                                                pastedTextStyle: Styles
                                                        .w400TextStyle()
                                                    .copyWith(
                                                        color: Styles
                                                            .colorTextTitle),
                                                length: 5,
                                                obscureText: false,
                                                blinkWhenObscuring: true,
                                                animationType:
                                                    AnimationType.fade,
                                                validator: (v) {
                                                  return null;
                                                },
                                                pinTheme: PinTheme(
                                                  activeColor: Styles
                                                      .colorBorderTextField,
                                                  inactiveColor: Styles
                                                      .colorBorderTextField,
                                                  selectedColor: Styles
                                                      .colorBorderTextField,
                                                  selectedFillColor:
                                                      Styles.colorTextWhite,
                                                  activeFillColor:
                                                      Styles.colorTextWhite,
                                                  inactiveFillColor:
                                                      Styles.colorTextWhite,
                                                  shape: PinCodeFieldShape.box,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  fieldHeight: 56.r,
                                                  fieldWidth: 56.r,
                                                ),
                                                cursorColor:
                                                    Styles.colorTextTitle,
                                                animationDuration:
                                                    const Duration(
                                                        milliseconds: 300),
                                                enableActiveFill: true,
                                                errorAnimationController:
                                                    errorController,

                                                controller:
                                                    textEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                autoDisposeControllers: false,
                                                boxShadows: const [
                                                  // BoxShadow(
                                                  //   offset: Offset(0, 1),
                                                  //   color: Colors.black12,
                                                  //   blurRadius: 10,
                                                  // )
                                                ],
                                                onCompleted: (v) {
                                                  // _accountBloc.add(VerifyUserMobileVerifyCodeEvent(
                                                  //    verifyUserMobileVerifyCodeParams: VerifyUserMobileVerifyCodeParams(
                                                  //        body: VerifyUserMobileVerifyCodeParamsBody(
                                                  //            isChangePhone: widget.isChangePhone,
                                                  //            isChangeEmail: widget.isChangeEmail,
                                                  //            oldPhone: sl<AppStateModel>().user!.mobile,
                                                  //            country_code: widget.country_code.toString(),
                                                  //            mobile: widget.mobile.toString(),
                                                  //            code: textEditingController.text,
                                                  //            userID: sl<AppStateModel>().user!.id,
                                                  //            device_token: device_token))));
                                                },
                                                // onTap: () {
                                                //   print("Pressed");
                                                // },
                                                onChanged: (value) {
                                                  debugPrint(value);
                                                  setState(() {
                                                    currentText = value;
                                                  });
                                                },

                                                beforeTextPaste: (text) {
                                                  debugPrint(
                                                      "Allowing to paste $text");
                                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                                  return true;
                                                },
                                              )),
                                        ),
                                      ),
                                      CommonSizes.vBigSpace,
                                      Container(
                                        // height: 17.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (enableResend) {
                                                  enableResend = false;
                                                  secondsRemaining = 59;
                                                  timer = Timer.periodic(
                                                      Duration(seconds: 1),
                                                      (_) {
                                                    if (secondsRemaining != 0) {
                                                      setState(() {
                                                        secondsRemaining--;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        enableResend = true;
                                                        timer.cancel();
                                                      });
                                                    }
                                                  });

                                                  // _accountBloc.add(
                                                  //     SendUserMobileVerifyCodeEvent(
                                                  //         sendUserMobileVerifyCodeParams:
                                                  //             SendUserMobileVerifyCodeParams(
                                                  //                 body: SendUserMobileVerifyCodeParamsBody(
                                                  //   country_code: widget
                                                  //       .country_code
                                                  //       .toString(),
                                                  //   mobile: widget
                                                  //       .mobile,
                                                  //   userID:
                                                  //       sl<AppStateModel>()
                                                  //           .user!
                                                  //           .id,
                                                  //   isChangePhone:
                                                  //       true,
                                                  // ))));
                                                  // }
                                                  // }
                                                }
                                              },
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: RichText(
                                                    textAlign: TextAlign.start,
                                                    textDirection: isRtl
                                                        ? TextDirection.ltr
                                                        : TextDirection.rtl,
                                                    text: new TextSpan(
                                                      style: Styles
                                                              .w300TextStyle()
                                                          .copyWith(
                                                              fontSize: 14.sp,
                                                              color: Styles
                                                                  .colorTextTitle),
                                                      children: <TextSpan>[
                                                        new TextSpan(
                                                            text: S
                                                                .of(context)
                                                                .didnotReceiveCode),
                                                        new TextSpan(
                                                            text: S
                                                                .of(context)
                                                                .resend,
                                                            style: Styles
                                                                    .w600TextStyle()
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    color: Styles
                                                                        .colorPrimary)),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            CustomText(
                                                text:
                                                    "${_printDuration(secondsRemaining)}",
                                                style: Styles.w400TextStyle()
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  color: Styles.colorTextTitle,
                                                ),
                                                alignmentGeometry: isRtl
                                                    ? Alignment.centerLeft
                                                    : Alignment.centerRight),
                                          ],
                                        ),
                                      ),
                                      CommonSizes.vBiggerSpace,
                                      _buildBtnVerify(),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                    ],
                                  ),
                                )),
                          ))

            )));
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    errorController = StreamController<ErrorAnimationType>.broadcast();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
          timer.cancel();
        });
      }
    });
    textEditingController = new TextEditingController();
  }

  @override
  void dispose() {
    errorController!.close();
    timer.cancel();
    _accountBloc.close();
    super.dispose();
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




            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      // mobile: '222222',
                      // country_code: '111',
                    )));
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
          return Center(
            child: CustomButton(
              width: double.infinity,

              text: S.of(context).verfy,

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

sl<AccountBloc>().add(VerificationEvent(verificationParams: VerificationParams(body: VerificationParamsBody(
    email:widget.email ,
     token:'1234' ))));
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
}
