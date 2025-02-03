import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/remote/models/params/delete_order_params.dart';
import '../../data/remote/models/params/get_order_params.dart';
import '../entities/delete_order_entity.dart';
import '../entities/get_order_entity.dart';



abstract class IOrderRepository {
  Future<Either<ErrorEntity, GetOrderEntity>> getOrder(GetOrderParams model);
  Future<Either<ErrorEntity,DeleteOrderEntity>> deleteOrder(DeleteOrderParams model);

}
