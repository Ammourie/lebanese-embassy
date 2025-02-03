import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import '../utils/common_sizes.dart';

class SocialAppBar extends StatelessWidget {
  const SocialAppBar({
    Key? key,
    required this.tail,
  }) : super(key: key);

  final Widget tail;

  @override
  Widget build(BuildContext context) {
    final orientation = ScreenUtil().orientation;
    // final fontSize = orientation == Orientation.landscape
    //     ? Styles.fontSize7
    //     : Styles.fontSize1;
    return Container(
        height: 152.h,
        padding: EdgeInsets.only(
          left: CommonSizes.Size_24_HGAP,
          right: CommonSizes.Size_24_HGAP,
          top: 40.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(0.r),
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
        child: tail

        // ),

        // )
        );
  }
}
