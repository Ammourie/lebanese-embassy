import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/register_params.dart';
import '../../data/repositories/account_repository.dart';
import '../entities/register_entity.dart';

class RegisterUseCase extends Usecase<RegisterEntity, RegisterParams> {
  AccountRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, RegisterEntity>> call(
      RegisterParams params) async {
    return repository.register(params);
  }
}
