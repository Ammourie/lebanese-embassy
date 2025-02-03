import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/remote/models/params/register_params.dart';
import '../../data/remote/models/params/update_info_field_params.dart';
import '../../data/remote/models/params/verificationn_params.dart';
import '../../domain/use_cases/verification_use_case.dart';

import '../../../../service_locator.dart';
import '../../data/remote/models/params/get_register_field_params.dart';
import '../../data/remote/models/params/login_params.dart';
import '../../data/repositories/account_repository.dart';
import '../../domain/entities/get_register_field_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/verification_entity.dart';
import '../../domain/use_cases/get_register_field_use_case.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import '../../domain/use_cases/update_info_use_case.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        var res = await LogInUseCase(sl<AccountRepository>())
            .call(event.logInParams!);

        emit(res.fold((l) => AccountError(l.errorMessage), (r) {
          return LogInLoaded(logInEntity: r);
        }));
      } catch (e) {}
    });
    on<RegisterEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        var res = await RegisterUseCase(sl<AccountRepository>())
            .call(event.regsiterParams!);

        emit(res.fold((l) => AccountError(l.errorMessage), (r) {
          return RegisterLoaded(registerEntity: r);
        }));
      } catch (e) {}
    });
    on<GetRegisterFieldEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        var res = await GetRegisterFieldUseCase(sl<AccountRepository>())
            .call(event.getRegisterFieldParams!);

        emit(res.fold((l) => AccountError(l.errorMessage), (r) {
          return GetRegisterFieldLoaded(getRegisterFieldEntity: r);
        }));
      } catch (e) {}
    });
    on<UpdateUpdateInfoFieldEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        var res = await UpdateInfoUseCase(sl<AccountRepository>())
            .call(event.updateInfoFieldParams!);

        emit(res.fold((l) => AccountError(l.errorMessage), (r) {
          return UpdateInfoFieldLoaded(getRegisterFieldEntity: r);
        }));
      } catch (e) {}
    });
    on<VerificationEvent>((event, emit) async {
      emit(AccountLoading());
      try {
        var res = await VerificationUseCase(sl<AccountRepository>())
            .call(event.verificationParams!);

        emit(res.fold((l) => AccountError(l.errorMessage), (r) {
          return VerficationLoaded(verificationEntity: r);
        }));
      } catch (e) {}
    });
  }
}
