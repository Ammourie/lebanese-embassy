import 'package:dartz/dartz.dart';
import '../remote/models/params/create_order_service_params.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../domain/entities/create_order_service_entity.dart';
import '../../domain/entities/get_service_entity.dart';

import '../../domain/repositories/iservice_repository.dart';
import '../remote/data_sources/service_remote_data_source.dart';
import '../remote/models/params/get_service_params.dart';

import '../remote/models/responses/create_order_service_model.dart';
import '../remote/models/responses/get_service_model.dart';


class ServiceRepository  implements IServiceRepository {
  ServiceRemoteDataSource remoteDataSource;

  ServiceRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetServiceEntity>> getService(GetServiceParams model) async {
    try {
      final GetServiceModel remote = await remoteDataSource.getService(model);
      return Right(remote.toEntity());
    } on AppException catch (e) {
      print(e);
      return Left(ErrorEntity.fromException(e));
    } catch (e) {
      print(e);
      return Left(ErrorEntity(e.toString()));
    }
  }
 @override
  Future<Either<ErrorEntity, CreateOrderServiceEntity>> createOrderService(CreateOrderServiceParams  model) async {
    try {
      final CreateOrderServiceModel remote = await remoteDataSource.getcreateOrderService(model);
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
