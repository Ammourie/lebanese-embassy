 
 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/remote/models/params/get_order_params.dart';
import '../blocs/order_bloc.dart';
import 'order_card.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../service_locator.dart';
import '../../../category/presentation/blocs/category_bloc.dart';

class OrderScreen  extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>  {
  bool isRtl = false;


 
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
     _requestTask();

    super.initState();
  }
 

 
  GetOrdersLoaded? getOrdersLoaded;
  final GlobalKey<FormFieldState<String>> _searchKey =
  new GlobalKey<FormFieldState<String>>();
  _requestTask() async {
    sl<OrderBloc>().add(GetOrdersEvent(
        getOrderParams: GetOrderParams(
            body:GetOrderParamsBody(
            ))));
  }


   List<Widget> widgetLsit=[];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
         body:SafeArea(

            bottom: true,
            top: false,
            maintainBottomViewPadding: true,
            child:  Container(
                color: Styles.colorAppBarBackground,
                width: screenSize.width,
                height: screenSize.height,
                child: Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 150.h,
                            decoration: Styles.coloredRoundedDecoration(
                              color: Styles.colorAppBarBackground,
                              radius: 0,borderColor: Styles.colorAppBarBackground,
                            ),
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child:    Row(children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);                                                },
                              child:
                              SizedBox(width: 20.w,
                                  child:
                              Icon(Icons.arrow_back_ios_new,color: Styles
                                  .colorTextWhite,)
                              // ),
                  ,),),
                            Expanded(child:   Container(
                              child: CustomText(
                                  textAlign: TextAlign.center,
                                  alignmentGeometry:
                                  Alignment.center,
                                  text: 'طلباتي'??'',
                                  style: Styles.w400TextStyle()
                                      .copyWith(
                                      fontSize: 20.sp,
                                      color: Styles
                                          .colorTextWhite)),
                            ),),
                            SizedBox(width: 20.w,)
                          ],),
                        ),

                        Expanded(child:
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),

                          decoration:
                     BoxDecoration(
                       color: Styles.colorUserInfoBackGround,
                         borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(50.r),
                             topRight: Radius.circular(50.r)
                         ),
                         border: Border(
                           left: BorderSide( //                   <--- left side
                             color: Styles.colorUserInfoBackGround,
                             width: 1.0,
                           ),

                         )),
                     child:



Container(

padding: EdgeInsets.symmetric(vertical: 20.w),



      child:
  Container(
    child: BlocConsumer<OrderBloc , OrderState>(
        bloc: sl<OrderBloc>(),
        listener: (context, OrderState state) async {
          if (state is OrderLoading) {
            print('loading');
          } else if (state is GetOrdersLoaded ) {
            getOrdersLoaded=state;

          }




          //
        },
        builder: (context, state) {
          if (state is OrderLoading)
            return WaitingWidget();
          if (state is OrderError)
            return ErrorWidgetScreen(
              callBack: () {

              },
              message: state.message ?? "",
              height: 250.h,
              width: 250.w,
            );
          return
            getOrdersLoaded==null?
            Container():
            ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20.w),
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index)=>OrderCard(
                  orderModel:  getOrdersLoaded!.getOrderEntity!.orderModelList[index],
                ),
                separatorBuilder:
                    (BuildContext context,int index)=>
                    CommonSizes.vBigSpace ,
                itemCount: getOrdersLoaded!.getOrderEntity!.orderModelList.length);
        }))),





                    )
    )
    ])
    )
    ))
    );
  }
 }
