import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/verificationn_params.dart';
import '../../data/repositories/account_repository.dart';
import '../entities/verification_entity.dart';

class VerificationUseCase
    extends Usecase<VerificationEntity, VerificationParams> {
  AccountRepository repository;

  VerificationUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, VerificationEntity>> call(
      VerificationParams params) async {
    return repository.verification(params);
  }
}
