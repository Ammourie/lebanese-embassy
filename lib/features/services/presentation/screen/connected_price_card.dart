import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../account/data/remote/models/responses/get_field_model.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/custom_text.dart';
import '../../data/remote/models/responses/get_service_model.dart';

class ConnectedPriceCard extends StatefulWidget {
  ConnectedPriceCard({ required this.serviceModel,super.key});
  ServiceModel serviceModel;
  @override
  State<ConnectedPriceCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<ConnectedPriceCard> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return
      InkWell(

          onTap: () {
            setState(() {
              showAll = !showAll;
            });
          },
          child:
          Container(
            child: Container(
                height: showAll==false?53.h:null,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(8.r)),
                    border: Border(
                      right: BorderSide(
                        //                   <--- left side
                        color: Styles.colorPrimary,
                        width: 3.0,
                      ),
                    )),
                child:
                Column(children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: CustomText(
                            text: widget.serviceModel.name ?? '',
                            style: Styles.w600TextStyle().copyWith(
                              fontSize: 16.sp,
                              color: Styles.colorText,
                            ),
                            alignmentGeometry: Alignment.centerRight,
                          )),
                       CommonSizes.hSmallestSpace,

                    ],
                  ),
                  if(showAll) ..._buildShowAll()
                ],)


            ),
          ));
  }

  _buildShowAll() {

//



  //
   return [

     ListView.separated(
       padding: EdgeInsets.symmetric(vertical: 20.w),
       shrinkWrap: true,
       itemBuilder: (BuildContext context,int index)=>
           // Row(children: [

             CustomRichText(
                 alignmentGeometry: Alignment.centerRight,
                 textAlign: TextAlign.right,
                 //
                 text: [


                   TextSpan(
                       text:  (widget.serviceModel!.subServices![index].name??'')   +"\n",
                       style: Styles.w600TextStyle().copyWith(
                           color: Styles.colorText,
                           fontSize: 14.sp,

                           height: 33/16

                       )
                   ),
                   TextSpan(
                       text:widget.serviceModel!.subServices![index].price??'',

                       style: Styles.w600TextStyle().copyWith(
                           color: Styles.colorPrimary,

                           fontSize: 14.sp,
                           height: 33/16

                       ))]),
           // ],)
       // ,
       separatorBuilder:
           (BuildContext context,int index)=>
       CommonSizes.vBigSpace ,
       itemCount: widget.serviceModel!.subServices!.length??0)];
  }
}