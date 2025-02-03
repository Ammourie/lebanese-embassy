import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/get_order_model.dart';


class DeleteOrderEntity extends Equatable {
  late List<OrderModel> orderModelList;

  DeleteOrderEntity({
    required this.orderModelList,
  });

  @override
  List<Object?> get props => [orderModelList];
}
