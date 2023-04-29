// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiClient implements ApiClient {
  _ApiClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://testschool.paperbirdtech.com/api/School/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponse> noVerify(
    mobile,
    app,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'mobile': mobile,
      'app': app,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'otp_verification.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SliderResponse> imageSlider(
    schoolId,
    versionId,
    userId,
    appType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'school_id': schoolId,
      'version': versionId,
      'user_id': userId,
      'app_type': appType,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SliderResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'get_ad_image.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SliderResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LeaveRequestResponse> getLeaves(
    schoolID,
    yearID,
    leaveStatus,
    rolID,
    userID,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'school_id': schoolID,
      'year_id': yearID,
      'leave_status': leaveStatus,
      'role_id': rolID,
      'user_id': userID,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LeaveRequestResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'http://testschool.paperbirdtech.com/api/Teacher/get_leave_request.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LeaveRequestResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StudentGetLeaveModel> getStudentLeaves(
    schoolID,
    yearID,
    leaveStatus,
    rolID,
    userID,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'school_id': schoolID,
      'year_id': yearID,
      'leave_status': leaveStatus,
      'role_id': rolID,
      'user_id': userID,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StudentGetLeaveModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'http://testschool.paperbirdtech.com/api/Teacher/get_leave_request.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StudentGetLeaveModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddLeaveResponseModel> addLeave(
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
    isFullHalfDay,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'user_id': userId,
      'school_id': schoolId,
      'year_id': yearId,
      'start_date': startDate,
      'end_date': endDate,
      'leave_type': leaveType,
      'leave_note': leaveNote,
      'leave_reason': leaveReason,
      'section': section,
      'role_id': roleId,
      'leave_full_half_day': isFullHalfDay,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddLeaveResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'http://testschool.paperbirdtech.com/api/Teacher/add_leave.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddLeaveResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TeacherProfileModel> teacherprofile(userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'user_id': userId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TeacherProfileModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'http://testschool.paperbirdtech.com/api/Teacher/get_teacher_detail.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TeacherProfileModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateLeaveStatusModel> updateLeaveStatus(
    userId,
    leaveId,
    leaveStatus,
    leaveRemark,
    updateBy,
    roleId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'user_id': userId,
      'leave_id': leaveId,
      'leave_status': leaveStatus,
      'leave_remark': leaveRemark,
      'update_by': updateBy,
      'role_id': roleId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateLeaveStatusModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'http://testschool.paperbirdtech.com/api/Teacher/update_leave_status.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateLeaveStatusModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
