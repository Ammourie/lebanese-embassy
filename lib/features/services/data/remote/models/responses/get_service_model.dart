


import '../../../../../account/data/remote/models/responses/get_field_model.dart';
import '../../../../domain/entities/get_service_entity.dart';

class GetServiceModel {
  bool? success;
  List<ServiceModel>? data;
  String? message;
  Null? errors;

  GetServiceModel({this.success, this.data, this.message, this.errors});

  GetServiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ServiceModel>[];
      json['data'].forEach((v) {
        data!.add(new ServiceModel.fromJson(v));
      });
    }
    message = json['message'];
    errors = json['errors'];
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
  GetServiceEntity toEntity() {
    return GetServiceEntity(serviceModelList: data!);
  }
}

class ServiceModel {
  int? id;
  String? categoryId;
  String? name;
  String? description;
  int? status;
  String? price;
  bool? need_date;
  String? createdAt;
  String? updatedAt;
    List<String>? groups;
    List<SubServiceModel>? subServices;
    Map<String, List<GroupedField>>? groupedFields;

  ServiceModel(
      {this.id,
        this.categoryId,
        this.name,
        this.description,
        this.status,
        this.createdAt,
        this.need_date,
        this.updatedAt,
        this.price,
        this.groups,
        this.subServices,
        this.groupedFields});

  ServiceModel.fromJson(Map<String, dynamic> json) {
 try{
   if(json['id']==6){
     groupedFields ={};
    }
   else{
     if(json['groupedFields']==null){
       groupedFields ={};

     }
     else {
       if (json['groupedFields'].runtimeType == List<dynamic>) {
         groupedFields = {};
       }
       else {
         var groupedFields2 = (json['groupedFields'] as Map<String, dynamic>)
             .map(
               (key, value) =>
               MapEntry(
                 key,
                 (value as List)
                     .map((item) => GroupedField.fromJson(item))
                     .toList(),
               ),
         );
         groupedFields = groupedFields2;
       }
     }
   }
   
    id = json['id'];
   need_date=json['need_date']!=null? json['need_date'].toString().compareTo('0')!=0:false;
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    price = json['price']??'0';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groups = <String>[];

    if (json['groups'] != null) {

      json['groups'].forEach((v) {
        groups!.add(v);
      });
    }  subServices = <SubServiceModel>[];

    if (json['sub_services'] != null) {

      json['sub_services'].forEach((v) {
        subServices!.add(SubServiceModel.fromJson(v));
      });
    }



    // if( json['groupedFields'].runtimeType==Map)
    //   groupedFields=        (json['groupedFields'] as Map<String,  dynamic >).map(
    //       (key, value)
    //
    //       {
    //         return  MapEntry(
    //           key,
    //           List<GroupedField>.from(
    //             (value as List).map((e) => GroupedField.fromJson(e)),
    //           ),
    //         );
    //       }
    // );
 }catch(e){
   print(e);}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.groups != null) {
    //   data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    // }
    // if (this.groupedFields != null) {
    //   data['groupedFields'] =
    //       this.groupedFields!.map((v) => v.toJson()).toList();
    // }
    return data;
  }


}
class SubServiceModel {
  int? id;
  String? serviceId;
  String? name;
  int? status;
  String? price;
  String? createdAt;
  String? updatedAt;

  SubServiceModel(
      {this.id,
        this.serviceId,
        this.name,
        this.status,
        this.price,
        this.createdAt,
        this.updatedAt});

  SubServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    name = json['name'];
    status = json['status'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
