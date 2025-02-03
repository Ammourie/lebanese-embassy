import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../notification/presentation/blocs/notification_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../core/assets_path.dart';
import '../../../../core/widget/custom_svg_picture.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../service_locator.dart';
import '../../../account/presentation/screens/account_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../notification/data/remote/models/params/get_notification_params.dart';
import '../../../order/presentation/screen/appointment_screen.dart';
import '../../../order/presentation/screen/order_screen.dart';
import 'about_us_screen.dart';

class NavMainScreen extends StatefulWidget {
  const NavMainScreen({super.key});

  @override
  State<NavMainScreen> createState() => _NavMainScreenState();
}

class _NavMainScreenState extends State<NavMainScreen> {
  late PersistentTabController _controller;
  late bool _showNavBar;
  DateTime? backButtonPressTime;
  static const flutterToastDuration = const Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: sl<NavigationService>().scaffoldKey,
      backgroundColor: Styles.colorBackground,
      resizeToAvoidBottomInset: true,

      body: WillPopScope(
        onWillPop: () async {
          final currentTime = DateTime.now();
          final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
              backButtonPressTime == null ||
                  currentTime.difference(backButtonPressTime!) >
                      flutterToastDuration;
          if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
            backButtonPressTime = currentTime;

            Utils.showToast(S.of(context).pressTwiceToExit);
            return false;
          } else {
            SystemNavigator.pop();

            return true;
          }
        },
        child: PersistentTabView(
          context,
          navBarHeight: 74.h,
          controller: _controller,
popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
          screens: _buildScreens(),

          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardAppears: true,
          navBarStyle: NavBarStyle.simple,
          backgroundColor: Styles.colorBackgroundWhite,
          handleAndroidBackButtonPress: true,
          stateManagement: false,
          isVisible: _showNavBar,
           animationSettings: NavBarAnimationSettings(
              screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: false,
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 300),
          )),

          items: _navBarsItems(),
          padding: EdgeInsets.only(top: 4.h,left: 4.w,right: 4.w),
          bottomScreenMargin: 5,
          margin: EdgeInsets.only(bottom: 8, ),
          // margin: const EdgeInsets.only(top: 10),
          decoration: NavBarDecoration(
              colorBehindNavBar: Styles.colorBackground,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                topLeft: Radius.circular(15.r),
              ),
              boxShadow: [
                BoxShadow(
                  color:Color(0x000000).withOpacity(0.02),
                  spreadRadius: 0,
                  offset: Offset(4, 4),
                  blurRadius: 16,
                ),
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    List<Widget> screens = [];

    screens.add(HomeScreen());
    screens.add(AccountScreen());
    screens.add(AppointmentScreen());
    screens.add(AboutUsScreen());

    return screens;
  }
  startTimer(){
    Timer.periodic(
        Duration(seconds: 30),
            (_) {
              sl<NotificationBloc>().add(GetNotificationsEvent(
                  getNotificationParams: GetNotificationParams(
                      body: GetNotificationParamsBody()
                  )));
          }

        );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final activeColor = Styles.colorActiveText;
    final inactiveColor = Styles.colorinActiveText;


    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        title: 'الرئيسية',

        textStyle: Styles.w400TextStyle().copyWith(
          color:_controller.index==0?Styles.colorActiveText:
          Styles.colorinActiveText,fontSize: 14.sp
        ),
        icon: CustomPicture(
          path: AssetsPath.SVGNAVBarHome,
          height: 30.r,
          width: 30.r,
           color: activeColor,
           isSVG: true,
        ),
        inactiveIcon: CustomPicture(
          path: AssetsPath.SVGNAVBarHome,
          height: 30.r,
          width: 30.r,
          color: inactiveColor,
          isSVG: true,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        title: 'الحساب',

        textStyle: Styles.w400TextStyle().copyWith(
            color:_controller.index==1?Styles.colorActiveText:
            Styles.colorinActiveText,fontSize: 14.sp
        ),
        icon: CustomPicture(
          path: AssetsPath.SVGNAVBarAccount,
          height: 30.r,
          width: 30.r,color: activeColor,
           isSVG: true,

        ),
        inactiveIcon: CustomPicture(
          path: AssetsPath.SVGNAVBarAccount,
          height: 30.r,
          width: 30.r,color: inactiveColor,
           isSVG: true,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        title: 'المواعيد',

        textStyle: Styles.w400TextStyle().copyWith(
            color:_controller.index==2?Styles.colorActiveText:
            Styles.colorinActiveText,fontSize: 14.sp
        ),
        icon: CustomPicture(
          isSVG: true,
          path: AssetsPath.SVGNAVBarAppointment,
          height: 30.r,
          width: 30.r,          color: activeColor,

          // color: Styles.colorIconActive,
        ),
        inactiveIcon: CustomPicture(
          path: AssetsPath.SVGNAVBarAppointment,
          height: 30.r,
          width: 30.r,
           isSVG: true,          color: inactiveColor,

        ),
      ),
      PersistentBottomNavBarItem(
        title: 'عن السفارة',
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        textStyle: Styles.w400TextStyle().copyWith(
            color:_controller.index==0?Styles.colorActiveText:
            Styles.colorinActiveText,fontSize: 14.sp
        ),

        icon: CustomPicture(
          path: AssetsPath.SVGNAVBarAboutEmbassy,
          height: 30.r,
          width: 30.r,
          color: activeColor,
          // color: Styles.colorIconActive,
          isSVG: true,
        ),
        inactiveIcon: CustomPicture(
          path: AssetsPath.SVGNAVBarAboutEmbassy,
          height: 30.r,
          width: 30.r,

          color: inactiveColor,
          isSVG: true,
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    startTimer();
    // _controller = PersistentTabController(
    //   initialIndex: managementNavController.value.index,
    // );
    // _controller.addListener(() {
    //   final _patientsCurrentState = _patientsKey.currentState;
    //   if (_controller.index != 3) {
    //     if (_patientsCurrentState?.searchController.text.isNotEmpty ?? false) {
    //       _patientsCurrentState?.searchController.clear();
    //       _patientsCurrentState?.resetSearch();
    //     }
    //   }
    //   if (_controller.index == 3) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //   }
    //   if (mounted) {
    //     setState(() {
    //       navIndex = _controller.index;
    //     });
    //   }
    // });
    // _controller.addListener(() {
    //   final _appointmentsCurrentState = _appointmentsKey.currentState;
    //   if (_controller.index != 1) {
    //     if (_appointmentsCurrentState?.searchController.text.isNotEmpty ??
    //         false) {
    //       _appointmentsCurrentState?.lastKeyword = '';
    //       _appointmentsCurrentState?.searchController.clear();
    //       _appointmentsCurrentState?.resetFilters();
    //     }
    //   }
    //   if (_controller.index == 1) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     if (sl<AppointmentRepository>().selectedAppointmentFilter.statusId ==
    //             AppointmentStatus.upcoming.index ||
    //         sl<AppointmentRepository>().selectedAppointmentFilter.statusId ==
    //             null) {
    //       _appointmentsCurrentState?.requestAppointments(
    //         sl<AppointmentRepository>().selectedAppointmentFilter,
    //       );
    //     }
    //   }
    //   if (mounted) {
    //     setState(() {
    //       navIndex = _controller.index;
    //     });
    //   }
    // });
    // managementNavController.listen((value) {
    //   if (value.index == _controller.index) {
    //     return;
    //   }
    //   _controller.jumpToTab(value.index);
    // });
    _showNavBar = true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
