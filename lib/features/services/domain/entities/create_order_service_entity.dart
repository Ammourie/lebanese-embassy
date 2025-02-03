import 'package:equatable/equatable.dart';
import '../../data/remote/models/responses/get_service_model.dart';


class CreateOrderServiceEntity extends Equatable {
  late List<ServiceModel> serviceModelList;

  CreateOrderServiceEntity({
    required this.serviceModelList,
  });

  @override
  List<Object?> get props => [serviceModelList];
}
