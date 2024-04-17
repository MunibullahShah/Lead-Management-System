import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:http/http.dart';
import 'package:lms_project/modules/login/view/login_view.dart';
import 'package:lms_project/utils/services/local_storage_service.dart';
import 'package:lms_project/utils/services/location_services.dart';

import '../../constants/endpoints.dart';

class BackendCall {
  String get _url => baseUrl;

  Uri _getUri(String endpoint) => Uri.parse('$_url/$endpoint');
  LocationServices locationServices = LocationServices();

  Future<String> postRequest({
    required String endpoint,
    bool? callStatus,
    required Map<String, dynamic> body,
    required bool tokenRequired,
  }) async {
    if (!(await locationServices.getLocation())) {
      return "location";
    }

    body['latitude'] = locationServices.position?.latitude ?? "N/A";
    body['longitude'] = locationServices.position?.longitude ?? "N/A";

    Response? response;
    try {
      String? token = await LocalStorageService().getToken();
      late Uri uri = _getUri(endpoint);

      response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': tokenRequired ? 'Bearer $token' : "",
        },
        body: json.encode(body),
        encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.body;
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        return "-2";
      } else if (response.statusCode == 401 &&
          response.body.contains("Invalid Token")) {
        GetX.Get.off(LoginView(), arguments: "Invalid Token");
        return "";
      } else {
        _postError(
          endpoint: endpoint,
          statusCode: response.statusCode,
          body: response.body,
        );
        return "";
      }
    } catch (ex, stackTrace) {
      String responseStr = 'No Response';
      if (response != null) {
        responseStr = response.body;
      }

      _postError(
        endpoint: endpoint,
        statusCode: response?.statusCode ?? 0,
        body: responseStr,
      );
      if (response?.statusCode == null) {
        return "-1";
      } else {
        return "";
      }
    }
  }

  Future<String> getRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    String? parameters,
    bool includeLocation = false,
  }) async {
    Response? response;
    try {
      if (includeLocation && !(await locationServices.getLocation())) {
        return "location";
      }

      if (includeLocation) {
        parameters =
            "${parameters ?? ""}&latitude=${locationServices.position?.latitude ?? "N/A"}&longitude=${locationServices.position?.longitude ?? "N/A"}";
      }

      String? token = await LocalStorageService().getToken();
      Uri uri;
      if (parameters == null) {
        uri = _getUri(endpoint);
      } else {
        uri = _getUri(endpoint).replace(query: parameters);
      }
      response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.body;
      } else if (response.statusCode == 401 &&
          response.body.contains("Invalid Token")) {
        GetX.Get.off(LoginView(), arguments: "Invalid Token");
        return "";
      } else {
        return "";
      }
    } catch (ex, stackTrace) {
      String responseStr = 'No Response';
      if (response != null) {
        responseStr = response.body;
      }
      _postError(
        endpoint: endpoint,
        statusCode: response?.statusCode ?? 0,
        body: responseStr,
      );
    }
    throw Exception('backend error');
  }

  void _postError(
      {required String endpoint,
      required int statusCode,
      required String body}) {
    debugPrint(
        'Backend error -> \nurl -> $endpoint\nstatus code -> $statusCode\nbody -> $body');
  }
}
