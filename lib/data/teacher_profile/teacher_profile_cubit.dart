import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:skola/network/entity/teacher_profile_model/TeacherProfileModel.dart';

import '../../network/repository/Repository.dart';

part 'teacher_profile_state.dart';

class TeacherProfileCubit extends Cubit<TeacherProfileState> {
  final Repository? repository;

  TeacherProfileCubit({required this.repository})
      : super(TeacherProfileInitial());

  void teacherDetail(String userId) async {
    print("Api call  -=====>");
    emit(TeacherProfileLoadingState());
    TeacherProfileModel? response;
    try {
      print("Api call  -=====>");
      // response = await repository?.TeacherProfile(mobile, app);
      response = await repository?.teacherProfile(userId);
      print("Api response  -=====>");
      emit(TeacherProfileSuccessState(response!));
      // print(response.error);
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(TeacherProfileErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(TeacherProfileErrorState(error: map['message']));
          } catch (e) {
            emit(TeacherProfileErrorState(error: "Internal server error"));
          }
        } else {
          emit(TeacherProfileErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
