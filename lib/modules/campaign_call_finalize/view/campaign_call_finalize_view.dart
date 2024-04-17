import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/config/config.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:lms_project/modules/campaign_call_finalize/controller/campaign_call_finalize_controller.dart';
import 'package:lms_project/modules/campaign_call_finalize/widgets/add_contact_dialog.dart';
import 'package:lms_project/utils/ui/api_state_widget.dart';
import 'package:lms_project/utils/ui/appbar/appBar.dart';
import 'package:lms_project/utils/ui/custom_dialog.dart';
import 'package:lms_project/utils/ui/snackbar.dart';
import 'package:lms_project/utils/ui/top_box_child_text.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/appbar/statusbar.dart';
import '../../../utils/ui/custom_text.dart';
import '../../../utils/ui/customer_name_and_number.dart';
import '../../../utils/ui/date_time_widget/date_time_widget.dart';
import '../../../utils/ui/drop_down/custom_drop_down.dart';
import '../../../utils/ui/textfields/large_textfield.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/top_box.dart';

class CampaignCallFinalizeView extends StatelessWidget {
  CampaignCallFinalizeView({Key? key}) : super(key: key);

  final CampaignCallFinalizeController controller =
      Get.put(CampaignCallFinalizeController());

  @override
  Widget build(BuildContext context) {
    setStatusBarIconsColor(context: context);
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(
          CustomDialog(
            title: 'Go back',
            message: 'Are you sure?',
            onConfirm: () {
              Get.back();
              Get.back();
            },
          ),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Obx(
          () => CampaignBottomBar(
            isDisabled: controller.buttonIsDisabled.value,
            onWhatsappTap: () {
              controller.launchWhatsapp();
            },
            onMessageTap: () {
              controller.sendMessage();
            },
            onAddContactTap: () async {
              await Permission.contacts.request();
              if (await Permission.contacts.isGranted) {
                Get.dialog(
                  AddContactDialog(),
                  barrierDismissible: false,
                );
              } else {
                getErrorSnackbar(
                    title: "Permission denied",
                    message:
                        "Please grant permission to access contacts from phone settings");
                await Future.delayed(const Duration(seconds: 1));
                openAppSettings();
              }
            },
            onNextTap: () {
              controller.sendFinalizedCallData();
            },
            buttonTitle:
                controller.view == "task" ? "Update Task" : "Next Call",
            buttonTitleColor: controller.view == "task"
                ? (controller.buttonIsDisabled.value
                    ? Colors.grey.shade300
                    : AppColors().green)
                : (controller.buttonIsDisabled.value
                    ? Colors.grey.shade300
                    : AppColors().secondary),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MyAppBar(
              leadingIcon: const AppBarBackIcon(),
              title: 'Finalize',
              titleColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.secondaryContainer,
              onTap: (context) {
                Get.dialog(
                  CustomDialog(
                    title: 'Go back',
                    message: 'Are you sure?',
                    onConfirm: () {
                      Get.back();
                      Get.back();
                    },
                  ),
                );
              },
              child: controller.view == "task"
                  ? TopBoxChildText(
                      text:
                          controller.campaignCallFinalizeModel.campaignTitle ??
                              "N/A",
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    )
                  : TopBox(
                      onTap: () {
                        controller.pauseCampaign();
                      },
                      child: TopBoxChildText(
                        text: controller
                                .campaignCallFinalizeModel.campaignTitle ??
                            "N/A",
                        textColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
            ),
            Obx(() => APIStateWidget(
                  successWidget: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
                    child: SizedBox(
                      height: 70.h,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.sp,
                            ),
                            _headingText(
                              text: 'Customer Info',
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            _divider(),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomerNameAndNumber(
                              name: controller
                                      .campaignCallFinalizeModel.customerName ??
                                  "N/A",
                              number: controller.campaignCallFinalizeModel
                                      .customerNumber ??
                                  "N/A",
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            _greyDivider(),
                            SizedBox(
                              height: 10.sp,
                            ),
                            _subHeadingText(
                              text: 'Call Outcome',
                              showStar: true,
                            ),
                            SizedBox(
                              height: 3.sp,
                            ),
                            CustomDropDown(
                              items: controller
                                  .dropDownItems.value.callOutcomeDisplayItems,
                              kOnChanged: (value) {
                                controller
                                        .campaignCallFinalizeModel.callOutcome =
                                    controller
                                        .dropDownItems.value.callOutcomeItems
                                        .elementAt(
                                  controller.dropDownItems.value
                                      .callOutcomeDisplayItems
                                      .indexOf(value),
                                );

                                if (value == "Answered") {
                                  controller.finalizedViewDropdownSelection[
                                      "outCome"] = true;
                                  controller.buttonIsDisabled.value = true;
                                } else {
                                  controller.finalizedViewDropdownSelection[
                                          "outCome"] =
                                      controller.finalizedViewDropdownSelection[
                                          "leadStatus"] = false;
                                  controller.buttonIsDisabled.value = false;
                                }
                              },
                            ),
                            SizedBox(
                              height: 7.sp,
                            ),
                            controller.finalizedViewDropdownSelection[
                                        "outCome"] ==
                                    true
                                ? Column(
                                    children: [
                                      _subHeadingText(
                                        text: 'Lead Status',
                                        showStar: true,
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      CustomDropDown(
                                        items: controller.dropDownItems.value
                                            .leadStatusDisplayItems,
                                        kOnChanged: (value) {
                                          controller.campaignCallFinalizeModel
                                                  .leadStatus =
                                              controller.dropDownItems.value
                                                  .leadStatusItems
                                                  .elementAt(
                                            controller.dropDownItems.value
                                                .leadStatusDisplayItems
                                                .indexOf(value),
                                          );
                                          if (value == "Future Prospect") {
                                            controller
                                                    .finalizedViewDropdownSelection[
                                                "leadStatus"] = true;
                                            controller.buttonIsDisabled.value =
                                                true;
                                          } else {
                                            controller
                                                    .finalizedViewDropdownSelection[
                                                "leadStatus"] = false;
                                            controller.buttonIsDisabled.value =
                                                false;
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: 7.sp,
                            ),
                            controller.finalizedViewDropdownSelection[
                                        "leadStatus"] ==
                                    true
                                ? Column(
                                    children: [
                                      _subHeadingText(
                                        text: 'Task Description',
                                        showStar: true,
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      CustomDropDown(
                                        items: controller.dropDownItems.value
                                            .taskDescriptionDisplayItems,
                                        kOnChanged: (value) {
                                          controller.campaignCallFinalizeModel
                                                  .taskDescription =
                                              controller.dropDownItems.value
                                                  .taskDescriptionItems
                                                  .elementAt(
                                            controller.dropDownItems.value
                                                .taskDescriptionDisplayItems
                                                .indexOf(value),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 7.sp,
                                      ),
                                      _subHeadingText(
                                        text: 'Task Date & Time',
                                        showStar: true,
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      DateTimeWidget(
                                        onDateTimePicked: (date, time) {
                                          controller.campaignCallFinalizeModel
                                                  .dateTime =
                                              "${date.year}-${date.month}-${date.day} ${time.hour}:${time.minute}:${time.second}";
                                          controller.buttonIsDisabled.value =
                                              false;
                                        },
                                      ),
                                      SizedBox(
                                        height: 7.sp,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            _subHeadingText(
                              text: 'Notes',
                              showStar: false,
                            ),
                            SizedBox(
                              height: 3.sp,
                            ),
                            LargeTextField(
                              controller: controller.notesController,
                            ),
                            SizedBox(
                              height: controller.keyboardVisible.value
                                  ? controller.getKeyboardHeight(
                                      context,
                                    )
                                  : 60.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  loadingWidget: Expanded(
                    child: Center(
                      child: Lottie.asset(
                        loader,
                        width: 20.h,
                        height: 20.h,
                      ),
                    ),
                  ),
                  generalApiState: controller.campaignState.value,
                ))
          ],
        ),
      ),
    );
  }

  Widget _headingText({required String text, color}) => CustomText(
        text: text,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
      );

  Widget _divider() => SizedBox(
        width: 13.w,
        child: Divider(
          color: AppColors().secondary,
          thickness: 2,
        ),
      );

  Widget _greyDivider() => Divider(
        thickness: .5,
        color: AppColors().lightGrey,
      );

  Widget _subHeadingText({
    required String text,
    required bool showStar,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors().grey,
          ),
          CustomText(
            text: showStar ? '*' : '',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors().red,
          ),
        ],
      );
}
