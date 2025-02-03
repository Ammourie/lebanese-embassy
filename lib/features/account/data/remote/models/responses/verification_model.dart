import 'user_model.dart';

import '../../../../domain/entities/verification_entity.dart';

class VerificationModel {
  late UserModel userModel;

  VerificationModel({required this.userModel});

  VerificationModel.fromJson(Map<String, dynamic> json) {
    userModel = UserModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }

  VerificationModel fromJson(Map<String, dynamic> json) {
    return VerificationModel.fromJson(json);
  }

  @override
  VerificationEntity toEntity() {
    return VerificationEntity(userModel: userModel);
  }
}
