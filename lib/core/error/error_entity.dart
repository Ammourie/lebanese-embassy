import 'app_exceptions.dart';

class ErrorEntity {
  String? errorMessage;
  String? data;

  ErrorEntity(this.errorMessage);

  ErrorEntity.fromException(AppException e) {
    errorMessage = e.message;
    if (e.data != null) data = e.data["error"] != null ? e.data["error"] : "";
  }
}
