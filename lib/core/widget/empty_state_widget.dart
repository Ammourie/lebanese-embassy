import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import '../utils/common_sizes.dart';
import 'custom_text.dart';

class EmptyStateWidget extends StatelessWidget {
  EmptyStateWidget({required this.text, Key? key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonSizes.vSmallerSpace,
            CustomText(
              text: text,
              textAlign: TextAlign.center,
              style: Styles.w300TextStyle().copyWith(
                fontSize: 32.sp,
                color: Styles.colorTextInactive,
              ),
              alignmentGeometry: Alignment.center,
            )
          ],
        ));
  }
}
