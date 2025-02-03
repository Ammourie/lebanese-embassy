import 'package:dartz/dartz.dart';
import '../../data/remote/models/params/update_info_field_params.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/register_params.dart';
import '../../data/repositories/account_repository.dart';
import '../entities/register_entity.dart';

class UpdateInfoUseCase extends Usecase<RegisterEntity, UpdateInfoFieldParams> {
  AccountRepository repository;

  UpdateInfoUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, RegisterEntity>> call(
      UpdateInfoFieldParams params) async {
    return repository.updateInfo(params);
  }
}
