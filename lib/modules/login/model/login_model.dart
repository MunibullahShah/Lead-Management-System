import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:lms_project/constants/app_constants.dart';

class LoginModel {
  String? username;
  String? password;
  String deviceModel = "";
  int? agentSeatId;
  int? companyId;
  static String? agentName;
  static String? email;
  static String? agent_image;
  String? token;

  LoginModel({this.username, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    agentSeatId = json['agent_seat_id'];
    companyId = json['company_id'];
    agentName = json['agent_data']['name'];
    email = json['agent_data']['email'];
    agent_image = json['agent_data']['image_url'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['fcm_token'] = fcmToken;
    data['os_type'] = Platform.isIOS ? "ios" : "android";
    data['model_name'] = deviceModel;
    return data;
  }

  Future<void> getDeviceModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceModel = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
      deviceModel = iosInfo.utsname.machine ?? "";
    }
  }
}
