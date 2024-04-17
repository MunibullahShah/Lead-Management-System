import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/campaign_call_finalize/controller/campaign_call_finalize_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/asset_paths.dart';
import '../../../utils/ui/buttons/primary_button.dart';
import '../../../utils/ui/custom_text.dart';
import '../../../utils/ui/textfields/custom_textfield.dart';

class AddContactDialog extends StatelessWidget {
  AddContactDialog({Key? key}) : super(key: key);

  final CampaignCallFinalizeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 350.sp,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                  vertical: pageVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Save Contact',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    const Spacer(),
                    _subHeadingText(text: 'First Name'),
                    CustomTextField(controller: controller.fNameController),
                    SizedBox(
                      height: 7.sp,
                    ),
                    _subHeadingText(text: 'Last Name'),
                    CustomTextField(controller: controller.lNnameController),
                    SizedBox(
                      height: 7.sp,
                    ),
                    _subHeadingText(text: 'Phone Number'),
                    CustomTextField(controller: controller.numberController),
                    const Spacer(),
                    PrimaryButton(
                      text: 'Save',
                      onTap: () async {
                        await controller.saveToContact();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                dialogExitButtonImage,
                width: 35.sp,
                height: 35.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subHeadingText({
    required String text,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors().grey,
          ),
          CustomText(
            text: '*',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors().red,
          ),
        ],
      );
}
