import 'package:flutter/cupertino.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class RegisterParams extends ParamsModel<RegisterParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/auth/registration';

  @override
  Map<String, String> get urlParams => {};

  RegisterParams({RegisterParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class RegisterParamsBody extends BaseBodyModel {

  //         'first_name':'first_name_tetwithFile',
  // 'email':'semal@5gai.t',
  // 'last_name':'lastFile',
  // 'country':'syria',
  // 'phone':'1234566',
  // 'password':'123456',
  // 'password_confirmation':'123456',
  // 'name':'neamewwq',
  // 'birth':'neamewwq',
  // final String first_name;
  // final String last_name;
  final String phone;
  final String country;
  // final String birth;
  // final String? info;
  final String? email;
  final String? username;
  final String? password;
  // final String? company;
  // final String? location;
  // final String? addresses;
  final String? password_confirmation;

  Map<String, dynamic> toJson() {
    return {
      // "first_name": first_name,
      // "last_name": last_name,
      "phone": phone,
      "country": country,
      // "birth": birth,
      // "info": info,
      "email": email,
      "name": username,
      "password": password,
      // "company": company,
      // "location": location,
      // "addresses": addresses,
      "password_confirmation": password_confirmation,
    };
  }

  RegisterParamsBody(
      {

       required this.phone,
        required  this.email,
        required  this.username,
        required  this.password,
      // this.company,
        required this.country,
      // this.addresses,
      //   required this.birth,
      //   required this.first_name,
      // this.info,
      //   required  this.last_name,
      // this.location,
        required this.password_confirmation});
}
