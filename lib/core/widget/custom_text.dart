import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? numOfLine;

  final AlignmentGeometry alignmentGeometry;
  final double paddingVertical;
  final double paddingHorizantal;
  final bool isNumberFormat;

  const CustomText(
      {required this.text,
      required this.style,
      this.alignmentGeometry = Alignment.centerLeft,
      this.paddingVertical = 0,
      this.paddingHorizantal = 0,
      this.textAlign,
      this.isNumberFormat = false,
      this.numOfLine,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isNumberFormat) {
      final formatter = NumberFormat("#,###");
      final formattedNumber = formatter.format(int.tryParse(text));
      return Container(
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizantal),
          alignment: alignmentGeometry,
          child: Text(
            formattedNumber,
            textAlign: textAlign ?? TextAlign.start,
            strutStyle: StrutStyle(
                height: 1.2,
                forceStrutHeight: true,
                fontSize: style.fontSize,
                fontFamily: style.fontFamily,
                fontWeight: style.fontWeight,
                fontStyle: FontStyle.normal),
            style: this.style,
            softWrap: true,
            overflow: TextOverflow.clip,
            maxLines: this.numOfLine,
            // overflow: TextOverflow.ellipsis,
          ));
    } else {
      return Container(
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizantal),
          alignment: alignmentGeometry,
          child: Text(
            text,
            textAlign: textAlign ?? TextAlign.start,
            strutStyle: StrutStyle(
                height: 1.2,
                forceStrutHeight: true,
                fontSize: style.fontSize,
                fontFamily: style.fontFamily,
                fontWeight: style.fontWeight,
                fontStyle: FontStyle.normal),
            style: this.style,
            softWrap: true,
            overflow: TextOverflow.clip,
            maxLines: this.numOfLine,
            // overflow: TextOverflow.ellipsis,
          ));
    }
  }
}
