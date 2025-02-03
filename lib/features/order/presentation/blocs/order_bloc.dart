import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../services/domain/entities/get_service_entity.dart';

import '../../../../service_locator.dart';
import '../../data/remote/models/params/delete_order_params.dart';
import '../../data/remote/models/params/get_order_params.dart';
import '../../data/repositories/order_repository.dart';
import '../../domain/entities/delete_order_entity.dart';
import '../../domain/entities/get_order_entity.dart';
import '../../domain/use_cases/delete_order_use_case.dart';
import '../../domain/use_cases/get_order_use_case.dart';


part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        var res = await GetOrderUseCase(sl<OrderRepository>())
            .call(event.getOrderParams!);

        emit(res.fold((l) => OrderError(l.errorMessage), (r) {
          return GetOrdersLoaded(getOrderEntity: r);
        }));
      } catch (e) {}
    });
    on<DeleteOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        var res = await DeleteOrderUseCase(sl<OrderRepository>())
            .call(event.deleteOrderParams!);

        emit(res.fold((l) => OrderError(l.errorMessage), (r) {
          return DeleteOrdersLoaded(deleteOrderEntity: r);
        }));
      } catch (e) {}
    });

    }
}
