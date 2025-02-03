part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();
}

class GetServicesEvent extends ServiceEvent {
  final GetServiceParams? getServiceParams;

  GetServicesEvent({this.getServiceParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class CreateOrderServicesEvent extends ServiceEvent {
  final CreateOrderServiceParams? createOrderServiceParams;

  CreateOrderServicesEvent({this.createOrderServiceParams});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

