import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/remote/models/params/get_notification_params.dart';
import '../../data/repositories/notification_repository.dart';
import '../entities/get_notification_entity.dart';



class GetNotificationUseCase extends Usecase<GetNotificationEntity, GetNotificationParams> {
  NotificationRepository repository;

  GetNotificationUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, GetNotificationEntity>> call(GetNotificationParams params) async {
    return repository.getNotification(params);
  }
}
