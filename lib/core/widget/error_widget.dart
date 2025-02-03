import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';
import '../styles.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final String message;
  final Function callBack;
  final double? height;
  final double? width;

  const ErrorWidgetScreen(
      {required this.message,
      required this.callBack,
      this.width,
      this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Styles.colorPrimary.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // // SizedBox(height: height*0.2,),

                Center(
                    child: CustomText(
                  text: message ?? "",
                  style: Styles.w500TextStyle().copyWith(
                    fontSize: 16.sp,
                    color: Styles.colorTextError,
                  ),
                  textAlign: TextAlign.center,
                  alignmentGeometry: Alignment.center,
                )),

                Container(
                  // padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 20.w),
                  margin:
                      EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),

                  child: CustomButton(
                    height: (height ?? 25) * 0.2,
                    text: 'اعادة محاولة',
                    style: Styles.w500TextStyle().copyWith(
                        color: Styles.colorTextWhite, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                    color: Styles.colorTextWhite,
                    fillColor: Styles.colorPrimary,
                    alignmentDirectional: AlignmentDirectional.center,
                    onPressed: callBack,
                  ),
                ),
                // SizedBox(height: height*0.05,),
              ],
            )),
      ),
    );
  }
}
