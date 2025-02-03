part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

class LogInLoaded extends AccountState {
  final LogInEntity? logInEntity;

  LogInLoaded({this.logInEntity});

  @override
  List<Object> get props => [];
}

class RegisterLoaded extends AccountState {
  final RegisterEntity? registerEntity;

  RegisterLoaded({this.registerEntity});

  @override
  List<Object> get props => [];
}
class GetRegisterFieldLoaded extends AccountState {
  final GetRegisterFieldEntity? getRegisterFieldEntity;

  GetRegisterFieldLoaded({this.getRegisterFieldEntity});

  @override
  List<Object> get props => [];
}
class UpdateInfoFieldLoaded extends AccountState {
  final RegisterEntity? getRegisterFieldEntity;

  UpdateInfoFieldLoaded({this.getRegisterFieldEntity});

  @override
  List<Object> get props => [];
}

class VerficationLoaded extends AccountState {
  final VerificationEntity? verificationEntity;

  VerficationLoaded({this.verificationEntity});

  @override
  List<Object> get props => [];
}

class AccountError extends AccountState {
  final String? message;

  AccountError(this.message);

  @override
  List<Object?> get props => [];
}
