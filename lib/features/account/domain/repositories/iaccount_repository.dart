import 'package:dartz/dartz.dart';
import '../entities/verification_entity.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/remote/models/params/get_register_field_params.dart';
import '../../data/remote/models/params/login_params.dart';
import '../../data/remote/models/params/register_params.dart';
import '../../data/remote/models/params/update_info_field_params.dart';
import '../../data/remote/models/params/verificationn_params.dart';
import '../entities/get_register_field_entity.dart';
import '../entities/login_entity.dart';
import '../entities/register_entity.dart';

abstract class IAccountRepository {
  Future<Either<ErrorEntity, LogInEntity>> logIn(LogInParams model);
  Future<Either<ErrorEntity, RegisterEntity>> updateInfo(UpdateInfoFieldParams model);
  Future<Either<ErrorEntity, RegisterEntity>> register(RegisterParams model);
  Future<Either<ErrorEntity, VerificationEntity>> verification(
      VerificationParams model);
  Future<Either<ErrorEntity, GetRegisterFieldEntity>> getRegisterField(
      GetRegisterFieldParams model);
}
