import 'package:equatable/equatable.dart';
import '../../data/remote/models/responses/get_service_model.dart';


class GetServiceEntity extends Equatable {
  late List<ServiceModel> serviceModelList;

  GetServiceEntity({
    required this.serviceModelList,
  });

  @override
  List<Object?> get props => [serviceModelList];
}
