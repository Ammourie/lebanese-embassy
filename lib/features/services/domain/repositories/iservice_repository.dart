import 'package:dartz/dartz.dart';
import '../../data/remote/models/responses/create_order_service_model.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../entities/create_order_service_entity.dart';
import '../entities/get_service_entity.dart';


abstract class IServiceRepository {
  Future<Either<ErrorEntity, GetServiceEntity>> getService(GetServiceParams model);
  Future<Either<ErrorEntity, CreateOrderServiceEntity>> createOrderService(CreateOrderServiceParams model);

}
