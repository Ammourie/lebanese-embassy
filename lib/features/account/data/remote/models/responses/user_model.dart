 import 'dart:convert';

import 'family_group_field.dart';
import 'request_group_field.dart';

import 'get_field_model.dart';

class UserModel {
  bool? success;
  UserData? data;
  String? message;
  String? errors;

  UserModel({this.success, this.data, this.message, this.errors});

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
      success = json['success'];
      data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
      message = json['message'];
      errors = json['errors'];
    }
   on Exception catch (e){
print(e);
  }}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
}

class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? phone;
  String? company;
  String? email;
  String? addresses;
  String? gender;
  String? location;
  String? country;
  int? adminVerify;
  int? active;
  String? password;
  String? verifyEmail;
  String? birth;

  List<InfoData>? info;
  RequestGroupField? fields;
  FamilyGroupField? family;
  String? token;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.phone,
        this.company,
        this.email,
        this.addresses,
        this.gender,
        this.location,
        this.country,
        this.adminVerify,
        this.family,
        this.active,
        this.password,
        this.verifyEmail,
        this.birth,
        this.info,
        this.token,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    try{
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    phone = json['phone'];
    company = json['company'];
    email = json['email'];
    addresses = json['addresses'];
    gender = json['gender'];
    location = json['location'];
    country = json['country'];
    adminVerify = json['admin_verify'];
    active = json['active'];
    password = json['password'];
    verifyEmail = json['verify_email'];
    birth = json['birth'];
    info = <InfoData>[];

    if (json['info'] != null) {
    //   json['info']=json['info'].runtimeType is String?
    // :json['info'];
if(json['info'].runtimeType == List<dynamic>){
   json['info'].forEach((v) {
    info!.add(new InfoData.fromJson(v));
  });
}
else{
    jsonDecode( json['info']).forEach((v) {
        info!.add(new InfoData.fromJson(v));
      });
    }
    }
    // info = json['info']==null?null:  RequestGroupField.fromJson( json['info']);

    // json['fields']=json['fields'].runtimeType is String?
    // jsonDecode( json['fields'])  :json['fields'];
    // fields = json['fields']==null?null:  RequestGroupField.fromJson( jsonDecode( json['fields']));
    if (json['fields'] != null) {
      //   json['info']=json['info'].runtimeType is String?
      // :json['info'];

      if (json['fields'].runtimeType == String) {
        fields = RequestGroupField.fromJson(jsonDecode(json['fields']));

      }
      else {
        fields = RequestGroupField.fromJson(json['fields']);

      }
    }
    // family = json['family']==null?null:  FamilyGroupField.fromJson(  jsonDecode( json['family']));
    if (json['family'] != null) {
      //   json['info']=json['info'].runtimeType is String?
      // :json['info'];
      if (json['family'].runtimeType == String) {
        family = FamilyGroupField.fromJson(jsonDecode(json['family']));

      }
      else {
        family = FamilyGroupField.fromJson(json['family']);

      }
    }
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];}
        on Exception   catch (e) {

      print(e);
        }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['email'] = this.email;
    data['addresses'] = this.addresses;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['country'] = this.country;
    data['admin_verify'] = this.adminVerify;
    data['active'] = this.active;
    data['password'] = this.password;
    data['verify_email'] = this.verifyEmail;
    data['birth'] = this.birth;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    if (this.family != null) {
      data['family'] = this.family!.toJson();
    }
    if (this.fields != null) {

      data['fields'] = this.fields!.toJson();
    }
     data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
