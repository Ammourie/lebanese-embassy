import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/login_params.dart';
import '../../data/repositories/account_repository.dart';
import '../entities/login_entity.dart';

class LogInUseCase extends Usecase<LogInEntity, LogInParams> {
  AccountRepository repository;

  LogInUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, LogInEntity>> call(LogInParams params) async {
    return repository.logIn(params);
  }
}
