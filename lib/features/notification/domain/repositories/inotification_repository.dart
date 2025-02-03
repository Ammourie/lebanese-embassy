import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
 import '../../data/remote/models/params/get_notification_params.dart';
 import '../entities/get_notification_entity.dart';



abstract class INotificationRepository {
  Future<Either<ErrorEntity, GetNotificationEntity>> getNotification(GetNotificationParams model);

}
