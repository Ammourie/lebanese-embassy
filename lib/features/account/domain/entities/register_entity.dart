import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/user_model.dart';

class RegisterEntity extends Equatable {
  late UserModel? userModel;

  RegisterEntity({
    required this.userModel,
  });

  @override
  List<Object?> get props => [userModel];
}
