import '../models/params/get_register_field_params.dart';
import '../models/params/verificationn_params.dart';
import '../models/responses/get_register_field_model.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../models/params/login_params.dart';
import '../models/params/register_params.dart';
import '../models/params/update_info_field_params.dart';
import '../models/responses/login_model.dart';
import '../models/responses/register_model.dart';
import '../models/responses/verification_model.dart';

abstract class IAccountRemoteDataSource extends RemoteDataSource {
  Future<LogInModel> logIn(LogInParams model);
  Future<RegisterModel> register(RegisterParams model);
  Future<RegisterModel> updateInfo(UpdateInfoFieldParams model);
  Future<GetRegisterFieldModel> getRegisterField(GetRegisterFieldParams model);
  Future<VerificationModel> verficatioCode(VerificationParams model);
 }

class AccountRemoteDataSource extends IAccountRemoteDataSource {
  AccountRemoteDataSource();

  @override
  Future<LogInModel> logIn(LogInParams params) async {
    var res;

    res = await this.post(params, withToken: false);
    return Future.value(LogInModel.fromJson(res));
  }

  @override
  Future<RegisterModel> register(RegisterParams params) async {
    var res;

    res = await this.post(params, withToken: false);
    return Future.value(RegisterModel.fromJson(res));
  }

  @override
  Future<RegisterModel> updateInfo(UpdateInfoFieldParams params) async {
    var res;

    res = await this.post(params, withToken: true);
    return Future.value(RegisterModel.fromJson(res));
  }
  @override
  Future<GetRegisterFieldModel > getRegisterField(GetRegisterFieldParams params) async {
    var res;

    res = await this.post(params, withToken: false);
    return Future.value(GetRegisterFieldModel.fromJson(res));
  }

  @override
  Future<VerificationModel> verficatioCode(VerificationParams params) async {
    var res;

    res = await this.post(params, withToken: false);
    return Future.value(VerificationModel.fromJson(res));
  }
}
