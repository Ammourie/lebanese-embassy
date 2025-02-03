import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import '../utils/common_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final String? initialValue;
  final String hintText;
  final InputBorder? inputBorder;
  final InputBorder? errorBorder;
  final int minLines;
  final bool isPhone;
  final bool isEditeStyle;
  final bool justLatinLetters;

  final int? maxLines;
  final double? height;
  final bool? enabled;
  final bool? readonly;
  final bool? filled;
  final GlobalKey<FormFieldState<String>>? textKey;
  final bool? isRtl;
  final Color? fillColor;
  final double? width;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPaddig;
  final BoxDecoration? decoration;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final AutovalidateMode autoValidation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? borderFocus;

  CustomTextField(
      {Key? key,
      this.textKey,
      this.initialValue,
      this.isEditeStyle=false,
      this.isRtl,
      this.width,
      this.fillColor,
      this.hintTextStyle,
      this.filled,
      this.isPhone = false,
      this.justLatinLetters = false,
      this.contentPaddig,
       this.textStyle,
      this.inputBorder,
      this.errorBorder,
        this.controller,
      this.borderFocus,
      required this.textInputAction,
      required this.keyboardType,
      this.focusNode,
      this.autoValidation = AutovalidateMode.disabled,
      this.labelText = "",
      this.validator,
      this.readonly,
      required this.onFieldSubmitted,
      required this.onChanged,
      this.obscureText = false,
      required this.hintText,
      this.inputDecoration,
      required this.minLines,
      this.maxLines,
      this.suffixIcon,
      this.prefixIcon,
      this.height,
      this.decoration,
      this.enabled = true,
      required this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border =
        isEditeStyle?
        UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: BorderSide(color: Styles.colorBorderTextField))
            :
    OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(color: Styles.colorBorderTextField));
    var focusborder =

    isEditeStyle?
    UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(color: Styles.colorPrimary))
        :
    OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(color: Styles.colorPrimary));

    var errorBord =
    isEditeStyle?
    UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(color: Colors.red))
        :
    OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: BorderSide(color: Colors.red));
    return Container(
      alignment: Alignment.center,

      height: textKey?.currentState == null
          ? height
          : textKey?.currentState!.errorText == null
              ? height
              : height! * 1.5,
      width: width,
      child: Center(
          child: TextFormField(

            initialValue:initialValue,
        maxLines: maxLines,
        enabled: enabled,
        ignorePointers:readonly ,
        readOnly: readonly??false,
        key: textKey,

        textAlign: textAlign,
        toolbarOptions:
            ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true),
        textAlignVertical: TextAlignVertical.center,
        textDirection: (isRtl ?? true) ? TextDirection.rtl : TextDirection.ltr,
        autocorrect: false,
        style: textStyle,
        controller: controller,
        textInputAction:TextInputAction.next,
            // textInputAction,
        keyboardType: keyboardType,
        focusNode: focusNode,
        decoration: inputDecoration ??
            InputDecoration(
                // filled: true,
                // labelText: labelText ,
                hintText: hintText,

                errorMaxLines: 1,
                errorText: textKey?.currentState == null
                    ? null
                    : textKey?.currentState!.errorText == null
                        ? null
                        : textKey?.currentState!.errorText!.compareTo('') == 0
                            ? null
                            : textKey?.currentState!.errorText,
                labelStyle: Styles.w400TextStyle().copyWith(
                  fontSize: 14.sp,
                  color: textKey?.currentState == null
                      ? Styles.colorTextInactive
                      : textKey?.currentState!.errorText == null
                          ? Styles.colorTextInactive
                          : Styles.colorTextError,
                ),
                errorStyle: Styles.w400TextStyle().copyWith(
                  fontSize: 12.sp,
                  color: Styles.colorTextError,
                ),
                fillColor: fillColor ?? Styles.colorBackground,
                hintStyle: hintTextStyle??Styles.w400TextStyle().copyWith(
                  fontSize: 16.sp,
                  color: Styles.colorTextHint,
                ),
                filled: filled ?? false,
                border: inputBorder ?? border,
                errorBorder: errorBorder ?? errorBord,
                enabledBorder: inputBorder ?? border,
                // focusedBorder: inputBorder??borderFocus,
                focusedBorder: borderFocus ?? focusborder,
                // helperStyle: TextStyle(fontSize: Styles.fontSize25),

                contentPadding:

                isEditeStyle? EdgeInsetsDirectional.only(
                     end: CommonSizes.SMALL_LAYOUT_W_GAP,
                     bottom:  CommonSizes.TINY_LAYOUT_W_GAP):
                contentPaddig ??
                    EdgeInsetsDirectional.only(
                        start: CommonSizes.SMALL_LAYOUT_W_GAP,
                        end: CommonSizes.SMALL_LAYOUT_W_GAP,
                        top:  CommonSizes.TINY_LAYOUT_W_GAP,
                        bottom:  CommonSizes.TINY_LAYOUT_W_GAP),
                focusedErrorBorder: inputBorder,
                 suffixIcon:isEditeStyle?null: suffixIcon,
                prefixIcon: isEditeStyle?null:prefixIcon),
        validator: validator,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        onChanged: onChanged,
        obscureText: obscureText,
      )),
    );
  }
}
