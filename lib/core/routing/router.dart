import 'dart:io';

import 'package:flutter/material.dart';
import 'route_paths.dart';

import '../../features/account/data/remote/models/responses/get_field_model.dart';
import '../../features/account/presentation/screens/change_password_screen.dart';
import '../../features/account/presentation/screens/complete_profile_screen.dart';
import '../../features/account/presentation/screens/edite_profile_screen.dart';
import '../../features/account/presentation/screens/family_member_screen.dart';
import '../../features/account/presentation/screens/login_screen.dart';
import '../../features/account/presentation/screens/register_login_screen.dart';
import '../../features/account/presentation/screens/register_screen.dart';
import '../../features/account/presentation/screens/verification_code_screen.dart';
import '../../features/account/presentation/screens/who_we_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/navigation/presentation/screens/nav_main_screen.dart';
import '../../features/navigation/presentation/screens/splash_screen.dart';
import '../../features/notification/presentation/screen/notification_screen.dart';
import '../../features/order/presentation/screen/appointment_screen.dart';
import '../../features/order/presentation/screen/order_screen.dart';
import '../../features/services/data/remote/models/params/create_order_service_params.dart';
import '../../features/services/presentation/screen/book_appointment_widget.dart';
import '../../features/services/presentation/screen/book_notification_appointment_widget.dart';
import '../../features/services/presentation/screen/create_service_request.dart';
import '../../features/services/presentation/screen/edite_waiting_for_review_screen.dart';
import '../../features/services/presentation/screen/order_preveiw_service_request.dart';
import '../../features/services/presentation/screen/waiting_for_review_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());

      case RoutePaths.splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case RoutePaths.NavMainScreen:
        return MaterialPageRoute(builder: (_) => NavMainScreen());
      case RoutePaths.RegisterLoginScreen:
        return MaterialPageRoute(builder: (_) => RegisterLoginScreen());
      case RoutePaths.Register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
        case RoutePaths.HomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
       
      case RoutePaths.VerificationCodeScreen:
        return MaterialPageRoute(
            builder: (_) => VerificationCodeScreen(
                  email: settings as String,
                 ));
  case RoutePaths.CreateServiceRequestScreen:
        return MaterialPageRoute(
            builder: (_) => CreateServiceRequestScreen(
                  title: settings as String,
                  categoryId: settings as int,
                 ));

      case RoutePaths.ChangePasswordScreen:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());

     case RoutePaths.OrderScreen:
        return MaterialPageRoute(builder: (_) => OrderScreen());
        case RoutePaths.AppointmentScreen:
        return MaterialPageRoute(builder: (_) => AppointmentScreen());
  case RoutePaths.CompleteProfileScreen:
        return MaterialPageRoute(builder: (_) => CompleteProfileScreen(isEditeProfile: settings as bool,));
  case RoutePaths.EditeProfileScreen:
        return MaterialPageRoute(builder: (_) => EditeProfileScreen(isEditeProfile: settings as bool,));
 case RoutePaths.FamilyScreen:
        return MaterialPageRoute(builder: (_) => FamilyScreen( ));
 case RoutePaths.BookAppointmentScreen:
        return MaterialPageRoute(builder: (_) => BookAppointmentScreen(createOrderServiceParamsBody:
        settings as CreateOrderServiceParamsBody, ));
 case RoutePaths.WaitingForReviewScreen:
        return MaterialPageRoute(builder: (_) => WaitingForReviewScreen(createOrderServiceParamsBody:
        settings as CreateOrderServiceParamsBody,));
 case RoutePaths.NotificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
 case RoutePaths.WhoWeScreen:
        return MaterialPageRoute(builder: (_) => WhoWeScreen());
        case RoutePaths.BookNotificationAppointmentWidget:
        return MaterialPageRoute(builder: (_) => BookNotificationAppointmentWidget(
            orderId:settings as int
        ));
        case RoutePaths.WhoWeScreen:
        return MaterialPageRoute(builder: (_) => EditeWaitingForReviewScreen());
 case RoutePaths.OrderPreveiwServiceRequestScreen:
        return MaterialPageRoute(builder: (_) => OrderPreveiwServiceRequestScreen(
          date: settings as DateTime ,
          id: settings as int  ,
          needDate: settings as bool,
          service_id:  settings as int  ,file: settings as FilesModelDataList  ,
          client_id:  settings as int,info:settings as List<InfoData>,


        ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
