import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/assets_path.dart';
import 'core/widget/custom_svg_picture.dart';
import 'package:overlay_support/overlay_support.dart';
import 'service_locator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/shared_preferences_items.dart';
import 'firebase_options.dart';
import 'core/routing/route_paths.dart';
import 'core/routing/router.dart';
import 'core/state/appstate.dart';
import 'generated/l10n.dart';
import 'l10n/L10n.dart';
import 'l10n/locale_provider.dart';
import 'service_locator.dart' as serviceLocator;
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  print("onBackgroundMessage: $message");
  // int i = int.tryParse(sl<AppStateModel>()
  //     .prefs
  //     .getString(SharedPreferencesKeys.NotificationNumber) ??
  //     "0") ??
  //     0;
  // sl<AppStateModel>().prefs.setString(
  // SharedPreferencesKeys.NotificationNumber, (i + 1).toString());
  // sl<AppStateModel>().increasetotalNotification();

  // setState(() {});
}
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // Color for Android
      statusBarBrightness:
      Brightness.dark // Dark == white status bar -- for IOS.
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await serviceLocator.init(prefs);

  runApp(
      OverlaySupport(
          child:
      MultiProvider(
          providers: [
             ChangeNotifierProvider(
                create: (context) => AppStateModel(prefs),
             ),
            ChangeNotifierProvider(create: (_) => LocaleProvider()),

          ],
          child:


          Phoenix(
    child: MyApp(
prefs
    )
  ),
      )));
}

class MyApp extends StatefulWidget {

  final preferences;
  MyApp(this.preferences);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initFireBase() async {
     await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );


    final _fcm = await FirebaseMessaging.instance.getToken(
        // vapidKey:
        // "BIAhT2_aSMAkEB0b4xvkNlqxxhCH9YkvSX4WRgJL896yhHFzqAQl5AE1SVlldBElGge9RpkhwTSpTekb9YIClBU"
    );
    // widget.pref.setString(SharedPreferencesKeys.DeviceToken, _fcm.toString());

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
      print("onBackgroundMessage: $message");
      // int i = int.tryParse(sl<AppStateModel>()
      //     .prefs
      //     .getString(SharedPreferencesKeys.NotificationNumber) ??
      //     "0") ??
      //     0;
      showOverlayNotification((context) {
        return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                onTap: () {
                  // if (message.data['prescription_id'] != null) {
                  //   String code = languageCode = (widget.pref
                  //       .containsKey(SharedPreferencesKeys.LanguageCode)
                  //       ? widget.pref
                  //       .getString(SharedPreferencesKeys.LanguageCode)
                  //       : 'ar') ??
                  //       'ar';
                  //   Utils.pushNewScreenWithRouteSettings(context,
                  //       withNavBar: false,
                  //       settings: RouteSettings(
                  //           name: RoutePaths.prescriptionMedicalRecordScreen),
                  //       screen: PrescriptionMedicalRecordScreen(
                  //         isRtl: code.compareTo('ar') == 0 ? false : true,
                  //         id: int.tryParse(
                  //             message.data['prescription_id'].toString()) ??
                  //             0,
                  //       ));
                  // } else {
                  //   int id = 0;
                  //   id = message.data['appointment_id'] == null
                  //       ? 0
                  //       : int.tryParse(
                  //       message.data['appointment_id'].toString() ??
                  //           "0") ??
                  //       0;
                  //   String? appointmentType;
                  //   appointmentType = message.data['appointment_type'] == null
                  //       ? null
                  //       : message.data['appointment_type'];
                  //   if (id != 0 && appointmentType != null) {
                  //     if (appointmentType.compareTo('c') == 0) {
                  //       Utils.pushNewScreenWithRouteSettings(context,
                  //           withNavBar: false,
                  //           settings: RouteSettings(
                  //               name: RoutePaths.myActivityDetialScreen),
                  //           screen: MyActivityDetialScreen(
                  //             id: id ?? 0,
                  //           ));
                  //     } else {
                  //       Utils.pushNewScreenWithRouteSettings(context,
                  //           withNavBar: false,
                  //           settings: RouteSettings(
                  //               name:
                  //               RoutePaths.myActivityHomeCareDetialScreen),
                  //           screen: MyActivityHomeCareDetailScreen(
                  //             id: id,
                  //           ));
                  //     }
                  //   } else {
                  //     Utils.pushNewScreenWithRouteSettings(
                  //         navigatorKey.currentState!.context,
                  //         withNavBar: true,
                  //         settings:
                  //         RouteSettings(name: RoutePaths.navMainScreen),
                  //         screen: NavMainScreen(index: 1));
                  //   }
                  // }
                },
                leading: Container(
                  height: 40.h, width: 40.w,
                  color: Color(0xFF488B89),
                  child: CustomPicture(
                    path: AssetsPath.SVG_Logo,
                    isSVG: true,
                    height: 40.h,
                    width: 40.w,
                  ),
                  // color: Colors.black,
                ),
                title: Text(message.notification != null
                    ? message.notification!.title ?? ""
                    : ""),
                subtitle: Text(message.notification != null
                    ? message.notification!.body ?? ""
                    : ""),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context)!.dismiss();
                    }),
              ),
            ));
      }, duration: Duration(milliseconds: 2000));

      //
      // sl<AppStateModel>().prefs.setString(
      //     SharedPreferencesKeys.NotificationNumber, (i + 1).toString());
      // sl<AppStateModel>().increasetotalNotification();
      // setState(() {});
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      print("onBackgroundMessage: $message");
      // int i = int.tryParse(sl<AppStateModel>()
      //     .prefs
      //     .getString(SharedPreferencesKeys.NotificationNumber) ??
      //     "0") ??
      //     0;
      // if (i != 0) {
      //   sl<AppStateModel>().prefs.setString(
      //       SharedPreferencesKeys.NotificationNumber, (i - 1).toString());
      //   sl<AppStateModel>().setNotification(i);
      //   setState(() {});
      // }
      // sl<AppStateModel>().setNotification(i);
      // setState(() {});
      int id = 0;
      String? appointmentType;
      id = message.data['appointment_id'] == null
          ? 0
          : int.tryParse(message.data['appointment_id'].toString() ?? "0") ?? 0;
      appointmentType = message.data['appointment_type'] == null
          ? null
          : message.data['appointment_type'];

    //   if (message.data['prescription_id'] != null) {
    //     String code = languageCode =
    //         (widget.pref.containsKey(SharedPreferencesKeys.LanguageCode)
    //             ? widget.pref.getString(SharedPreferencesKeys.LanguageCode)
    //             : 'ar') ??
    //             'ar';
    //     Utils.pushNewScreenWithRouteSettings(context,
    //         withNavBar: false,
    //         settings:
    //         RouteSettings(name: RoutePaths.prescriptionMedicalRecordScreen),
    //         screen: PrescriptionMedicalRecordScreen(
    //           isRtl: code.compareTo('ar') == 0 ? false : true,
    //           id: int.tryParse(message.data['prescription_id'].toString()) ?? 0,
    //         ));
    //   } else {
    //     if (id != 0 && appointmentType != null) {
    //       if (appointmentType.compareTo('c') == 0) {
    //         Utils.pushNewScreenWithRouteSettings(context,
    //             withNavBar: false,
    //             settings:
    //             RouteSettings(name: RoutePaths.myActivityDetialScreen),
    //             screen: MyActivityDetialScreen(
    //               id: id ?? 0,
    //             ));
    //       } else {
    //         // Utils.pushNewScreenWithRouteSettings(context,
    //         //     withNavBar: false,
    //         //     settings: RouteSettings(
    //         //         name: RoutePaths.myActivityHomeCareDetialScreen),
    //         //     screen: MyActivityHomeCareDetailScreen(
    //         //       getMyActivityModel: getMyActivityModel,
    //         //     ));
    //       }
    //     } else {
    //       Utils.pushNewScreenWithRouteSettings(
    //           navigatorKey.currentState!.context,
    //           withNavBar: true,
    //           settings: RouteSettings(name: RoutePaths.navMainScreen),
    //           screen: NavMainScreen(index: 1));
    //
    //     }
    //   }
    });
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFireBase();
  }
   // SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context)
        .setLocale('ar', shouldUpdate: false);
    return
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
    builder: (context, child) {

    return

    ScreenUtilInit(
    designSize: Size(430, 932),
    minTextAdapt: true,
    useInheritedMediaQuery: true,
    splitScreenMode: true,
    builder: (BuildContext context, Widget? widget) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title:'Lebanese Embassy',
    initialRoute: RoutePaths.splashPage,
    onGenerateRoute: AppRouter.generateRoute,
    localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    S.delegate,
      CountryLocalizations.delegate,

    ],


    supportedLocales: L10n.all,
    locale: Locale('ar'),

    );
    });
    });
  }
}
