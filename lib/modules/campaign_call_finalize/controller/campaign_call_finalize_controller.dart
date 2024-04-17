import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/campaign_call_finalize/models/campaign_call_finalize_model.dart';
import 'package:lms_project/modules/campaign_call_finalize/models/drop_down_items_model.dart';
import 'package:lms_project/modules/campaign_call_finalize/repository/repository.dart';
import 'package:lms_project/modules/campaign_detail/controller/campaign_detail_controller.dart';
import 'package:lms_project/modules/campaign_detail/view/campaign_detail_view.dart';
import 'package:lms_project/modules/campaigns/model/campaigns_model.dart';
import 'package:lms_project/modules/campaigns/view/campaigns_view.dart';
import 'package:lms_project/modules/task_detail/controller/task_detail_controller.dart';
import 'package:lms_project/modules/tasks_home/models/tasks_model.dart';
import 'package:lms_project/modules/tasks_home/view/tasks_view.dart';
import 'package:lms_project/utils/enums/enums.dart';
import 'package:lms_project/utils/helpers/controller.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/network/general_api_state.dart';
import 'package:lms_project/utils/services/local_storage_service.dart';
import 'package:lms_project/utils/ui/loader.dart';
import 'package:lms_project/utils/ui/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CampaignCallFinalizeController extends Controller {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNnameController = TextEditingController();

  RxBool buttonIsDisabled = true.obs;

  Rx<DropDownItems> dropDownItems = DropDownItems().obs;

  late StreamSubscription<bool> keyboardSubscription;

  RxBool keyboardVisible = false.obs;

  late RxMap<String, bool> finalizedViewDropdownSelection;

  late String view;

  Rx<GeneralApiState<CampaignCallFinalizeModel>> campaignState =
      const GeneralApiState<CampaignCallFinalizeModel>(
              apiCallState: APICallState.loading)
          .obs;

  CampaignCallFinalizeModel campaignCallFinalizeModel =
      CampaignCallFinalizeModel();
  TextEditingController notesController = TextEditingController();

  CampaignModel campaignModel = CampaignModel();
  SingleTask task = SingleTask();

  @override
  void onInit() async {
    var keyboardVisibilityController = KeyboardVisibilityController();

    getDropDownValues();

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      keyboardVisible.value = visible;
    });

    finalizedViewDropdownSelection = {
      "outCome": false,
      "leadStatus": false,
      "description": false,
    }.obs;

    view = Get.arguments;
    if (view == "campaign") {
      CampaignDetailController detailController = Get.find();
      campaignModel = detailController.campaignModel;

      campaignCallFinalizeModel.campaignId = detailController.campaignModel.id;
      campaignCallFinalizeModel.campaignTitle =
          detailController.campaignModel.title;
      campaignCallFinalizeModel.campaignDetailId =
          detailController.campaignModel.campaignDetailModel.id;
      campaignCallFinalizeModel.customerName =
          detailController.campaignModel.campaignDetailModel.name;
      campaignCallFinalizeModel.customerNumber =
          detailController.campaignModel.campaignDetailModel.number;
    } else if (view == "task") {
      TaskDetailController tasksController = Get.find();
      task = tasksController.task;
      campaignCallFinalizeModel.campaignDetailId =
          tasksController.task.campaignNoId;
      campaignCallFinalizeModel.taskId = tasksController.task.id;
      campaignCallFinalizeModel.campaignTitle = tasksController.task.title;
      campaignCallFinalizeModel.customerNumber = tasksController.task.number;
      campaignCallFinalizeModel.customerName = tasksController.task.name;
    }
    numberController.text = campaignCallFinalizeModel.customerNumber ?? "N/A";
    super.onInit();
  }

  void sendFinalizedCallData() async {
    if (campaignCallFinalizeModel.callOutcome == null) {
      getErrorSnackbar(
          title: "Error", message: "Please enter the required information");
      return;
    }
    if (campaignCallFinalizeModel.callOutcome ==
            dropDownItems.value.callOutcomeItems.first &&
        campaignCallFinalizeModel.leadStatus == null) {
      getErrorSnackbar(
          title: "Error", message: "Please enter the required information");
      return;
    }
    if (campaignCallFinalizeModel.leadStatus ==
            dropDownItems.value.leadStatusItems.elementAt(1) &&
        campaignCallFinalizeModel.taskDescription == null &&
        campaignCallFinalizeModel.dateTime == null) {
      getErrorSnackbar(
          title: "Error", message: "Please enter the required information");
      return;
    }

    if (campaignCallFinalizeModel.leadStatus ==
            dropDownItems.value.leadStatusItems.elementAt(1) &&
        campaignCallFinalizeModel.taskDescription !=
            dropDownItems.value.taskDescriptionItems.elementAt(1) &&
        campaignCallFinalizeModel.dateTime == null) {
      getErrorSnackbar(
          title: "Error", message: "Please enter the required information");
      return;
    }

    Get.dialog(const Loader(), barrierDismissible: false);
    campaignCallFinalizeModel.notes = notesController.text;
    Map<String, dynamic> data = {};
    data = campaignCallFinalizeModel.campaignToJson();

    try {
      var responseData = await FinalizedCallRepository().postFinalizedCall(
        data: data,
      );
      if (responseData['code'] == 200) {
        Get.offAll(() => view == "task" ? TasksView() : CampaignDetailView(),
            arguments: view == "task" ? null : campaignModel);
      } else if (responseData == "") {
        Get.back();
      }
    } catch (e) {
      finalizedViewDropdownSelection.value = {
        "outCome": false,
        "leadStatus": false,
        "description": false,
      };
      campaignState.value = const GeneralApiState<CampaignCallFinalizeModel>(
          apiCallState: APICallState.loaded);
    }
  }

  Future<void> saveToContact() async {
    Contact contact = Contact(
      givenName: fNameController.text,
      familyName: lNnameController.text,
      phones: [
        Item(
          label: "mobile",
          value: view == "campaign"
              ? campaignModel.campaignDetailModel.number
              : task.number,
        ),
      ],
    );
    var checkContact =
        await ContactsService.getContactsForPhone(numberController.text);
    if (checkContact.isEmpty) {
      await ContactsService.addContact(contact);
      Get.back();
      getSuccessSnackbar(
        title: "",
        message: "Contact has been saved",
      );
    } else {
      getErrorSnackbar(title: "", message: "Number already exists in Contacts");
    }
  }

  void sendMessage() async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: view == 'campaign'
          ? campaignModel.campaignDetailModel.number
          : task.number,
    );
    await launchUrl(launchUri);
  }

  void launchWhatsapp() async {
    String whatsapp = "";
    if (view == "campaign") {
      whatsapp = "+92${campaignModel.campaignDetailModel.number?.substring(1)}";
    } else {
      whatsapp = "+92${task.number?.substring(1)}";
    }

    var whatsappLaunch = Uri.parse("whatsapp://send?phone=$whatsapp");
    if (await canLaunchUrl(whatsappLaunch)) {
      await launchUrl(whatsappLaunch);
    } else {
      getErrorSnackbar(title: "Error", message: "Could not launch whatsapp");
    }
  }

  void pauseCampaign() async {
    String? token = await LocalStorageService().getToken();
    var data = await BackendRepository()
        .pauseCampaign(campaignId: campaignModel.id ?? 0, status: "onhold");
    Get.offAll(() => CampaignsView());
  }

  double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  void getDropDownValues() async {
    try {
      dropDownItems.value = await FinalizedCallRepository().getDropdownValues();

      campaignState.value = const GeneralApiState<CampaignCallFinalizeModel>(
          apiCallState: APICallState.loaded);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
