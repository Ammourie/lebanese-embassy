import 'package:dartz/dartz.dart';

import '../error/error_entity.dart';

abstract class Usecase<Type, Params> {
  Future<Either<ErrorEntity, Type>> call(Params params);
}
