import 'user_model.dart';

import '../../../../domain/entities/register_entity.dart';

class RegisterModel {
  late UserModel userModel;

  RegisterModel({ required this.userModel });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    try {
      userModel = UserModel.fromJson(json);

    }on Exception catch (e){
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }

  RegisterModel fromJson(Map<String, dynamic> json) {
    return RegisterModel.fromJson(json);}

  @override
  RegisterEntity toEntity() {
    return RegisterEntity(userModel: userModel!);
  }
}