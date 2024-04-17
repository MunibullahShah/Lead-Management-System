import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/campaigns/controller/campaigns_controller.dart';
import 'package:lms_project/modules/campaigns/widgets/campaigns_list.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/appbar/appBar.dart';
import 'package:lms_project/utils/ui/custom_dialog.dart';
import 'package:lms_project/utils/ui/drawer/custom_drawer.dart';
import 'package:lms_project/utils/ui/loader.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/ui/appbar/statusbar.dart';

class SocialMediaCampainView extends StatelessWidget {
  SocialMediaCampainView({Key? key}) : super(key: key);

  final CampaignsController controller = Get.put(CampaignsController());

  @override
  Widget build(BuildContext context) {
    setStatusBarIconsColor(context: context);
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(
          CustomDialog(
            title: 'Exit App',
            message: 'Are you sure?',
            onConfirm: () async {
              Get.dialog(
                Loader(),
                barrierDismissible: false,
              );
              await BackendRepository().agentActiveStatus("0");
              exit(0);
            },
          ),
        );
        return false;
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            MyAppBar(
              title: 'Social Media Campaigns',
              titleColor: Theme.of(context).colorScheme.onPrimary,
              leadingIcon: const AppBarMenuIcon(),
              color: Theme.of(context).colorScheme.secondaryContainer,
              onTap: (context) {
                Scaffold.of(context).openDrawer();
              },
              height: 80.sp,
            ),
            SizedBox(
              height: 10.sp,
            ),
            CampaignsList(),
          ],
        ),
      ),
    );
  }
}
