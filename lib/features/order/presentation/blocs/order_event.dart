part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class GetOrdersEvent extends OrderEvent {
  final GetOrderParams? getOrderParams;

  GetOrdersEvent({this.getOrderParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class DeleteOrdersEvent extends OrderEvent {
  final DeleteOrderParams? deleteOrderParams;

  DeleteOrdersEvent({this.deleteOrderParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

