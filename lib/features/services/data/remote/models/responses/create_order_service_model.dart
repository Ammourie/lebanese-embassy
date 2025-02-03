


import '../../../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../../domain/entities/create_order_service_entity.dart';
import '../../../../domain/entities/get_service_entity.dart';
import 'get_service_model.dart';

class CreateOrderServiceModel {
  bool? success;
  List<ServiceModel>? data;
  String? message;
  Null? errors;

  CreateOrderServiceModel({this.success, this.data, this.message, this.errors});

  CreateOrderServiceModel.fromJson(Map<String, dynamic> json) {
   try{
    success = json['success'];
    if (json['data'] != null) {
      if(json['data'] ==''){

        data=[];
      }else{
      data = <ServiceModel>[];
      json['data'].forEach((v) {
        data!.add(new ServiceModel.fromJson(v));
      });
    }
    }
    message = json['message'];
    errors = json['errors'];
  }
  on Exception catch (e)
    {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
  @override
  CreateOrderServiceEntity toEntity() {
    return CreateOrderServiceEntity(serviceModelList: data!);
  }
}

