import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class GetRegisterFieldParams extends ParamsModel<GetRegisterFieldParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/general_field';

  @override
  Map<String, String> get urlParams => {};

  GetRegisterFieldParams({GetRegisterFieldParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetRegisterFieldParamsBody extends BaseBodyModel {


  Map<String, dynamic> toJson() {
    return {

    };
  }

  GetRegisterFieldParamsBody(
     );
}
