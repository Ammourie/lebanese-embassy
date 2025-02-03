
import '../../../../../core/data_sources/remote_data_source.dart';
import '../models/params/delete_order_params.dart';
import '../models/params/get_order_params.dart';
import '../models/responses/delete_order_model.dart';
import '../models/responses/get_order_model.dart';



abstract class IOrderRemoteDataSource extends RemoteDataSource {
  Future<GetOrderModel> getOrder(GetOrderParams model);
  Future<DeleteOrderModel> deleteOrder(DeleteOrderParams model);

}

class OrderRemoteDataSource extends IOrderRemoteDataSource {
  OrderRemoteDataSource();

  @override
  Future<GetOrderModel> getOrder(GetOrderParams params) async {
    var res;

    res = await this.post(params, withToken: true);
    return Future.value(GetOrderModel.fromJson(res));
  }  @override
  Future<DeleteOrderModel> deleteOrder(DeleteOrderParams params) async {
    var res;

    res = await this.post(params, withToken: true);
    return Future.value(DeleteOrderModel.fromJson(res));
  }


}
