import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/helper_function.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_success_dialog.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../l10n/locale_provider.dart';
import '../../../../service_locator.dart';
import '../../../order/data/remote/models/params/get_order_params.dart';
import '../../../order/presentation/blocs/order_bloc.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import '../blocs/service_bloc.dart';

class BookNotificationAppointmentWidget extends StatefulWidget {
  BookNotificationAppointmentWidget(
      {required this.orderId,

         super.key});
    int orderId;

  @override
  State<BookNotificationAppointmentWidget> createState() => _OrderCardState();
}

class _OrderCardState extends State<BookNotificationAppointmentWidget> {
  bool showAll = false;
  DateTime _selectedDate = DateTime.now();
  List<String> _availableTimes = [];
  OrderBloc _orderBloc = new OrderBloc();
  ServiceBloc _serviceBloc = new ServiceBloc();
  GetOrdersLoaded? getOrdersLoaded;

  _requestTask() async {
    _orderBloc.add(GetOrdersEvent(
        getOrderParams: GetOrderParams(
            body:GetOrderParamsBody(
            ))));
  }
  late CreateOrderServiceParamsBody createOrderServiceParamsBody;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeInterval();
    _requestTask();
  }

  getTimeInterval() {
    DateTime startTime = DateTime(2024, 12, 3, 8, 0); // 8:00 AM
    DateTime endTime = DateTime(2024, 12, 3, 18, 0); // 6:00 PM

    // Generate the intervals
    while (startTime.isBefore(endTime)) {
      _availableTimes.add(
          "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}");
      startTime = startTime.add(Duration(minutes: 30));
    }
  }

  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
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
                             child:


    BlocConsumer<OrderBloc , OrderState>(
    bloc:_orderBloc,
    listener: (context, OrderState state) async {
    if (state is OrderLoading) {
    print('loading');
    } else if (state is GetOrdersLoaded ) {
    getOrdersLoaded=state;
    FilesModelDataList fileMode=new FilesModelDataList(files: []);
    for(int i=0;i< getOrdersLoaded!.getOrderEntity!.orderModelList!.first.files!.length;i++){
      fileMode.files!.add(
          FilesModelData(
              file: getOrdersLoaded!.getOrderEntity!.orderModelList!.first!.files![i].path??'',
              name:getOrdersLoaded!.getOrderEntity!.orderModelList!.first!.files![i].name??'' ,
              field_id:getOrdersLoaded!.getOrderEntity!.orderModelList!.first!.files![i].fieldId.toString()
          )
      );
    }
    createOrderServiceParamsBody=  CreateOrderServiceParamsBody(
      info: getOrdersLoaded!.getOrderEntity!.orderModelList!.first.info,
      id: widget.orderId,
      client_id: sl<AppStateModel>().user!.data!.id ?? 0,
      date:
      // true
      //     ?

      DateTime.tryParse( getOrdersLoaded!.getOrderEntity!.orderModelList!.first!.date??'')
      // :
      // DateTime.now()
      ,
      file:  fileMode ,
      service_id: getOrdersLoaded!.getOrderEntity!.orderModelList!.first.serviceId ?? 0,
    );

      //  _selectedDate=createOrderServiceParamsBody.date!;
      // _selectedTime="${widget.createOrderServiceParamsBody.date!
      //     .hour.toString().padLeft(2, '0')}:${widget.createOrderServiceParamsBody.date
      // !.minute.toString().padLeft(2, '0')}";;
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

                             Column(
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
                                            text: 'حجز موعد',
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

                                SfCalendar(
                                    headerDateFormat: 'MMM,yyy',

                                    minDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    ),
                                    view: CalendarView.month,

                                    firstDayOfWeek:
                                        7, // Set the first day of the week as Sunday
                                    showNavigationArrow: true,
                                    headerStyle: CalendarHeaderStyle(
                                      backgroundColor: Styles.colorBackground,
                                      textAlign: TextAlign.center,
                                      textStyle: Styles.w600TextStyle()
                                          .copyWith(
                                              fontSize: 20.sp,
                                              color:
                                                  Styles.colorTextAccountColor),
                                    ),
                                    cellBorderColor: Styles.colorBackground,
                                    selectionDecoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.transparent, width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                    ),
                                    monthCellBuilder:
                                        (context, MonthCellDetails details) {
                                      if (details.date
                                          .isAtSameMomentAs(_selectedDate)) {
                                        return Container(
                                            decoration:
                                                Styles.coloredRoundedDecoration(
                                              color: Styles.colorPrimary,
                                              borderColor: Styles.colorPrimary,
                                              radius: 50.r,
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                  alignmentGeometry:
                                                      Alignment.center,
                                                  text: details.date.day
                                                      .toString(),
                                                  style: Styles.w400TextStyle()
                                                      .copyWith(
                                                          fontSize: 20.sp,
                                                          color: Styles
                                                              .colorTextWhite)),
                                            ));
                                      }
                                      final isLeadingTrailingDate =
                                          details.visibleDates[10].month !=
                                              details.date.month;

                                      return Container(
                                          child: Center(
                                        child: CustomText(
                                            alignmentGeometry: Alignment.center,
                                            text: details.date.day.toString(),
                                            style: Styles.w400TextStyle()
                                                .copyWith(
                                                    fontSize: 20.sp,
                                                    color: isLeadingTrailingDate
                                                        ? Styles.colorBackground
                                                        : Styles.colorText)),
                                      ));
                                    },
                                    monthViewSettings: MonthViewSettings(
                                      showAgenda: false,

                                      dayFormat: 'dd',
                                      showTrailingAndLeadingDates: false,
                                      numberOfWeeksInView: 5,
                                      monthCellStyle: MonthCellStyle(
                                        todayTextStyle: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onSelectionChanged: (
                                      CalendarSelectionDetails details,
                                    ) {
                                      _selectedDate=details.date!;
setState(() {
  
});

                                    }),
                                CommonSizes.vSmallSpace,
                                CustomText(
                                  text: 'الأوقات المتاحة',
                                  style: Styles.w600TextStyle(),
                                  alignmentGeometry:
                                      Provider.of<LocaleProvider>(context).isRTL
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  textAlign:
                                      Provider.of<LocaleProvider>(context).isRTL
                                          ? TextAlign.right
                                          : TextAlign.left,
                                ),
                                CommonSizes.vSmallestSpace,
                                Expanded(
                                  child: GridView.builder(
                                    shrinkWrap: true,

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3,

                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: _availableTimes.length,
                                    itemBuilder: (context, index) {
                                      final time = _availableTimes[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedTime = time;
                                          });
                                        },
                                        child: Container(
                                          height: 40.w,
                                          width: 100.w,
                                          alignment: Alignment.center,
                                          decoration:
                                              Styles.coloredRoundedDecoration(
                                            radius: 10.r,
                                            color: _selectedTime == time
                                                ? Styles.colorPrimary
                                                : Styles.colorBackground,
                                            borderColor: _selectedTime == time
                                                ? Styles.colorPrimary
                                                : Styles.colorTextAccountColor
                                                    .withOpacity(0.1),
                                          ),
                                          child: CustomText(
                                            text: time,
                                            style: Styles.w500TextStyle()
                                                .copyWith(
                                                    color: _selectedTime == time
                                                        ? Styles.colorTextWhite
                                                        : Styles.colorText,
                                                    fontSize: 14.sp),
                                            alignmentGeometry: Alignment.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32.w),
                                    // child: SingleChildScrollView(
                                    child: BlocConsumer<ServiceBloc,
                                            ServiceState>(
                                        bloc: _serviceBloc,
                                        listener: (context,
                                            ServiceState state) async {
                                          if (state
                                              is CreateServicesRequestLoaded) {
                                            Utils.popNavigate(context,
                                                popsCount: 2);
                                          }
                                          else if(state is ServiceError){
                                            Utils.popNavigate(context,
                                                popsCount: 2);
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is ServiceLoading)
                                            return WaitingWidget();
                                          if (state is ServiceError)
                                            return ErrorWidgetScreen(
                                              callBack: () {
                                                List<String> timeString = [];
                                                timeString =
                                                    _selectedTime!.split(':');

                                                   createOrderServiceParamsBody
                                                    .date = DateTime(
                                                  _selectedDate.year,
                                                  _selectedDate.month,
                                                  _selectedDate.day,
                                                  int.tryParse(
                                                          timeString.first) ??
                                                      0,
                                                  int.tryParse(
                                                          timeString.last) ??
                                                      0,
                                                );
                                                _serviceBloc.add(
                                                    CreateOrderServicesEvent(
                                                        createOrderServiceParams:
                                                            CreateOrderServiceParams(
                                                                body: createOrderServiceParamsBody)));
                                              },
                                              message: state.message ?? "",
                                              height: 200.h,
                                              width: 250.w,
                                            );
                                          return CustomButton(
                                            width: double.infinity,

                                            text: 'تأكيد الحجز',

                                            style:
                                                Styles.w700TextStyle().copyWith(
                                              fontSize: 16.sp,
                                              height: 24 / 16,
                                              color: Styles.colorTextWhite,
                                            ),
                                            raduis: 8.r,
                                            textAlign: TextAlign.center,
                                            color: Styles.colorPrimary,
                                            fillColor: Styles.colorPrimary,
                                            // width: 350.w,
                                            height: 54.h,
                                            alignmentDirectional:
                                                AlignmentDirectional.center,
                                            onPressed: () {
//_selectedTime
                                              if(_selectedTime==null){
                                                HelperFunction.showToast(
                                                    'choose Time slot'
                                                );
                                              }else {
                                                // Set the locale to Arabic
                                                Intl.defaultLocale = 'ar';

                                                // Format the date
                                                String formattedDate = DateFormat(
                                                    'd MMMM y', 'ar').format(
                                                    _selectedDate);
                                                showCustomBookMessageDialog(
                                                    context: context,

                                                    time: _selectedTime ?? '',
                                                    date: formattedDate ?? "",
                                                    callBack: () {
                                                      List<
                                                          String> timeString = [
                                                      ];
                                                      timeString =
                                                          _selectedTime!.split(
                                                              ':');
                                                      createOrderServiceParamsBody
                                                          .date = DateTime(
                                                        _selectedDate.year,
                                                        _selectedDate.month,
                                                        _selectedDate.day,
                                                        int.tryParse(
                                                            timeString.first) ??
                                                            0,
                                                        int.tryParse(
                                                            timeString.last) ??
                                                            0,
                                                      );

                                                       _serviceBloc.add(
                                                          CreateOrderServicesEvent(
                                                              createOrderServiceParams:
                                                              CreateOrderServiceParams(

                                                                  body: createOrderServiceParamsBody)));
                                                    });
                                              }
                                              },
                                          );
                                        })),
                                CommonSizes.vBigSpace,
                              ],
                            );})
    ),
                      )),
                ))));
  }
}
