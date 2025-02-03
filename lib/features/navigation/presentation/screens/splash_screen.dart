import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/widget/waiting_widget.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/shared_preferences_items.dart';
import '../../../../core/utils.dart';
import '../../../../service_locator.dart';
import '../../../account/data/remote/models/responses/user_model.dart';
import '../../../home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  State<StatefulWidget> createState() => _SplashcreenState();
}

class _SplashcreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initfAsync();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool isRtl = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: Scaffold(
            resizeToAvoidBottomInset: true, //new line

            body: Center(child: WaitingWidget()),
          ),
        ));
  }

  _initfAsync() async {
    CallApi();
  }

  goToLogin() async {
    setState(() {
      Utils.popNavigateToFirst(context);
      Utils.pushReplacementNavigateTo(
        context,
        RoutePaths.RegisterLoginScreen,
      );
    });
  }

  Future<void> CallApi() async {
    try {

      UserModel? userModel = null;

    String? userData  =sl<AppStateModel>().prefs
          .getString(SharedPreferencesKeys.USER_Model);
if(userData==null){
  goToLogin();

}else{





  Map<String, dynamic> userMap =
  jsonDecode(userData) as Map<String, dynamic>;
  UserData user = UserData.fromJson(userMap);
  sl<AppStateModel>().setUser(UserModel(success: true,data: user,message: '',errors: '') );

  WidgetsBinding.instance!.addPostFrameCallback((_) {

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
            // mobile: '222222',
            // country_code: '111',
          )));});
  Utils.popNavigateToFirst(context);
  Utils.pushReplacementNavigateTo(
    context,
    RoutePaths.NavMainScreen,
  );
  // goToLogin();
}



    } catch (e) {
      goToLogin();

      print(e.toString());
    }
  }
}
