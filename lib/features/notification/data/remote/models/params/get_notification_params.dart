import 'dart:convert';
import 'dart:io';

import '../../../../../account/data/remote/models/responses/get_field_model.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';


class GetNotificationParams extends ParamsModel<GetNotificationParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/client/get_notifications';

  @override
  Map<String, String> get urlParams => {};

  GetNotificationParams({GetNotificationParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetNotificationParamsBody extends BaseBodyModel {
  GetNotificationParamsBody(

      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    return data ;
  }


}
