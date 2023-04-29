import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../network/entity/update_leave_status/UpdateLeaveStatusModel.dart';
import '../../network/repository/Repository.dart';

part 'update_leave_status_state.dart';

class UpdateLeaveStatusCubit extends Cubit<UpdateLeaveStatusState> {
  final Repository repository;

  UpdateLeaveStatusCubit({required this.repository})
      : super(UpdateLeaveStatusInitial());

  void updateLeaveStatus(String userId, String leaveId, String leaveStatus,
      String leaveRemark, String updateBy, String roleId) async {
    print("Api call  -=====>");
    emit(UpdateLeaveStatusLoadingState());
    UpdateLeaveStatusModel? updateLeaveStatusRepo;
    try {
      print("Api call  -=====>");
      // response = await repository?.UpdateLeaveStatus(mobile, app);
      updateLeaveStatusRepo = await repository.updateLeaveStatus(
          userId, leaveId, leaveStatus, leaveRemark, updateBy, roleId);
      print("Api response  -=====>");
      emit(UpdateLeaveStatusSuccessState(updateLeaveStatusRepo));
      // print(response.error);
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(UpdateLeaveStatusErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(UpdateLeaveStatusErrorState(error: map['message']));
          } catch (e) {
            emit(UpdateLeaveStatusErrorState(error: "Internal server error"));
          }
        } else {
          emit(UpdateLeaveStatusErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
