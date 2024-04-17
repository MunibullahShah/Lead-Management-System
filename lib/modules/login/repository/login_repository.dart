import 'dart:convert';

import 'package:lms_project/modules/login/model/login_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';

class LoginRepository {
  Future<LoginModel?> login(LoginModel user) async {
    String loginResponse = await BackendRepository().login(user);
    if (loginResponse == "") {
      return null;
    } else if (loginResponse == '-1') {
      LoginModel model = LoginModel();
      model.token = "-1";
      return model;
    } else if (loginResponse == '-2') {
      LoginModel model = LoginModel();
      model.token = "-2";
      return model;
    } else if (loginResponse == 'location') {
      LoginModel model = LoginModel();
      model.token = "location";
      return model;
    }
    var json = jsonDecode(loginResponse);
    return LoginModel.fromJson(json);
  }
}
