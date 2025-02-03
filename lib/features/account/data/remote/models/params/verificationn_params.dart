import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class VerificationParams extends ParamsModel<VerificationParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/auth/verify_email';

  @override
  Map<String, String> get urlParams => {};

  VerificationParams({VerificationParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class VerificationParamsBody extends BaseBodyModel {
  final String? email;
  final String? token;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token": token,
    };
  }

  VerificationParamsBody({this.email, this.token});
}
