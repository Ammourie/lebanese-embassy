import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../domain/entities/delete_order_entity.dart';
import '../../domain/entities/get_order_entity.dart';
import '../../domain/repositories/iorder_repository.dart';
import '../remote/data_sources/order_remote_data_source.dart';
import '../remote/models/params/delete_order_params.dart';
import '../remote/models/params/get_order_params.dart';
import '../remote/models/responses/delete_order_model.dart';
import '../remote/models/responses/get_order_model.dart';

class OrderRepository  implements IOrderRepository {
  OrderRemoteDataSource remoteDataSource;

  OrderRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetOrderEntity>> getOrder(GetOrderParams model) async {
    try {
      final GetOrderModel remote = await remoteDataSource.getOrder(model);
      return Right(remote.toEntity());
    } on AppException catch (e) {
      print(e);
      return Left(ErrorEntity.fromException(e));
    } catch (e) {
      print(e);
      return Left(ErrorEntity(e.toString()));
    }
  }
  Future<Either<ErrorEntity, DeleteOrderEntity>> deleteOrder(DeleteOrderParams model) async {
    try {
      final DeleteOrderModel remote = await remoteDataSource.deleteOrder(model);
      return Right(remote.toEntity());
    } on AppException catch (e) {
      print(e);
      return Left(ErrorEntity.fromException(e));
    } catch (e) {
      print(e);
      return Left(ErrorEntity(e.toString()));
    }
  }

}
