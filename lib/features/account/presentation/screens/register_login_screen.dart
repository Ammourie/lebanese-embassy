import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/assets_path.dart';
import 'login_screen.dart';
import 'register_screen.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../generated/l10n.dart';
import 'complete_profile_screen.dart';

class RegisterLoginScreen extends StatelessWidget {
  const RegisterLoginScreen({super.key});
  _buildBtnLogin(BuildContext context) {
    return Center(
      child: CustomButton(

        width:170.w,


        text: 'ابدء الآن',

        style: Styles.w700TextStyle()
            .copyWith(fontSize: 24.sp, color: Styles.colorTextWhite),
        raduis: 8.r,
        textAlign: TextAlign.center,
        color: Styles.colorPrimary,
        fillColor: Styles.colorPrimary,
        decoration: BoxDecoration(
            color: Styles.colorPrimary,

            borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),

              color:Color(0x00000040),
          // Styles.colorBlackShadow.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 16,
            ),
          ]
        ),
        // width: 350.w,
        height: 56.h,
        alignmentDirectional: AlignmentDirectional.center,
        onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogInScreen()));

          // Utils.pushNewScreenWithRouteSettings(
          //       context,
          //       settings: const RouteSettings(
          //         name: RoutePaths.LogIn,
          //       ),
          //       withNavBar: false,
          //       screen: const LogInScreen(),
          //     );
        },
      ),
    );
  }


   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0.h),
              // child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),

                    CommonSizes.vHugeSpace,
                    CustomPicture(
                      path: AssetsPath.SVG_register_login_image,
                      isSVG: true,
                      width: 300.w,
                      height: 300.w,
                    ),
                    CustomRichText(
                      alignmentGeometry: Alignment.center,
                      textAlign: TextAlign.center,

                      text: [
                      TextSpan(
                        text:  '"مرحباً بكم في تطبيق',
                          style: Styles.w600TextStyle().copyWith(
                              color: Styles.colorText,                            height: 33/16

                          )
                      ),

                      TextSpan(
                        text:'\nالسفارة اللبنانية في الرياض!\n',
                        style: Styles.w600TextStyle().copyWith(
                          color: Styles.colorPrimary,                            height: 33/16

                        )
                      ),
                      TextSpan(
                        text:'نحن هنا لخدمتكم وتسهيل إجراءاتكم\n',
                          style: Styles.w600TextStyle().copyWith(
                              color: Styles.colorText,
                            height: 33/16
                          )
                      ),
                      TextSpan(
                        text:'القنصلية بأبسط الطرق.',
                          style: Styles.w600TextStyle().copyWith(
                              color: Styles.colorText,
                              height: 33/16

                          )
                      ),


                    ],

                    ),
                    // Expanded(child: Container()),
                    CommonSizes.vBigSpace,
                    _buildBtnLogin(context),
                    CommonSizes.vSmallSpace,


                  ],
                // ),
              )),
        ),
      ),
    );
  }
}
