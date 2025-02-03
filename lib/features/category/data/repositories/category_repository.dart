import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../domain/entities/get_category_entity.dart';
import '../../domain/repositories/icategory_repository.dart';
import '../remote/data_sources/category_remote_data_source.dart';
import '../remote/models/params/get_category_params.dart';
import '../remote/models/responses/get_category_model.dart';


class CategoryRepository  implements ICategoryRepository {
  CategoryRemoteDataSource remoteDataSource;

  CategoryRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetCategoryEntity>> getCategory(GetCategoryParams model) async {
    try {
      final GetCategoryModel remote = await remoteDataSource.getCategory(model);
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
