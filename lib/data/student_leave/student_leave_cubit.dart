import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:skola/network/entity/student_get_leave_model/StudentGetLeaveModel.dart';

import '../../network/repository/Repository.dart';

part 'student_leave_state.dart';

class StudentLeaveCubit extends Cubit<StudentLeaveState> {
  final Repository repository;

  StudentLeaveCubit({required this.repository}) : super(StudentLeaveInitial());

  void getStudentLeavesCubit(String schoolId, String yearId, String leaveStatus,
      String roleId, String userId) async {
    print("Api call  -=====>");
    emit(StudentLeaveLoadingState());
    StudentGetLeaveModel? leaveResponse;

    try {
      print("Api call  -=====>");
      // response = await repository?.noVerify(mobile, app);
      leaveResponse = await repository.getStudentLeave(
          schoolId, yearId, leaveStatus, roleId, userId);
      print("Api response  -=====>");
      emit(StudentLeaveSuccessState(leaveResponse));
      print("StudentLeaveSuccessState" + leaveResponse.toString());
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(StudentLeaveErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(StudentLeaveErrorState(error: map['message']));
          } catch (e) {
            emit(StudentLeaveErrorState(error: "Internal server error"));
          }
        } else {
          emit(StudentLeaveErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
