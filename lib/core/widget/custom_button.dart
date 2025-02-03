import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Color color;
  final Color fillColor;
  final double? width;
  final double? height;
  final Function onPressed;
  final double raduis;
  final BoxDecoration? decoration;
  final AlignmentDirectional alignmentDirectional;

  const CustomButton(
      {required this.text,
      required this.style,
      required this.textAlign,
      this.height,
      required this.color,
      required this.fillColor,
      this.width,
      required this.onPressed,
      this.decoration,
      required this.alignmentDirectional,
      this.raduis = 30,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
          width: width,
          height: height,
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(raduis),
                ),
                border: Border.all(color: color),
                color: fillColor,
              ),
          child: Center(
            child: CustomText(
              text: text,
              style: style,
              textAlign: TextAlign.center,
              alignmentGeometry: alignmentDirectional,
            ),
          )),
    );
  }
}
