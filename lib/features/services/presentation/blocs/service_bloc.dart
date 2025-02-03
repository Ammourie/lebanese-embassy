import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/get_service_entity.dart';

import '../../../../service_locator.dart';
import '../../data/remote/models/params/create_order_service_params.dart';
import '../../data/remote/models/params/get_service_params.dart';
import '../../data/repositories/service_repository.dart';
import '../../domain/entities/create_order_service_entity.dart';
import '../../domain/use_cases/create_order_service_use_case.dart';
import '../../domain/use_cases/get_service_use_case.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<GetServicesEvent>((event, emit) async {
      emit(ServiceLoading());
      try {
        var res = await GetServiceUseCase(sl<ServiceRepository>())
            .call(event.getServiceParams!);

        emit(res.fold((l) => ServiceError(l.errorMessage), (r) {
          return GetServicesLoaded(getServiceEntity: r);
        }));
      } catch (e) {}
    });
    on<CreateOrderServicesEvent>((event, emit) async {
      emit(ServiceLoading());
      try {
        var res = await CreateOrderServiceUseCase(sl<ServiceRepository>())
            .call(event.createOrderServiceParams!);

        emit(res.fold((l) => ServiceError(l.errorMessage), (r) {
          return CreateServicesRequestLoaded(getCreateOrderServiceEntity: r);
        }));
      } catch (e) {}
    });
    }
}
