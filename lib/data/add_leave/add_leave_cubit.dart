import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../network/entity/add_leave_model/AddLeaveResponseModel.dart';
import '../../network/repository/Repository.dart';

part 'add_leave_state.dart';

class AddLeaveCubit extends Cubit<AddLeaveState> {
  final Repository? repository;

  AddLeaveCubit({required this.repository}) : super(AddLeaveInitial());

  void addLeaves(
      String userId,
      String schoolId,
      String yearId,
      String startDate,
      String endDate,
      String leaveType,
      String leaveNote,
      String leaveReason,
      String section,
      String roleId,
      String isFullHalfDay) async {
    print("Api call  -=====>");
    emit(AddLeaveLoadingState());
    AddLeaveResponseModel? addLeaveResponseModel;
    try {
      print("Api call  -=====>");
      // response = await repository?.noVerify(mobile, app);
      addLeaveResponseModel = await repository?.addLeave(
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
      print("Api response  -=====>" + addLeaveResponseModel!.toString());
      emit(AddLeaveSuccessState(addLeaveResponseModel));
      // print(response.error);
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(AddLeaveErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(AddLeaveErrorState(error: map['message']));
          } catch (e) {
            emit(AddLeaveErrorState(error: "Internal server error"));
          }
        } else {
          emit(AddLeaveErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
