


import '../../../../../services/data/remote/models/responses/get_service_model.dart';

import '../../../../../../core/constants.dart';
import '../../../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../../domain/entities/delete_order_entity.dart';
import '../../../../domain/entities/get_order_entity.dart';

class DeleteOrderModel {
  bool? success;
   String? message;

  DeleteOrderModel({this.success,  this.message, });

  DeleteOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    message = json['message'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;

    data['message'] = this.message;
     return data;
  }
  @override
  DeleteOrderEntity toEntity() {
    return DeleteOrderEntity(orderModelList: []);
  }
}


class OrderModel {
  int? id;
  int? userId;
  int? serviceId;
  String? info;
  String? status;
  String? date;
  int? adminId;
  OrderStatus? orderStatus;
   String? createdAt;
  String? updatedAt;
  List<FilesModel>? files;
  ServiceModel? service;

  OrderModel(
      {this.id,
        this.userId,
        this.serviceId,
        this.info,
        this.status,
        this.date,
        this.adminId,
        this.createdAt,
        this.updatedAt,
        this.files,
        this.service});
  getStatus(String? state){
    switch (state){
      case 'قيد المعالجة':
        return OrderStatus.InProcessing;
        case "تم حجز موعد":
        return OrderStatus.Booked;
        case "تمت المعالجة":
        return OrderStatus.Processed;
      case "تم إنهاء الطلب":
        return OrderStatus.Failed;

      default:
        return OrderStatus.InProcessing;
    }

  }
  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    info = json['info'];
    status = json['status'];
    orderStatus=getStatus(status);
    date = json['date'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    files = <FilesModel>[];

    if (json['files'] != null) {
      files = <FilesModel>[];
      json['files'].forEach((v) {
        files!.add(new FilesModel.fromJson(v));
      });
    }
    service =
    json['service'] != null ? new ServiceModel.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['info'] = this.info;
    data['status'] = this.status;
    data['date'] = this.date;
    data['admin_id'] = this.adminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}



class FilesModel {
  int? id;
  String? object;
  int? objectId;
  String? path;
  String? name;
  int? fieldId;
  String? createdAt;
  String? updatedAt;

  FilesModel(
      {this.id,
        this.object,
        this.objectId,
        this.path,
        this.name,
        this.fieldId,
        this.createdAt,
        this.updatedAt});

  FilesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    objectId = json['object_id'];
    path = json['path'];
    name = json['name'];
    fieldId = json['field_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['object_id'] = this.objectId;
    data['path'] = this.path;
    data['name'] = this.name;
    data['field_id'] = this.fieldId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

