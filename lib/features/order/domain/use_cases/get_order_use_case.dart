import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/get_order_params.dart';
import '../../data/repositories/order_repository.dart';
import '../entities/get_order_entity.dart';


class GetOrderUseCase extends Usecase<GetOrderEntity, GetOrderParams> {
  OrderRepository repository;

  GetOrderUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetOrderEntity>> call(GetOrderParams params) async {
    return repository.getOrder(params);
  }
}
