part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  @override
  List<Object?> get props => [];
}

class GetNotificationsLoaded extends NotificationState {
  final GetNotificationEntity? getNotificationEntity;

  GetNotificationsLoaded({this.getNotificationEntity});

  @override
  List<Object> get props => [];
}


class NotificationError extends NotificationState {
  final String? message;

  NotificationError(this.message);

  @override
  List<Object?> get props => [];
}
