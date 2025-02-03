import 'user_model.dart';

import '../../../../domain/entities/login_entity.dart';

class LogInModel {
  late UserModel userModel;

  LogInModel({required this.userModel});

  LogInModel.fromJson(Map<String, dynamic> json) {
    userModel = UserModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }

  LogInModel fromJson(Map<String, dynamic> json) {
    return LogInModel.fromJson(json);
  }

  @override
  LogInEntity toEntity() {
    return LogInEntity(userModel: userModel);
  }
}
