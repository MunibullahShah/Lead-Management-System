import 'package:get/get.dart';
import 'package:lms_project/utils/helpers/controller.dart';

class OnBoardingController extends Controller {
  RxDouble pageIndex = 0.0.obs;
  RxString skipText = 'skip'.obs;

  void updatePageIndex({required int position}) {
    if (position == 2) {
      skipText.value = 'Done';
    } else {
      skipText.value = 'skip';
    }
    pageIndex.value = position.toDouble();
  }
}
