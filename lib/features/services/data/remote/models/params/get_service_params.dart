import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class GetServiceParams extends ParamsModel<GetServiceParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/services';

  @override
  Map<String, String> get urlParams => {};

  GetServiceParams({GetServiceParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetServiceParamsBody extends BaseBodyModel {
GetServiceParamsBody({this.categoryId});
int? categoryId;
  Map<String, dynamic> toJson() {
    return {
'category_id':categoryId
    };
  }


}
