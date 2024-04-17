import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lms_project/modules/campaign_detail/model/campaign_detail_model.dart';
import 'package:lms_project/modules/login/model/login_model.dart';
import 'package:lms_project/utils/network/backend_calls.dart';

import '../../constants/endpoints.dart';

class BackendRepository {
  Future<String> fetchCampaigns() async {
    try {
      String response = await BackendCall().getRequest(
        endpoint: campaignsEndpoint,
        body: {},
      );
      return response;
    } catch (e) {
      throw Exception('fetch campaigns error');
    }
  }

  Future<String> fetchCampaignDetail({
    required int id,
  }) async {
    try {
      String response = await BackendCall().getRequest(
        endpoint: campaignDetailEndpoint,
        body: {},
        parameters: "campaign_id=$id",
        includeLocation: true,
      );
      return response;
    } catch (e) {
      throw Exception('fetch campaign detail error');
    }
  }

  Future<String> postFinalizedCall({
    required Map<String, dynamic> data,
  }) async {
    try {
      String response = await BackendCall().postRequest(
        endpoint: finalizedCallEndpoint,
        body: data,
        tokenRequired: true,
      );
      return response;
    } catch (e) {
      return "";
    }
  }

  Future<String> fetchTasks(String stateName) async {
    try {
      String response = await BackendCall().getRequest(
        endpoint: tasksEndpoint,
        body: {},
        parameters: "type=$stateName",
      );

      return response;
    } catch (e) {
      throw Exception("Error fetching tasks");
    }
  }

  Future<Map> pauseCampaign(
      {required int campaignId, required String status}) async {
    try {
      String response = await BackendCall().postRequest(
        endpoint: pauseCampaignEndpoint,
        body: {
          "campaign_id": campaignId,
          "status": status,
        },
        tokenRequired: true,
      );
      return jsonDecode(response);
    } catch (e) {
      throw ("Error pausing Campaign");
    }
  }

  login(LoginModel user) async {
    try {
      String response = await BackendCall().postRequest(
        endpoint: loginEndpoint,
        body: user.toJson(),
        tokenRequired: false,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("Error Login");
      }
      return "";
    }
  }

  getDropdownStatus({required String status}) async {
    try {
      String response = await BackendCall().getRequest(
        endpoint: callStatusEndpoint,
        body: {},
        parameters: "type=$status",
      );
      return response;
    } catch (e) {
      throw ("Error pausing Campaign");
    }
  }

  Future<String> getTimeline({required String campaignNoId}) async {
    try {
      String response = await BackendCall().getRequest(
        endpoint: timelineEndpoint,
        body: {},
        parameters: "campaign_number_id=$campaignNoId",
        includeLocation: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  fetchTasksOfCampaign(String state, int campaignId) async {
    try {
      String response = await BackendCall().getRequest(
        endpoint: tasksEndpoint,
        body: {},
        parameters: "type=$state&campaign_id=$campaignId",
      );

      return response;
    } catch (e) {
      throw Exception("Error fetching tasks");
    }
  }

  Future<String> updateAgentOnCallStatus({required int status}) async {
    try {
      String response = await BackendCall().postRequest(
        endpoint: agentCallStatus,
        callStatus: true,
        body: {
          "oncall_status": "$status",
          "campaign_number_id": campaignDetailId
        },
        tokenRequired: true,
      );
      return response;
    } catch (e) {
      throw Exception("Error updating agent on call status");
    }
  }

  Future<void> agentActiveStatus(String status) async {
    await BackendCall().postRequest(
      endpoint: agentActiveStatusEndpoint,
      body: {"is_online": status},
      tokenRequired: true,
    );
  }
}
