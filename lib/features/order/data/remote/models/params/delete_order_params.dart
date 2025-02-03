import 'dart:convert';
import 'dart:io';

import '../../../../../account/data/remote/models/responses/get_field_model.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class DeleteOrderParams extends ParamsModel<DeleteOrderParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.DELETE;

  @override
  String? get url => 'api/client/delete_order';

  @override
  Map<String, String> get urlParams => {};

  DeleteOrderParams({DeleteOrderParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class DeleteOrderParamsBody extends BaseBodyModel {
  int? id;
DeleteOrderParamsBody(
  {
    this.id
}
    );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    return {
      "order_id":id
    } ;
  }


}
