import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/assets_path.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';

import '../../../../generated/l10n.dart';
import '../../../../l10n/locale_provider.dart';

class TournamentCard extends StatelessWidget {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with heart and info icons
          CarouselSlider(
            items: [
              CustomPicture(
                path: AssetsPath.SVGTabViewIcon1,
                isSVG: true,
              ),
              CustomPicture(path: AssetsPath.SVGTabViewIcon1, isSVG: true)
            ],
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Row(
              children: [
                SizedBox(
                  child: CustomPicture(
                    path: AssetsPath.SVGTabViewIcon1,
                    height: 36.r,
                    isSVG: true,
                    width: 36.r,
                    isCircleShape: true,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.start,
                        textDirection:
                            Provider.of<LocaleProvider>(context, listen: false)
                                    .isRTL
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        text: new TextSpan(
                          style: Styles.w300TextStyle().copyWith(
                              fontSize: 14.sp, color: Styles.colorTextTitle),
                          children: <TextSpan>[
                            new TextSpan(
                                text: S.of(context).didnotReceiveCode + '\n'),
                            new TextSpan(
                                text: S.of(context).resend,
                                style: Styles.w600TextStyle().copyWith(
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.underline,
                                    color: Styles.colorPrimary)),
                          ],
                        ),
                      )),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: Styles.coloredRoundedDecoration(
                    radius: 4.r,
                    borderColor: Styles.colorevenntCart,
                    color: Styles.colorevenntCart,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.gif_box_outlined),
                      Container(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.start,
                            textDirection: Provider.of<LocaleProvider>(context,
                                        listen: false)
                                    .isRTL
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            text: new TextSpan(
                              style: Styles.w300TextStyle().copyWith(
                                  fontSize: 14.sp,
                                  color: Styles.colorTextTitle),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: S.of(context).didnotReceiveCode),
                                new TextSpan(
                                    text: S.of(context).resend,
                                    style: Styles.w600TextStyle().copyWith(
                                        fontSize: 14.sp,
                                        decoration: TextDecoration.underline,
                                        color: Styles.colorPrimary)),
                              ],
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),

          Container(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Container(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    textAlign: TextAlign.start,
                    textDirection:
                        Provider.of<LocaleProvider>(context, listen: false)
                                .isRTL
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    text: new TextSpan(
                      style: Styles.w300TextStyle().copyWith(
                          fontSize: 14.sp, color: Styles.colorTextTitle),
                      children: <TextSpan>[
                        new TextSpan(text: S.of(context).didnotReceiveCode),
                        new TextSpan(
                            text: S.of(context).resend,
                            style: Styles.w600TextStyle().copyWith(
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                color: Styles.colorPrimary)),
                      ],
                    ),
                  ))),

          Container(
              width: 400.w,
              height: 40.h,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => Container(
                        height: 24.h,
                        width: 73.w,
                        decoration: Styles.coloredRoundedDecoration(
                            radius: 16.r,
                            color: Styles.colorevenntCart,
                            borderColor: Styles.colorPrimary),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomPicture(
                              path: AssetsPath.SVGTabViewIcon1,
                              isSVG: true,
                              height: 16.w,
                              width: 16.w,
                            ),
                            CustomText(
                              text: 'كرة قدم',
                              style: Styles.w700TextStyle().copyWith(
                                  fontSize: 10.sp, color: Styles.colorPrimary),
                            ),
                          ],
                        ),
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      CommonSizes.hSmallerSpace,
                  itemCount: 4)),

          CommonSizes.vSmallerSpace,
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  CategoryButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
