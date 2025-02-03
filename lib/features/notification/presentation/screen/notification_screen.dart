 
 
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/remote/models/params/get_notification_params.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../service_locator.dart';

  import '../blocs/notification_bloc.dart';
import 'notification_card.dart';

class NotificationScreen  extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  {
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
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;



  GetNotificationsLoaded? getNotificationsLoaded;

  _requestTask() async {
    sl<NotificationBloc>().add(GetNotificationsEvent(
        getNotificationParams: GetNotificationParams(
          body: GetNotificationParamsBody()
         )));
  }


   List<Widget> widgetLsit=[];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
         body:
         SwipeRefresh.material(
             stateStream:_stream,
             onRefresh: _refresh,

             padding: const EdgeInsets.symmetric(vertical: 0),
             children: <Widget>[
         SafeArea(

            bottom: true,
            top: false,
            maintainBottomViewPadding: true,
            child:



            Container(
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
                                  text: 'الاشعارات'??'',
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

                         // color: Styles.colorUserInfoBackGround,
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

padding: EdgeInsets.symmetric(vertical: 20.w, ),


      child:
  Container(
    child: BlocConsumer<NotificationBloc , NotificationState>(
        bloc: sl<NotificationBloc>(),
        listener: (context, NotificationState state) async {
          if (state is NotificationLoading) {
            print('loading');
          } else if (state is GetNotificationsLoaded ) {
            getNotificationsLoaded=state;
            sl<AppStateModel>().setNumOfNotificaiotn(getNotificationsLoaded!
                .getNotificationEntity!.notificationModelList.length??0);

          }




          //
        },
        builder: (context, state) {
          if (state is NotificationLoading)
            return WaitingWidget();
          if (state is NotificationError)
            return ErrorWidgetScreen(
              callBack: () {
                _requestTask();
              },
              message: state.message ?? "",
              height: 250.h,
              width: 250.w,
            );
          return
            getNotificationsLoaded==null?
            Container():
            ListView.separated(

              padding: EdgeInsets.symmetric(vertical: 20.w, ),
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index)=>NotificationCard(
                  notificationModel:  getNotificationsLoaded!.getNotificationEntity!.notificationModelList[index],
                ),
                separatorBuilder:
                    (BuildContext context,int index)=>
                    CommonSizes.vBigSpace ,
                itemCount: getNotificationsLoaded!.getNotificationEntity!.notificationModelList.length);
        }))),





                    )
    )
    ])
    )
    )
         )])
    );
  }

  Future<void> _refresh() async {
    _requestTask();
    _controller.sink.add(SwipeRefreshState.hidden);

  }
 }
