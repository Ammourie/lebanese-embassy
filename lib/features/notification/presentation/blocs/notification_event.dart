part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetNotificationsEvent extends NotificationEvent {
  final GetNotificationParams? getNotificationParams;

  GetNotificationsEvent({this.getNotificationParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

