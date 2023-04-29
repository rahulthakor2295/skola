import 'package:flutter/src/material/slider.dart';

import '../api_client/ApiClient.dart';
import '../entity/LoginResponse/LoginResponse.dart';
import '../entity/add_leave_model/AddLeaveResponseModel.dart';
import '../entity/slidermodel/sliderResponse.dart';
import '../entity/student_get_leave_model/StudentGetLeaveModel.dart';
import '../entity/teacher_leave_model/LeaveRequestResponse.dart';
import '../entity/teacher_profile_model/TeacherProfileModel.dart';
import '../entity/update_leave_status/UpdateLeaveStatusModel.dart';

class Repository {
  late ApiClient apiClient;

  Repository({required this.apiClient});

  Future<LoginResponse> noVerify(String mobile, String app) =>
      apiClient.noVerify(mobile, app);

  Future<LoginResponse> noVerifySecond(String mobile, String app) =>
      apiClient.noVerify(mobile, app);

  Future<SliderResponse> sliderImage(int schoolId, double versionId, int userId,
      String appType) =>
      apiClient.imageSlider(schoolId, versionId, userId, appType);

  Future<LeaveRequestResponse> getLeaves(String schoolId, String yearId,
      String leaveStatus, String roleId, String, String userId) =>
      apiClient.getLeaves(schoolId, yearId, leaveStatus, roleId, userId);

  Future<AddLeaveResponseModel> addLeave(String userId,
      String schoolId,
      String yearId,
      String startDate,
      String endDate,
      String leaveType,
      String leaveNote,
      String leaveReason,
      String section,
      String roleId,
      String isFullHalfDay) =>
      apiClient.addLeave(
          userId,
          schoolId,
          yearId,
          startDate,
          endDate,
          leaveType,
          leaveNote,
          leaveReason,
          section,
          roleId,
          isFullHalfDay);

  Future<TeacherProfileModel> teacherProfile(String userId) =>
      apiClient.teacherprofile(userId);

  Future<StudentGetLeaveModel> getStudentLeave(String schoolId, String yearId,
      String leaveStatus, String roleId, String userId) =>
      apiClient.getStudentLeaves(schoolId, yearId, leaveStatus, roleId, userId);

// Future<Slidermodel> sliderImages() => apiClient.sliderImages();
  Future<UpdateLeaveStatusModel> updateLeaveStatus(String userId,
      String leaveId, String leaveStatus, String leaveRemark, String updateBy,
      String roleId) =>
      apiClient.updateLeaveStatus(
          userId, leaveId, leaveStatus, leaveRemark, updateBy, roleId);
}
