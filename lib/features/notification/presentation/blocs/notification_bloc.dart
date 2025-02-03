import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../services/domain/entities/get_service_entity.dart';

import '../../../../service_locator.dart';
import '../../data/remote/models/params/get_notification_params.dart';
import '../../data/repositories/notification_repository.dart';
import '../../domain/entities/get_notification_entity.dart';
import '../../domain/use_cases/get_notification_use_case.dart';


part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      emit(NotificationLoading());
      try {
        var res = await GetNotificationUseCase(sl<NotificationRepository>())
            .call(event.getNotificationParams!);

        emit(res.fold((l) => NotificationError(l.errorMessage), (r) {
          return GetNotificationsLoaded(getNotificationEntity: r);
        }));
      } catch (e) {}
    });

    }
}
