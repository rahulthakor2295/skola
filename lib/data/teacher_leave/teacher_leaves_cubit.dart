import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skola/network/entity/teacher_leave_model/LeaveRequestResponse.dart';
import '../../network/repository/Repository.dart';

part 'teacher_leaves_state.dart';

class TeacherLeaveCubit extends Cubit<TeacherLeaveState> {
  final Repository? repository;

  TeacherLeaveCubit({required this.repository}) : super(TeacherLeaveInitial());

  void getLeavesCubit(String schoolId, String yearId, String leaveStatus,
      String roleId, String userId) async {
    print("Api call  -=====>");
    emit(TeacherLeaveLoadingState());
    LeaveRequestResponse? leaveResponse;

    try {
      print("Api call  -=====>");
      // response = await repository?.noVerify(mobile, app);
      leaveResponse = await repository?.getLeaves(
          schoolId, yearId, leaveStatus, roleId, String, userId);
      print("Api response  -=====>");
      emit(TeacherLeaveSuccessState(leaveResponse!));
      print("TeacherLeaveSuccessState" + leaveResponse.toString());
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(TeacherLeaveErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(TeacherLeaveErrorState(error: map['message']));
          } catch (e) {
            emit(TeacherLeaveErrorState(error: "Internal server error"));
          }
        } else {
          emit(TeacherLeaveErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
