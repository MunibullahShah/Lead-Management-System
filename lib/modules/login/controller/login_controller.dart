import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lms_project/config/theme/app_colors.dart';
import 'package:lms_project/modules/campaigns/view/campaigns_view.dart';
import 'package:lms_project/modules/login/model/login_model.dart';
import 'package:lms_project/modules/login/repository/login_repository.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/services/local_storage_service.dart';
import 'package:lms_project/utils/ui/loader.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class LoginController extends Controller {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool obscurePassword = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments == "Invalid Token") {
      getErrorSnackbar(
          title: "login Error", message: "Your session has expired");
    }
    super.onInit();
  }

  void hidePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login({
    required BuildContext context,
  }) async {
    try {
      LoginModel user = LoginModel(
          username: emailController.text.trim(),
          password: passwordController.text);
      await user.getDeviceModel();
      if (user.username!.isEmpty) {
        getErrorSnackbar(title: "login Error", message: "fill the email field");
        return;
      } else if (user.password!.isEmpty) {
        getErrorSnackbar(
            title: "login Error", message: "fill the password field");
        return;
      }

      Get.dialog(const Loader(), barrierDismissible: false);
      user = await LoginRepository().login(user) ?? LoginModel();
      if (user.token != null) {
        if (user.token == "-1") {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Something went wrong. Please try again later",
              ),
              backgroundColor: AppColors().red,
            ),
          );
        } else if (user.token == "-2") {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Server error. Please try again later",
              ),
              backgroundColor: AppColors().red,
            ),
          );
        } else if (user.token == "location") {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Please enable your device location",
              ),
              backgroundColor: AppColors().red,
            ),
          );

          await Future.delayed(Duration(seconds: 1),
              () async => await Geolocator.openLocationSettings());
        } else {
          await LocalStorageService().setToken(user.token ?? "");
          await LocalStorageService()
              .setString("name", LoginModel.agentName ?? "");
          await LocalStorageService()
              .setString("email", LoginModel.email ?? "");
          await LocalStorageService()
              .setString("agent_image", LoginModel.agent_image ?? "");
          await LocalStorageService()
              .setString("username", emailController.text.trim() ?? "");
          await LocalStorageService()
              .setString("password", passwordController.text);

          Get.offAll(() => CampaignsView());
        }
      } else {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "invalid credentials",
          ),
          backgroundColor: AppColors().red,
        ));
      }
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Unable to Login, Check Credentials or contact with admin",
        ),
        backgroundColor: AppColors().red,
      ));
    }
  }
}
