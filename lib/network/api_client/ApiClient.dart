import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:skola/network/entity/update_leave_status/UpdateLeaveStatusModel.dart';

import '../entity/LoginResponse/LoginResponse.dart';
import '../entity/add_leave_model/AddLeaveResponseModel.dart';
import '../entity/slidermodel/sliderResponse.dart';
import '../entity/student_get_leave_model/StudentGetLeaveModel.dart';
import '../entity/teacher_leave_model/LeaveRequestResponse.dart';
import '../entity/teacher_profile_model/TeacherProfileModel.dart';

part 'ApiClient.g.dart';

@RestApi(baseUrl: 'http://testschool.paperbirdtech.com/api/School/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        contentType: "application/json");
    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          if (response.requestOptions.method == HttpMethod.POST) {
            response.data = jsonDecode(response.data as String);
          }
          return handler.next(response);
        },
      ),
    );

    // 'Content-Type': 'application/json'

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @POST('otp_verification.php')
  @FormUrlEncoded()
  Future<LoginResponse> noVerify(@Field('mobile') mobile, @Field('app') app);

  @POST('get_ad_image.php')
  @FormUrlEncoded()
  Future<SliderResponse> imageSlider(@Field('school_id') schoolId,
      @Field('version') versionId,
      @Field('user_id') userId,
      @Field('app_type') appType,);

  @POST("http://testschool.paperbirdtech.com/api/Teacher/get_leave_request.php")
  @FormUrlEncoded()
  Future<LeaveRequestResponse> getLeaves(@Field("school_id") schoolID,
      @Field("year_id") yearID,
      @Field("leave_status") leaveStatus,
      @Field("role_id") rolID,
      @Field("user_id") userID,);

  @POST("http://testschool.paperbirdtech.com/api/Teacher/get_leave_request.php")
  @FormUrlEncoded()
  Future<StudentGetLeaveModel> getStudentLeaves(@Field("school_id") schoolID,
      @Field("year_id") yearID,
      @Field("leave_status") leaveStatus,
      @Field("role_id") rolID,
      @Field("user_id") userID,);

  @POST("http://testschool.paperbirdtech.com/api/Teacher/add_leave.php")
  @FormUrlEncoded()
  Future<AddLeaveResponseModel> addLeave(@Field("user_id") userId,
      @Field("school_id") schoolId,
      @Field("year_id") yearId,
      @Field("start_date") startDate,
      @Field("end_date") endDate,
      @Field("leave_type") leaveType,
      @Field("leave_note") leaveNote,
      @Field("leave_reason") leaveReason,
      @Field("section") section,
      @Field("role_id") roleId,
      @Field("leave_full_half_day") isFullHalfDay,);

  @POST(
      'http://testschool.paperbirdtech.com/api/Teacher/get_teacher_detail.php')
  @FormUrlEncoded()
  Future<TeacherProfileModel> teacherprofile(@Field('user_id') userId);

  @POST(
      "http://testschool.paperbirdtech.com/api/Teacher/update_leave_status.php")
  @FormUrlEncoded()
  Future<UpdateLeaveStatusModel> updateLeaveStatus(@Field("user_id") userId,
      @Field("leave_id") leaveId,
      @Field("leave_status") leaveStatus,
      @Field("leave_remark") leaveRemark,
      @Field("update_by") updateBy,
      @Field("role_id") roleId);
}
