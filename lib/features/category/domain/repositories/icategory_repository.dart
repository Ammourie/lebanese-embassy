import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/remote/models/params/get_category_params.dart';
import '../entities/get_category_entity.dart';


abstract class ICategoryRepository {
  Future<Either<ErrorEntity, GetCategoryEntity>> getCategory(GetCategoryParams model);

}
