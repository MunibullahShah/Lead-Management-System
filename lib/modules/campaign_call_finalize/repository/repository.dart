import 'dart:convert';

import 'package:lms_project/modules/campaign_call_finalize/models/drop_down_items_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/snackbar.dart';

class FinalizedCallRepository {
  dynamic postFinalizedCall({required Map<String, dynamic> data}) async {
    String callPostResponse = await BackendRepository().postFinalizedCall(
      data: data,
    );
    if (callPostResponse == "") {
      getErrorSnackbar(
          title: "Error", message: "Couldn't send the finalized call");
      return "";
    }
    getSuccessSnackbar(title: "Success", message: "Success");
    await Future.delayed(const Duration(seconds: 1));
    return jsonDecode(callPostResponse);
  }

  Future<DropDownItems> getDropdownValues() async {
    List<String> status = ["call_status", "lead_status", "task_description"];

    DropDownItems dropDownItems = DropDownItems();
    for (var element in status) {
      String statusResponse = await BackendRepository().getDropdownStatus(
        status: element,
      );
      var data = jsonDecode(statusResponse);
      dropDownItems.fromJson(data, element);
    }
    return dropDownItems;
  }
}
