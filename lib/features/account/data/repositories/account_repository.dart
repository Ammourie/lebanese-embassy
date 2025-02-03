import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../domain/entities/get_register_field_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/entities/verification_entity.dart';
import '../../domain/repositories/iaccount_repository.dart';
import '../remote/data_sources/account_remote_data_source.dart';
import '../remote/models/params/get_register_field_params.dart';
import '../remote/models/params/login_params.dart';
import '../remote/models/params/register_params.dart';
import '../remote/models/params/update_info_field_params.dart';
import '../remote/models/params/verificationn_params.dart';
import '../remote/models/responses/get_register_field_model.dart';
import '../remote/models/responses/login_model.dart';
import '../remote/models/responses/register_model.dart';
import '../remote/models/responses/verification_model.dart';

class AccountRepository implements IAccountRepository {
  AccountRemoteDataSource remoteDataSource;

  AccountRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, LogInEntity>> logIn(LogInParams model) async {
    try {
      final LogInModel remote = await remoteDataSource.logIn(model);
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
  Future<Either<ErrorEntity, RegisterEntity>> register(
      RegisterParams model) async {
    try {
      final RegisterModel remote = await remoteDataSource.register(model);
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
  Future<Either<ErrorEntity, RegisterEntity>> updateInfo(
      UpdateInfoFieldParams model) async {
    try {
      final RegisterModel remote = await remoteDataSource.updateInfo(model);
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
  Future<Either<ErrorEntity, GetRegisterFieldEntity>> getRegisterField(
      GetRegisterFieldParams model) async {
    try {
      final GetRegisterFieldModel remote = await remoteDataSource.getRegisterField(model);
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
  Future<Either<ErrorEntity, VerificationEntity>> verification(
      VerificationParams model) async {
    try {
      final VerificationModel remote =
          await remoteDataSource.verficatioCode(model);
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
