import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/get_register_field_params.dart';
import '../../data/remote/models/params/register_params.dart';
import '../../data/repositories/account_repository.dart';
import '../entities/get_register_field_entity.dart';
import '../entities/register_entity.dart';

class GetRegisterFieldUseCase extends Usecase<GetRegisterFieldEntity, GetRegisterFieldParams> {
  AccountRepository repository;

  GetRegisterFieldUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetRegisterFieldEntity>> call(
      GetRegisterFieldParams params) async {
    return repository.getRegisterField(params);
  }
}
