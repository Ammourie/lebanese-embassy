import '../../../../account/data/remote/models/params/verificationn_params.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../models/params/create_order_service_params.dart';
import '../models/params/get_service_params.dart';
import '../models/responses/create_order_service_model.dart';
import '../models/responses/get_service_model.dart';


abstract class IServiceRemoteDataSource extends RemoteDataSource {
  Future<GetServiceModel> getService(GetServiceParams model);
  Future<CreateOrderServiceModel> getcreateOrderService(CreateOrderServiceParams model);

}

class ServiceRemoteDataSource extends IServiceRemoteDataSource {
  ServiceRemoteDataSource();

  @override
  Future<GetServiceModel> getService(GetServiceParams params) async {
    var res;

    res = await this.post(params, withToken: true);
    return Future.value(GetServiceModel.fromJson(res));
  }
  @override
  Future<CreateOrderServiceModel> getcreateOrderService(CreateOrderServiceParams params) async {
    var res;

    res = await this.post(params, withToken: true);
    return Future.value(CreateOrderServiceModel.fromJson(res));
  }

}
