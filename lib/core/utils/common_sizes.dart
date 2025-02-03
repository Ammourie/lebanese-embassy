import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CommonSizes {
  static final Size_16_VGAP = 16.h;
  static final Size_8_VGAP = 8.h;
  static final Size_16_HGAP = 16.w;
  static final Size_18_VGAP = 18.h;
  static final Size_12_HGAP = 12.w;
  static final Size_12_VGAP = 12.h;

  static final Size_8_HGAP = 8.h;
  static final Size_18_HGAP = 18.w;

  static final Size_20_HGAP = 20.w;
  static final Size_20_VGAP = 20.h;
  static final Size_24_HGAP = 24.w;
  static final Size_24_VGAP = 24.h;
  static const TINY_LAYOUT_W_GAP = 12.0;
  static const SMALL_LAYOUT_W_GAP = 20.0;
  static const MED_LAYOUT_W_GAP = 50.0;
  static const BIG_LAYOUT_W_GAP = 75.0;
  static const BIGGER_LAYOUT_W_GAP = 100.0;
  static const BIGGEST_LAYOUT_W_GAP = 125.0;
  static const BORDER_RADIUS_STANDARD = 15.0;
  static const BORDER_RADIUS_CORNERS_BIG = 18.0;

  static final appBarHeight = 90.h;

  static final v4Space = SizedBox(height: 4.h);
  static final h4Space = SizedBox(width: 4.h);
  static final vSmallestSpace = SizedBox(height: 8.h);
  static final vSmallerSpace = SizedBox(height: 16.h);
  static final vSmallSpace = SizedBox(height: 24.h);
  static final vBigSpace = SizedBox(height: 32.h);
  static final vBiggerSpace = SizedBox(height: 50.h);
  static final vBiggestSpace = SizedBox(height: 60.h);
  static final vLargeSpace = SizedBox(height: 70.h);
  static final vLargerSpace = SizedBox(height: 80.h);
  static final vLargestSpace = SizedBox(height: 90.h);
  static final vHugeSpace = SizedBox(height: 100.h);

  static final hSmallestSpace = SizedBox(width: 8.w);
  static final hSmallerSpace = SizedBox(width: 20.w);
  static final hSmallSpace = SizedBox(width: 30.w);
  static final hBigSpace = SizedBox(width: 40.w);
  static final hBiggerSpace = SizedBox(width: 50.w);
  static final hBiggestSpace = SizedBox(width: 60.w);
  static final hLargeSpace = SizedBox(width: 70.w);
  static final hLargerSpace = SizedBox(width: 80.w);
  static final hLargestSpace = SizedBox(width: 90.w);
  static final hHugeSpace = SizedBox(width: 100.w);

  static const divider = const Divider(thickness: 10);
}
