import 'dart:convert';

class DynamicFormResponse {
  final bool success;
  final Data data;
  final String message;
  final dynamic errors;

  DynamicFormResponse({
    required this.success,
    required this.data,
    required this.message,
    this.errors,
  });

  // From JSON
  factory DynamicFormResponse.fromJson(Map<String, dynamic> json) {
    return DynamicFormResponse(
      success: json['success'],
      data: Data.fromJson(json['data']),
      message: json['message'],
      errors: json['errors'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
      'errors': errors,
    };
  }
}
class InfoData{
  String?  name;
  String? value;
  String? group;
  int? field_id;

  InfoData({this.name,this.value,this.field_id,this.group});
  factory InfoData.fromJson(Map<String, dynamic> json) {
    return InfoData(
      name:  json['name'],
      value:  json['value'],
      group:  json['group'],
      field_id:  json['field_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'group': group,
      'name':  name,
      'value':  value,
      'field_id':  field_id,
     };
  }
}
class Data {
  final List<String> groups;
  final Map<String, List<GroupedField>> groupedFields;
  final List<InfoData> info;

  Data({
    required this.groups,
    required this.groupedFields,
    required this.info,
  });

  // From JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      groups: List<String>.from(json['groups']),
      groupedFields: (json['groupedFields'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          key,
          List<GroupedField>.from(
            (value as List).map((e) => GroupedField.fromJson(e)),
          ),
        ),

      ), info: json['info']==null?[]:  List<InfoData>.from(json['info']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'groups': groups,
      'info': info,
      'groupedFields': groupedFields.map(
            (key, value) => MapEntry(
          key,
          value.map((e) => e.toJson()).toList(),
        ),
      ),
    };
  }
}

class GroupedField {
  late int id;
  late String? country;
  late String? description;
  late String? name;
  late String? group;
  late String? type;
  late String? options;
  late String? group_sort;
  late String? field_sort;
  late String? icon;

  late List<String>? optionsList;
  late int required;
  late int status;
  late String? createdAt;
  late String? updatedAt;
  late String? values;

  GroupedField({
    required this.id,
    required this.country,
    required this.description,
    required this.name,
    required this.group,
    required this.icon,
    required this.field_sort,
    required this.group_sort,
    required this.type,
    required this.optionsList,
    this.options,
    required this.required,
    required this.status,
    required this.values,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
    GroupedField.fromJson(Map<String, dynamic> json) {
    try{
      id= json['id'];
      country= json['country'];
      description= json['description'];
      name= json['name'];
      group= json['group'];
      group_sort= json['group_sort'];
      field_sort= json['field_sort'];
      icon= json['icon'];

      type= json['type'];
      options= json['options'];

      if(json['options']!=null){
        json['options']=
        json['options'].toString().contains(',')?json['options']:json['options'].toString()+'،';
      }

      options= json['options'];
      optionsList= json['options']!=null?json['options'].toString().split('،'):[];

      required= json['required'];
      status= json['status'];
      values= json['values']==null?'':json['values'];
      createdAt= json['created_at'];
      updatedAt= json['updated_at'];
   }
    on Exception catch(e){
      print(e);
    }
    }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'description': description,
      'name': name,
      'group': group,
      'type': type,
      'options': options,
      'required': required,
      'status': status,
      'created_at': createdAt,
      'values': values,
      'updated_at': updatedAt,
    };

  //   {


  //   "type": "text",
  //   "options": null,
  //   "required": 1,
  //   "status": 1,
  //   "created_at": "2024-11-24T15:08:17.000000Z",
  //   "updated_at": "2024-11-24T15:08:17.000000Z"
  // },
  }
}
