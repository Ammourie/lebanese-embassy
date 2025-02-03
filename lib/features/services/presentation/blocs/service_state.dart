part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();
}

class ServiceInitial extends ServiceState {
  @override
  List<Object> get props => [];
}

class ServiceLoading extends ServiceState {
  @override
  List<Object?> get props => [];
}

class GetServicesLoaded extends ServiceState {
  final GetServiceEntity? getServiceEntity;

  GetServicesLoaded({this.getServiceEntity});

  @override
  List<Object> get props => [];
}
class CreateServicesRequestLoaded extends ServiceState {
  final CreateOrderServiceEntity? getCreateOrderServiceEntity;

  CreateServicesRequestLoaded({this.getCreateOrderServiceEntity});

  @override
  List<Object> get props => [];
}


class ServiceError extends ServiceState {
  final String? message;

  ServiceError(this.message);

  @override
  List<Object?> get props => [];
}
