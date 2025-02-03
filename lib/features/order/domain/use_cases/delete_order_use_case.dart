import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/delete_order_params.dart';
import '../../data/remote/models/params/get_order_params.dart';
import '../../data/repositories/order_repository.dart';
import '../entities/delete_order_entity.dart';


class DeleteOrderUseCase extends Usecase<DeleteOrderEntity, DeleteOrderParams> {
  OrderRepository repository;

  DeleteOrderUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, DeleteOrderEntity>> call(DeleteOrderParams params) async {
    return repository.deleteOrder(params);
  }
}
