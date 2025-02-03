import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class GetCategoryParams extends ParamsModel<GetCategoryParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/categories';

  @override
  Map<String, String> get urlParams => {};

  GetCategoryParams({GetCategoryParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetCategoryParamsBody extends BaseBodyModel {
  final String? username;
  final String? password;

  Map<String, dynamic> toJson() {
    return {
      'email': username,
      'password': password,
    };
  }

  GetCategoryParamsBody({
    this.username,
    this.password,
  });
}
