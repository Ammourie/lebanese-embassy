import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../../data/repositories/service_repository.dart';
import '../entities/create_order_service_entity.dart';
import '../entities/get_service_entity.dart';

class CreateOrderServiceUseCase extends Usecase<CreateOrderServiceEntity,CreateOrderServiceParams> {
  ServiceRepository repository;

  CreateOrderServiceUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, CreateOrderServiceEntity>> call(CreateOrderServiceParams params) async {
    return repository.createOrderService(params);
  }
}
