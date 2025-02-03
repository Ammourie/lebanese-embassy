
import '../../../../../core/data_sources/remote_data_source.dart';
import '../models/params/get_notification_params.dart';
 import '../models/responses/get_notification_model.dart';



abstract class INotificationRemoteDataSource extends RemoteDataSource {
  Future<GetNotificationModel> getNotification(GetNotificationParams model);

}

class NotificationRemoteDataSource extends INotificationRemoteDataSource {
  NotificationRemoteDataSource();

  @override
  Future<GetNotificationModel> getNotification(GetNotificationParams params) async {
    var res;

    res = await this.post(params, withToken: true);
    return Future.value(GetNotificationModel.fromJson(res));
  }


}
