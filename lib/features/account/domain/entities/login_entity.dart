import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/user_model.dart';

class LogInEntity extends Equatable {
  late UserModel userModel;

  LogInEntity({
    required this.userModel,
  });

  @override
  List<Object?> get props => [userModel];
}
