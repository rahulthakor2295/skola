import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/repository/Repository.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  Repository? repository;

  OtpCubit({required this.repository}) : super(OtpInitial());

  void otpVerify(String mobile, String app) async {
    LoginResponse? response;
    emit(OtpLoadingState());
    try {
      print("Api call  -=====>");
      // response = await repository?.noVerify(mobile, app);
      response = await repository?.noVerifySecond(mobile, app);

      emit(OtpSuccessState(response!));
      // print(response.error);
      print("Api response  -=====>$response!");

      print("+++++++++++++++++++>>>>>>" + response.toString());
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(OtpErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(OtpErrorState(error: map['message']));
          } catch (e) {
            emit(OtpErrorState(error: "Internal server error"));
          }
        } else {
          emit(OtpErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
