




import '../../../../domain/entities/get_notification_entity.dart';





class GetNotificationModel {
  bool? success;
  NotificationListModel? data;
  String? message;
  Null? errors;

  GetNotificationModel({this.success, this.data, this.message, this.errors});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new NotificationListModel.fromJson(json['data']) : null;
    message = json['message'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
  @override
  GetNotificationEntity toEntity() {
    return GetNotificationEntity(notificationModelList: data!.data??[]);
  }
}

class NotificationListModel {
  List<NotificationModel>? data;
  int? size;

  NotificationListModel({this.data, this.size});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(new NotificationModel.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class NotificationModel {
  int? id;
  String? clientId;
  String? orderId;
  int? read;
  String? title;
  String? text;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
        this.clientId,
        this.orderId,
        this.read,
        this.title,
        this.text,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    orderId = json['order_id'];
    read = json['read'];
    title = json['title'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['order_id'] = this.orderId;
    data['read'] = this.read;
    data['title'] = this.title;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


