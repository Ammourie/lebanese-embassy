import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/get_category_params.dart';
import '../../data/repositories/category_repository.dart';
import '../entities/get_category_entity.dart';

class GetCategoryUseCase extends Usecase<GetCategoryEntity, GetCategoryParams> {
  CategoryRepository repository;

  GetCategoryUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetCategoryEntity>> call(GetCategoryParams params) async {
    return repository.getCategory(params);
  }
}
