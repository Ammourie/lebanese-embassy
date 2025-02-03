import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/account/data/remote/models/responses/user_model.dart';

class AppStateModel with ChangeNotifier {
  UserModel? _user;
  final SharedPreferences prefs;
bool? _shouldUpdateWidget;
  AppStateModel(this.prefs) {
    // _userID = prefs.getString(SharedPreferencesKeys.USER_ID);
  }
  int? _numOfNotifiaction;
int? get  numOfNotifiaction=>_numOfNotifiaction;
  UserModel? get user => _user;
  bool? get shouldUpdateWidget => _shouldUpdateWidget;
String? _nationalty;

  String? get nationalty => _nationalty;
  void    setNationalty (String name){
    _nationalty=name;
  }
  void    decreaseNumOfNotificaiotn (){

    _numOfNotifiaction=(_numOfNotifiaction??0)-1;
    if(_numOfNotifiaction!<0){
      _numOfNotifiaction=0;
    }
    notifyListeners();

  }
   void    setNumOfNotificaiotn (int num){
     _numOfNotifiaction=num;
     notifyListeners();

   }

  void    setshouldUpdateWidget (bool state){
    _shouldUpdateWidget=state;
    notifyListeners();

  }


  void setUser(UserModel? user) {
    _user = user;
  }

  Future<void> saveLogin(String ID, String email, String phone, String name,
      String password) async {
    notifyListeners();
  }

  Future<void> logOut() async {
    prefs.clear();
    notifyListeners();
  }
}
