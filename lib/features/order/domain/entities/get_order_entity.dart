import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/get_order_model.dart';


class GetOrderEntity extends Equatable {
  late List<OrderModel> orderModelList;

  GetOrderEntity({
    required this.orderModelList,
  });

  @override
  List<Object?> get props => [orderModelList];
}
