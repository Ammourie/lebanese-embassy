import 'dart:convert';
import 'dart:io';

import '../../../../../account/data/remote/models/responses/get_field_model.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class GetOrderParams extends ParamsModel<GetOrderParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/client/get_orders';

  @override
  Map<String, String> get urlParams => {};

  GetOrderParams({GetOrderParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetOrderParamsBody extends BaseBodyModel {
GetOrderParamsBody(

    );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    return data ;
  }


}
