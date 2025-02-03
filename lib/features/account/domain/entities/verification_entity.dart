import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/user_model.dart';

class VerificationEntity extends Equatable {
  late UserModel userModel;

  VerificationEntity({
    required this.userModel,
  });

  @override
  List<Object?> get props => [userModel];
}
