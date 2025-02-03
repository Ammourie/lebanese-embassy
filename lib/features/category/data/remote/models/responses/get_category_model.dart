



import '../../../../domain/entities/get_category_entity.dart';

class GetCategoryModel {
  bool? success;
  List<CategoryModel>? data;
  String? message;
  Null? errors;

  GetCategoryModel({this.success, this.data, this.message, this.errors});

  GetCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryModel.fromJson(v));
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
  GetCategoryEntity toEntity() {
    return GetCategoryEntity(categoryModelList: data!);
  }
}





class CategoryModel {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? image;

  CategoryModel(
      {this.id,
         this.name,
         this.status,
        this.createdAt,
        this.updatedAt,
   });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    // if (json['groups'] != null) {
    //   groups = <Null>[];
    //   json['groups'].forEach((v) {
    //     groups!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['groupedFields'] != null) {
    //   groupedFields = <Null>[];
    //   json['groupedFields'].forEach((v) {
    //     groupedFields!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
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
