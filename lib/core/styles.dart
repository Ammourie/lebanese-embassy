import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class Styles {
  /// App Settings

  //Color
  static Color get colorPrimary => Color(0xFF039344);

  static Color get colorSecondry => Color(0xFFE27B14);

  static Color get colorbtnGray => Color(0xFF898989);

  static Color get colorIconInActive => Color(0xFF363636);

  static Color get colorBackground => Color(0xFFFFFFFF);
  static Color get colorBackgroundHome => Color(0xFFF6F6F6);
  static Color get colorBackgroundBookAppointment => Color(0xFFFAFAFA);

  static Color get colorBackgroundTextField => Color(0xFF2D2D2D);

   static Color get colorBackgroundWhite=> Color(0xFFFFFFFF);

  static Color get colorGradientBlueStart => Color(0xFF090653);

  static Color get colorGradientBlueEnd => Color(0xFF140DB9);

  static Color get colorGradientGreenStart => Color(0xFF0E8149);

  static Color get colorGradientGreenEnd => Color(0xFF88D3D6);

  static Color get colorTextTitle => Color(0xFF000000);
  static Color get colorText => Color(0xFF000000);
  static Color get colorActiveText => Color(0xFF039344);
  static Color get colorAppBarBackground => Color(0xFF095E32);
  static Color get colorTextAccountColor => Color(0xFF003519);
   static Color get colorinActiveText => Color(0xFF4F4F4F);
  static Color get colorTextHint => Color(0xFF898989);

  static Color get colorBorderTextField => Color(0xFF757575);

  static Color get colorTextTextField => Color(0xFF000000);

  static Color get colorTextInactive => Color(0xFFA1A1A1);

  static Color get colorTextError => Color(0xFFFF0000);

  static Color get colorTextWhite => Color(0xFFFFFFFF);
  static Color get colorCardBackGround => Color(0xFFF2F4F4);
  static Color get colorUserInfoBackGround => Color(0xFFF7F7F7);

  static Color get colorTextgrey => Color(0xFF7B7B7B);

  static Color get colorCayan => Color(0xFF51B5B7);
  static Color get colorTextAboutUs => Color(0xFF333333);

  static Color get colorevenntCart => Color(0xFFE6E5FA);
  static Color get coloreBlackText => Color(0xFF1F1F1F);

  static Color get colorBlackShadow => Color(0xFF000000);
  static Color get colorCardFamilyMember => Color(0xFFF8F8F8);
  static Color get colorIconCardFamilyMember => Color(0xFFEBEBEB);

  /// font
  static const FontFamily = 'Cairo';
  static const FontFamilyBlack = 'Cairo';
  static const FontFamilyBold = 'Cairo';
  static const FontFamilySemiBold = 'Cairo';
  static const FontFamilyLight = 'Cairo';
  static const FontFamilyMedium = 'Cairo';
  static const FontFamilyRegular = 'Cairo';




  static double fontSizeCustom(double size) => size;

  static TextStyle get fontStyle => TextStyle(fontFamily: FontFamily);

  static TextStyle get fontW500Style => TextStyle(
        fontFamily: FontFamily,
      );

  static TextStyle get fontW300Style => TextStyle(
        fontFamily: FontFamily,
      );

  static StrutStyle get structStyle => StrutStyle(fontFamily: FontFamily);

  static BoxDecoration tilesDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10.r),
      ),
      border: Border.all(color: Color(0xFFAFCEEB).withOpacity(0.09)),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(0, 5), // changes position of shadow
        )
      ],
      color: Colors.white);

  static TextStyle w700TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
      height: 1.2,
      overflow: TextOverflow.fade,
      // fontFamily: !isArb ? FontFamilyBoldArb : Styles.FontFamily,
      fontFamily: FontFamily,
      color: Styles.colorPrimary);

  static TextStyle w400TextStyle() => fontStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily,
        height: 1.2,
        overflow: TextOverflow.fade,
      );

  static TextStyle w300TextStyle() => fontStyle.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
        height: 1.5,
        overflow: TextOverflow.fade,
        fontFamily: FontFamily,
      );

  static TextStyle w600TextStyle() => fontStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.5,
        overflow: TextOverflow.fade,
        fontFamily: FontFamily,
      );

  static TextStyle w500TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      height: 1.5,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w500,
      color: Styles.colorPrimary);

  static BoxDecoration coloredRoundedDecoration(
          {double radius = 5,
          Color borderColor = const Color(0xFF488B89),
          Color color = const Color(0xFFFFFFFF),
            BoxBorder? border ,
            BorderRadius? borderRaduis,
          List<BoxShadow> boxShadow = const []}) =>
      BoxDecoration(
          borderRadius:borderRaduis?? BorderRadius.all(
            Radius.circular(radius),
          ),
          border:border?? Border.all(color: borderColor),
          color: color,

          boxShadow: boxShadow);

  static BoxDecoration coloredOrderStatusRoundedDecoration(OrderStatus orderState ) {
    switch (orderState) {
      case OrderStatus.InProcessing:
        return BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(color: Color(0xff123089).withOpacity(0.08)),
            color:  Color(0xff123089).withOpacity(0.08),

            );
        break;
        case OrderStatus.Processed:
        return BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(color: colorPrimary.withOpacity(0.08)),
            color: colorPrimary.withOpacity(0.08),

            );
        break;
      case OrderStatus.Booked:
        return BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(8.r)),
          border: Border.all(color: Color(0xff039344).withOpacity(0.08)),
          color: Color(0xff039344).withOpacity(0.08),

        );
        break;
        case OrderStatus.Completed:
        return BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(8.r)),
          border: Border.all(color: colorPrimary.withOpacity(0.08)),
          color: colorPrimary.withOpacity(0.08),

        );
        break;
      case OrderStatus.Failed:
        return BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(color: Color(0xffF41818).withOpacity(0.8)),
            color:Color(0xffF41818).withOpacity(0.8),

            );
        break;
      default:
        return BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(8.r)),
          border: Border.all(color: Color(0xff123089).withOpacity(0.08)),
          color:Color(0xff123089).withOpacity(0.08),

        );

    }
  }
  static TextStyle coloredTextStyleOrderStatus(OrderStatus orderState)

      {
  switch (orderState) {
  case OrderStatus.InProcessing:
  return   fontStyle.copyWith(
      fontSize: 12.sp,
      height:2,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w600,
      color: Color(0xff123089)) ;
    case OrderStatus.Processed:
      return  fontStyle.copyWith(
          fontSize: 12.sp,
          height:2,
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w600,
          color: Styles.colorPrimary) ;
    case OrderStatus.Booked:
      return  fontStyle.copyWith(
          fontSize: 12.sp,
          height:2,
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w600,
          color: Styles.colorPrimary) ;
    case OrderStatus.Completed:
      return  fontStyle.copyWith(
          fontSize: 12.sp,
          height:2,
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w600,
          color: Styles.colorPrimary) ;
      case OrderStatus.Failed:
      return  fontStyle.copyWith(
          fontSize: 12.sp,
          height:2,
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w600,
          color: Color(0xffF41818)) ;
  default:
  return      fontStyle.copyWith(
      fontSize: 12.sp,
      height:2,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w600,
      color: Color(0xff123089))  ;
  }
      }




  static BoxDecoration gradientRoundedDecoration(
          {double radius = 5,
          Color borderColor = const Color(0xFF488B89),
          Color color = const Color(0xFFFFFFFF),
          List<BoxShadow> boxShadow = const []}) =>
      BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: Border.all(color: borderColor),
          color: color,
          gradient: LinearGradient(
            colors: [
              // colorGradientStart,
              // colorG//radientEnd
            ],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ),
          boxShadow: boxShadow);

  static TextStyle formInputTextStyle = fontStyle.copyWith(
      fontWeight: FontWeight.w200, fontFamily: Styles.FontFamily);
  static InputDecoration formInputDecoration = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: Colors.white);

  static InputDecoration borderedRoundedFieldDecoration({double radius = 40}) =>
      formInputDecoration.copyWith(
          border: roundedOutlineInputBorder(radius: radius),
          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);

  static InputBorder roundedTransparentBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(radius),
      );

  static InputBorder roundedOutlineInputBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: Styles.colorPrimary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      );
}
