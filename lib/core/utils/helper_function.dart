import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../error/app_exceptions.dart';

class HelperFunction {
  static void showToast(String mes) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
        msg: mes,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  returnResponse(Response response) {
    var responseJson =
        response.toString().isEmpty ? null : json.decode(response.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (responseJson == null) {
          throw InvalidInputException(
            message: "error happened",
          );
        }
        return responseJson;
      case 400:
      case 422:
        throw FetchDataException(message: responseJson["message"]);
      case 409:
        throw InvalidInputException(
          message: responseJson["error"]["message"],
          //data: responseJson
        );

      case 401:
      case 403:
        throw FetchDataException(message: responseJson["message"]);
      // UnauthorisedException(data: responseJson);
      case 404:
      case 405:
        // return responseJson;
        throw InvalidInputException(
            message: responseJson["message"], data: responseJson["data"]);
      // throw NotFoundException(data: responseJson);
      case 400:
        throw BadRequestException(data: responseJson);
      case 500:
        throw ServerErrorException(data: responseJson);
      default:
        throw BadRequestException(data: responseJson);
    }
  }

  static String getDateFormated(DateTime dateTime) {
    return Intl.withLocale(
        'en', () => DateFormat('yyyy-MM-dd').format(dateTime));
  }
  static String getMonthTimeReview(String val) {
    DateTime dateTime = getDateFromString(val);
    return Intl.withLocale(
        'en', () => DateFormat('MM/yy').format(dateTime));
  }
  static DateTime getDateFromString(String dateTime) {
    return DateTime.tryParse(dateTime ?? "") ?? DateTime.now();
  }

}
