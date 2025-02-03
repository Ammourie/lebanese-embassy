import 'dart:convert';

import '../responses/family_group_field.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';
import '../responses/get_field_model.dart';
import '../responses/request_group_field.dart';

class UpdateInfoFieldParams extends ParamsModel<UpdateInfoFieldParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'api/client/update';

  @override
  Map<String, String> get urlParams => {};

  UpdateInfoFieldParams({UpdateInfoFieldParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class UpdateInfoFieldParamsBody extends BaseBodyModel {
  RequestGroupField? lst;
  FamilyGroupField? familyGroupField;
  bool withFamily;

bool withProfileImage;
String? profileImage;
  Map<String, dynamic> toJson() {
    List<GroupedField> lst1=[];
if(withProfileImage){
  return {'profile':profileImage};
}else if(withFamily){
  familyGroupField!.info=[];
  for(int i=0;i<familyGroupField!.groups!.length;i++){
    lst1 =familyGroupField!.groupedFields[familyGroupField!.groups[i]]!;
    for(int j=0;j<lst1.length;j++) {
      String val;

      if(lst1[j].type!.compareTo('select')==0){
        List <String>op= lst1[j].options!.toString().split('،')??[];
        print('sss');
        val=op[int.tryParse(lst1[j].values??'')??0];
      }else{
        val=lst1[j].values??'';
      }

      familyGroupField!.info.add(InfoData(field_id:lst1[j].id ,
          name: lst1[j].name,
          value:val,  group:   familyGroupField!.groups[i]??'' ));
    }
  }
  return {
    'family':jsonEncode(familyGroupField),

  };

}else{
  lst!.info=[];
    for(int i=0;i<lst!.groups!.length;i++){
      lst1 =lst!.groupedFields[lst!.groups[i]]!;
      for(int j=0;j<lst1.length;j++) {
        String val;

        if(lst1[j].type!.compareTo('select')==0){
          List <String>op= lst1[j].options!.toString().split('،')??[];
          print('sss');
          val=op[int.tryParse(lst1[j].values??'')??0];
        }else{
          val=lst1[j].values??'';
        }

        lst!.info.add(InfoData(field_id:lst1[j].id ,
            name: lst1[j].name,
            value:val,  group:   lst!.groups[i]??'' ));
      }
    }
    return {
      'fields':jsonEncode(lst),
      'info':jsonEncode(lst!.info)

    };}
  }

  UpdateInfoFieldParamsBody({
      this.lst,
      this.withFamily=false,
      this.familyGroupField,
      this.withProfileImage=false,
      this.profileImage,
}
     );
}
//
// Future<dynamic> post( DynamicFormResponse model,
//     ) async {
//   var response;
//   var responseJson;
//   try {
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//     List<GroupedField> lst=[];
//
//     for(int i=0;i<model.data.groups.length;i++){
//       lst =model.data.groupedFields[model.data.groups[i]]!;
//       for(int j=0;j<lst.length;j++) {
//         String val;
//
//         if(lst[j].type.compareTo('select')==0){
//           List <String>op= lst[j].options!.toString().split('،')??[];
//           print('sss');
//           val=op[int.tryParse(lst[j].values)??0];
//         }else{
//           val=lst[j].values;
//         }
//
//         model.data.info.add(InfoData(field_id:lst[j].id ,
//             name: lst[j].name,
//             value:val,  group:   model.data.groups[i]??'' ));
//       }
//     }
//     Map<String, dynamic> map =
//     {
//       'first_name':'first_name_tetwithFile',
//       'email':'semal@5gai.t',
//       'last_name':'lastFile',
//       'country':'syria',
//       'phone':'1234566',
//       'password':'123456',
//       'password_confirmation':'123456',
//       'name':'neamewwq',
//       'birth':'neamewwq',
//
//     };
//     map.addAll({'fields':jsonEncode( model.data)}
//     );
//     map.addAll({'info':jsonEncode( model.data.info)}
//     );
//     int i=0;
//     List<FilesModelData> filesTosend=[];
//     final List<Map<String, dynamic>> _filesWithMetadata = [];
//     for (var file in _selectedFile! ) {
//
//
//       final bytes = await file.readAsBytes();
//
//       // Convert the bytes to base64
//       String base64String = base64Encode(bytes);
//
//
//       filesTosend.add(FilesModelData(
//           name:file.path.split('/').last ,
//           field_id:'5' ,
//           file: base64String));
//       // _filesWithMetadata.add({
//       //   'file':
//       //   await MultipartFile.fromFile(
//       //             file.path,
//       //             filename: file.path.split('/').last,
//       //
//       //
//       //           ),
//       //   'name': file.path.split('/').last, // Replace with dynamic input
//       //   'field_id': '3', // Replace with dynamic input
//       // });
//     }
//     FilesModelDataList filesModelDataList=new FilesModelDataList(files:filesTosend );
//     map.addAll({'medias':   filesModelDataList.toJson()});
//
//     FormData formData = FormData.fromMap(map);
//     // for (var fileObject in _filesWithMetadata) {
//     //    String name = fileObject['name'];
//     //   String fieldId = fileObject['field_id'].toString();
//     //
//     //   // Add each file as a part of medias[]
//     //   // formData.fields.add(
//     //   //   MapEntry(
//     //   //     'medias[]', // Server-side key for the files and attributes
//     //   //     '{"file":"${file.path}","name":"$name","field_id":"$fieldId"}',
//     //   //   ),
//     //   // );
//     //
//     //   //  formData.files.add(
//     //   //   MapEntry(
//     //   //     'medias[]', // Separate key for the file content
//     //   //     await MultipartFile.fromFile(
//     //   //       file.path,
//     //   //       filename: name,
//     //   //     ),
//     //   //   ),
//     //   // );
//     // }
//
//     final url ='https://api.le.odvertising.com/api/auth/registration';
//     response = await _dio.post(
//       url  ,
//       data: formData,
//       options: Options(
//         headers: headers,
//         responseType: ResponseType.plain,
//       ),
//       // queryParameters: model.urlParams,
//     );
//
//
//     if (response == null) throw Exception();
// //      responseJson = json.decode(response.body.toString());
//     responseJson = _returnResponse(response);
//     print('post response: $responseJson');
//   } on DioError catch (e) {
//     if (e.response == null) throw Exception();
//     // _returnResponse(e.response!);
//   } on Exception catch (e) {
//     throw e;
//   }
//
//   return responseJson;
// }