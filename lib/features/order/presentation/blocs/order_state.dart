part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object?> get props => [];
}

class GetOrdersLoaded extends OrderState {
  final GetOrderEntity? getOrderEntity;

  GetOrdersLoaded({this.getOrderEntity});

  @override
  List<Object> get props => [];
}
class DeleteOrdersLoaded extends OrderState {
  final DeleteOrderEntity? deleteOrderEntity;

  DeleteOrdersLoaded({this.deleteOrderEntity});

  @override
  List<Object> get props => [];
}


class OrderError extends OrderState {
  final String? message;

  OrderError(this.message);

  @override
  List<Object?> get props => [];
}
