import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';

import '../../../../core/widget/custom_text.dart';

class StepWidget extends StatefulWidget {
 final int steps;
 final int currentStep;
 final List<String>? title;
 final Function(int)? opnpressed;

 const StepWidget({required this.steps,this.title,this.opnpressed,
    required  this.currentStep,super.key});

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {


    return

      widget.title!=null?

      SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        ...buildStep()
    ]),):


         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              ...buildStep()
            ],)
    ;
  }

  buildStep(){
    List<Widget>ls=[];

    for(int i=0;i<widget.steps;i++){
      if( widget.title!=null)
      ls.add(
InkWell(
    onTap: (){
      widget.opnpressed!(i); // Notify parent widget

    },
    child:
      Container(
        padding: EdgeInsets.zero,
          decoration: Styles.coloredRoundedDecoration(
            border: Border(
              bottom: BorderSide(
                  color: i==widget.currentStep?
                  Styles.colorPrimary
                      :Color(0xffD9D9D9),
                  width: 4.h)) ,
            borderRaduis: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          color:
              Styles.colorBackground
               ,radius: 8.r,
          borderColor:
          Styles.colorBackground
             ,

        ),
        child: widget.title==null?null:
        CustomText(
            textAlign: TextAlign.center,

            text : widget.title![i]??
                '',
            numOfLine: 1,
            style: Styles.w700TextStyle()
                .copyWith(
                fontSize: 16.sp,
                height: 30/16,
                color:
                widget.currentStep==i?
                Styles.colorPrimary
                    :
                Styles.colorText)),


      )));
else{
        ls.add(

               Expanded(child:   Container(
                 height: 4.h,width: 50,
                  padding: EdgeInsets.zero,
                  decoration: Styles.coloredRoundedDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: i<=widget.currentStep?
                            Styles.colorPrimary
                                :Color(0xffD9D9D9),
                            width: 4.h)) ,
                    borderRaduis: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    color:
                    i<=widget.currentStep?
                    Styles.colorPrimary
                        :Color(0xffD9D9D9)
                    ,radius: 8.r,
                    borderColor:i<=widget.currentStep?
                    Styles.colorPrimary
                        :Color(0xffD9D9D9)
                     ,

                  ),



               )          ));
      }
      ls.add(       CommonSizes.hSmallestSpace
        );
    }
    return ls;

  }
}
