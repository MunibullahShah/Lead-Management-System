import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_project/modules/campaigns/controller/campaigns_controller.dart';
import 'package:lms_project/modules/campaigns/widgets/campaigns_list.dart';
import 'package:lms_project/modules/login/model/login_model.dart';
import 'package:lms_project/utils/network/backend_repository.dart';
import 'package:lms_project/utils/ui/custom_dialog.dart';
import 'package:lms_project/utils/ui/drawer/custom_drawer.dart';
import 'package:lms_project/utils/ui/loader.dart';
import 'package:lms_project/utils/ui/ui.dart';

import '../../../config/config.dart';
import '../../../utils/ui/appbar/statusbar.dart';
import '../../../utils/ui/top_info_box.dart';
import '../widgets/info_box_child.dart';

class CampaignsView extends StatelessWidget {
  CampaignsView({Key? key}) : super(key: key);

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
              title: 'Campaigns',
              titleColor: Theme.of(context).colorScheme.onPrimary,
              leadingIcon: const AppBarMenuIcon(),
              color: Theme.of(context).colorScheme.secondaryContainer,
              onTap: (context) {
                Scaffold.of(context).openDrawer();
              },
              child: TopInfoBox(
                color: AppColors().secondaryLight,
                child: InfoBoxChild(
                  heading: 'Hi, ${LoginModel.agentName ?? "N/A"}',
                  subHeading: 'Let’s start work',
                ),
              ),
            ),
            CampaignsList(),
          ],
        ),
      ),
    );
  }
}
