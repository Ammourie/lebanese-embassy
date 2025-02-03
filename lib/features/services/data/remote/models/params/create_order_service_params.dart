import 'dart:convert';
import 'dart:io';

import '../../../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../../../../service_locator.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';
import '../../../../../../core/shared_preferences_items.dart';
import '../../../../../../core/state/appstate.dart';
import '../../../../../account/data/remote/models/responses/family_group_field.dart';

class CreateOrderServiceParams extends ParamsModel<CreateOrderServiceParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/client/new_order';

  @override
  Map<String, String> get urlParams => {};

  CreateOrderServiceParams({CreateOrderServiceParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class CreateOrderServiceParamsBody extends BaseBodyModel {
CreateOrderServiceParamsBody({this.id,this.service_id,this.info,this.date,
  required
  this.file,

  this.client_id});
int? service_id;
int? client_id;
int? id;

DateTime? date;
 List<InfoData>? info;
FilesModelDataList file;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.info != null) {
      data['info'] = jsonEncode(info).toString();
    }
    data['service_id']=service_id;

    data['client_id']=client_id;
    data['medias']=  file.toJson();
    // data['file']=file;
    if(date!=null)data['date']=date;
    data['order_id']=id;
    return data ;
  }

// * @bodyParam  service_id string
// * @bodyParam  client_id string
// * @bodyParam  date date
// * @bodyParam  info json
// * @bodyParam  files json
}

class FilesModelData {
  String? file;
  String? name;
  String? field_id;

  FilesModelData(
      {this.file,
        this.name,
        this.field_id,
      });

  FilesModelData.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    name = json['name'];
    field_id = json['field_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field_id'] = this.field_id;
    data['name'] = this.name;
    data['file'] = this.file;

    return data;
  }
}

class FilesModelDataList {
  List<FilesModelData>?  files;

  FilesModelDataList(
      {this.files,

      });

  FilesModelDataList.fromJson(Map<String, dynamic> json) {
    files = json['medias'];


  }
  toJson() {
    return
      files!.map((item) => item.toJson()).toList();
  }}