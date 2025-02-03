import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../../data/repositories/service_repository.dart';
import '../entities/get_service_entity.dart';

class GetServiceUseCase extends Usecase<GetServiceEntity, GetServiceParams> {
  ServiceRepository repository;

  GetServiceUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetServiceEntity>> call(GetServiceParams params) async {
    return repository.getService(params);
  }
}
