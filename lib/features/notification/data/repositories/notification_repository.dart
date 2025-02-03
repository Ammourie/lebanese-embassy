import 'package:dartz/dartz.dart';
import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../domain/entities/get_notification_entity.dart';
import '../../domain/repositories/inotification_repository.dart';
import '../remote/data_sources/notification_remote_data_source.dart';
import '../remote/models/params/get_notification_params.dart';
import '../remote/models/responses/get_notification_model.dart';


class NotificationRepository  implements INotificationRepository {
  NotificationRemoteDataSource remoteDataSource;

  NotificationRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetNotificationEntity>> getNotification(GetNotificationParams model) async {
    try {
      final GetNotificationModel remote = await remoteDataSource.getNotification(model);
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
