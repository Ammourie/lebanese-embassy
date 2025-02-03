import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/assets_path.dart';
import '../../../../core/widget/custom_svg_picture.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import '../blocs/service_bloc.dart';

class EditeWaitingForReviewScreen extends StatelessWidget {

   EditeWaitingForReviewScreen(
       );

  @override
  Widget build(BuildContext context) {
    // if(_serviceBloc.state is ServiceInitial ){
    //   _serviceBloc.add(
    //       CreateOrderServicesEvent(
    //           createOrderServiceParams:
    //           CreateOrderServiceParams(
    //               body:
    //               createOrderServiceParamsBody)));
    //
    // }
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Styles.colorBackgroundBookAppointment,
            body: WillPopScope(
                onWillPop: () async {
                  // Prevent navigation by returning false
                  return false;
                },
                child: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.symmetric(),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            // child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonSizes.vLargerSpace,
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Utils.popNavigate(context,
                                            popsCount: 1);
                                      },
                                      child: SizedBox(
                                          width: 20.w,
                                          child: Icon(
                                            Icons.arrow_back_ios_new,
                                            size: 24.w,
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: CustomText(
                                            textAlign: TextAlign.center,
                                            alignmentGeometry: Alignment.center,
                                            text: '',
                                            style: Styles.w700TextStyle()
                                                .copyWith(
                                                fontSize: 20.sp,
                                                color: Styles.colorText)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    )
                                  ],
                                ),
                                CommonSizes.vSmallerSpace,
                                 CustomPicture(
                                   width: 200.w,height: 200.w,
                                   path: AssetsPath.SVGInprocess,
                                   isSVG: true,isLocal: true,),
                                 CommonSizes.vSmallSpace,
                                 CustomText(
                                   textAlign: TextAlign.center,

                                   text: 'الطلب قيد المعالجة',
                                     style: Styles.w700TextStyle(

                                     ).copyWith(
                                       fontWeight: FontWeight.w800,
                                       color: Color(0xff1565C0),fontSize:
                                     24.sp
                                     ),alignmentGeometry:Alignment.center ,),
                                 CommonSizes.vSmallerSpace,
                                CustomText(

                                  textAlign: TextAlign.center,
                                  text:
                                  'تم تقديم طلبك! سيتم مراجعة طلبك، وسنبلغك بمجرد الموافقة عليه لتتمكن من حجز موعدك. شكرًا لتعاونك'
                                  ,
                                     style: Styles.w600TextStyle(

                                     ).copyWith(
                                       fontWeight: FontWeight.w600,
                                       color: Styles.colorText,
                                       fontSize: 20.sp
                                     ),alignmentGeometry:Alignment.center ,),
                                 CommonSizes.vSmallestSpace,


                                 SizedBox(height: 20),
                                 CommonSizes.vBigSpace,
                              ],
                            )),
                      )),
                ))));
  }
}
