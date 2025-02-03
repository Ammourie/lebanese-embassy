import 'package:equatable/equatable.dart';

 import '../../data/remote/models/responses/get_notification_model.dart';


class GetNotificationEntity extends Equatable {
  late List<NotificationModel> notificationModelList;

  GetNotificationEntity({
    required this.notificationModelList,
  });

  @override
  List<Object?> get props => [notificationModelList];
}
