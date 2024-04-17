import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lms_project/modules/campaigns/view/campaigns_view.dart';
import 'package:lms_project/modules/login/model/login_model.dart';
import 'package:lms_project/modules/login/repository/login_repository.dart';
import 'package:lms_project/modules/onboarding/view/onBoarding_view.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/services/local_storage_service.dart';

import '../../../utils/helpers/check_internet_helper.dart';

class SplashController extends Controller {
  @override
  void onInit() {
    routing();
    super.onInit();
  }

  Future<void> routing() async {
    String? token = await LocalStorageService().getToken();
    if (token == null) {
      Future.delayed(
        const Duration(seconds: 2),
      );
      Get.offAll(() => OnBoardingView());
    } else {
      LoginModel user = await LoginRepository().login(LoginModel(
              username: await LocalStorageService().readString('username'),
              password: await LocalStorageService().readString('password'))) ??
          LoginModel();
      LoginModel.agentName = await LocalStorageService().readString("name");
      LoginModel.email = await LocalStorageService().readString("email");
      LoginModel.agent_image =
          await LocalStorageService().readString("agent_image");

      if (user.token == "-1" || user.token == "-2" || user.token == null) {
        Get.offAll(() => OnBoardingView());
      } else {
        Get.off(() => CampaignsView());
      }
    }
    final InternetConnectionChecker customInstance =
        InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 20),
      checkInterval: const Duration(seconds: 15),
    );
    await checkInternetAccess(customInstance);
    Controller().checkConnection();
  }
}
