part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class LogInEvent extends AccountEvent {
  final LogInParams? logInParams;

  LogInEvent({this.logInParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegisterEvent extends AccountEvent {
  final RegisterParams? regsiterParams;

  RegisterEvent({this.regsiterParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class GetRegisterFieldEvent extends AccountEvent {
  final GetRegisterFieldParams? getRegisterFieldParams;

  GetRegisterFieldEvent({this.getRegisterFieldParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class UpdateUpdateInfoFieldEvent extends AccountEvent {
  final UpdateInfoFieldParams? updateInfoFieldParams;

  UpdateUpdateInfoFieldEvent({this.updateInfoFieldParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VerificationEvent extends AccountEvent {
  final VerificationParams? verificationParams;

  VerificationEvent({this.verificationParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
