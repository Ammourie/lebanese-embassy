import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final Icon icon;

  final double? width;
  final double? height;
  final Function onPressed;

  const CustomButtonWithIcon(
      {required this.icon,
      this.height,
      this.width,
      required this.onPressed,
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(
            child: icon,
          )),
    );
  }
}
