import 'request_group_field.dart';

import '../../../../domain/entities/get_register_field_entity.dart';

class GetRegisterFieldModel  {
  late bool success;
  late RequestGroupField requestGroupField;
  late String message;
  late dynamic errors;
   GetRegisterFieldModel({  required this.success,
     required this.requestGroupField,
     required this.message,
     this.errors,});

  GetRegisterFieldModel.fromJson(Map<String, dynamic> json) {
    try {


      success= json['success'];
      requestGroupField= RequestGroupField.fromJson(json['data']);
     message= json['message'];
     errors= json['errors'];
      // success = json['success'];
      // data = '';
      // json['data'] != null ? new UserModel.fromJson(json['data']) : null;
      // message = json['message'];
      // errors = json['errors'];

    }on Exception catch (e){
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }

   GetRegisterFieldModel fromJson(Map<String, dynamic> json) {
    return GetRegisterFieldModel.fromJson(json);
  }

  @override
  GetRegisterFieldEntity toEntity() {
    return GetRegisterFieldEntity(requestGroupField: requestGroupField!);
  }
}

//
// class DynamicFormResponse {
//   final bool success;
//   final Data data;
//   final String message;
//   final dynamic errors;
//
//   DynamicFormResponse({
//     required this.success,
//     required this.data,
//     required this.message,
//     this.errors,
//   });
//
//   // From JSON
//   factory DynamicFormResponse.fromJson(Map<String, dynamic> json) {
//     return DynamicFormResponse(
//       success: json['success'],
//       data: Data.fromJson(json['data']),
//       message: json['message'],
//       errors: json['errors'],
//     );
//   }
//
//   // To JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'data': data.toJson(),
//       'message': message,
//       'errors': errors,
//     };
//   }
// }
//
