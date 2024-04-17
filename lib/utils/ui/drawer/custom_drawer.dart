import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/constants/constants.dart';
import 'package:lms_project/modules/campaigns/view/campaigns_view.dart';
import 'package:lms_project/modules/login/model/login_model.dart';
import 'package:lms_project/modules/login/view/login_view.dart';
import 'package:lms_project/modules/social_media_campaign/view/social_media_campaign_view.dart';
import 'package:lms_project/modules/tasks_home/view/tasks_view.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/services/local_storage_service.dart';
import 'package:lms_project/utils/ui/ui.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../../../constants/asset_paths.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 80.w,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 140.sp,
                padding: EdgeInsets.symmetric(
                  horizontal: pageHorizontalPadding,
                  vertical: pageVerticalPadding,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (LoginModel.agent_image == null ||
                            LoginModel.agent_image == "")
                        ? const AssetImage(testBlurImage)
                        : NetworkImage(LoginModel.agent_image ?? "")
                            as ImageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ).blurred(
                blurColor: Colors.black,
              ),
              Positioned(
                left: 10.sp,
                bottom: 10.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipOval(
                      child: (LoginModel.agent_image == null ||
                              LoginModel.agent_image == "")
                          ? Icon(
                              Icons.person,
                              size: 30.sp,
                            )
                          : Image.network(
                              LoginModel.agent_image ?? "",
                              width: 45.sp,
                              height: 45.sp,
                            ),
                    ),
                    CustomText(
                      text: LoginModel.agentName ?? "N/A",
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: LoginModel.email ?? "N/A",
                          fontSize: 10,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.sp,
          ),
          _drawerItem(
            image: drawerCampaignImage,
            context: context,
            text: 'Campaign',
            onTap: () {
              Get.offAll(() => CampaignsView());
            },
          ),
          SizedBox(
            height: 5.sp,
          ),
          _drawerItem(
            image: drawerCampaignImage,
            context: context,
            text: 'Social Media Campaign',
            onTap: () {
              Get.offAll(() => SocialMediaCampainView());
            },
          ),
          SizedBox(
            height: 5.sp,
          ),
          _drawerItem(
            context: context,
            image: drawerTasksImage,
            text: 'Task List',
            onTap: () {
              Get.offAll(() => TasksView());
            },
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.bottomLeft,
            child: CustomText(
              text: "v0.0.15",
              fontSize: 12,
            ),
          ),
          Divider(
            color: Theme.of(context).dividerColor,
            thickness: 3,
            height: 10,
          ),
          _drawerLogoutItem(),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required String image,
    required String text,
    required Function onTap,
    required context,
  }) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 7.h,
        padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              image,
              width: 15.sp,
              height: 15.sp,
            ),
            SizedBox(
              width: 12.w,
            ),
            CustomText(
              text: text,
              fontSize: 12,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerLogoutItem() {
    return InkWell(
      onTap: () async {
        await BackendRepository().agentActiveStatus("0");

        await LocalStorageService().deleteAll();
        Get.offAll(() => LoginView());
      },
      child: Container(
        height: 7.h,
        padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              logoutImage,
              width: 12.sp,
              height: 12.sp,
            ),
            SizedBox(
              width: 12.w,
            ),
            CustomText(
              text: 'Logout',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors().red,
            ),
          ],
        ),
      ),
    );
  }
}
