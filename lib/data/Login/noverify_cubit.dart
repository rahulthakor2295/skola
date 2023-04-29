import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../network/entity/LoginResponse/LoginResponse.dart';
import '../../network/repository/Repository.dart';

part 'noverify_state.dart';

class NoverifyCubit extends Cubit<NoverifyState> {
  final Repository? repository;

  NoverifyCubit({required this.repository}) : super(NoverifyInitial());

  void Noverify(String mobile, String app) async {
    print("Api call  -=====>");
    emit(NoverifyLoadingState());
    LoginResponse? response;
    try {
      print("Api call  -=====>");
      // response = await repository?.noVerify(mobile, app);
      response = await repository?.noVerify(mobile, app);
      print("Api response  -=====>");
      emit(NoverifySuccessState(response!));
      // print(response.error);
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(NoverifyErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(NoverifyErrorState(error: map['message']));
          } catch (e) {
            emit(NoverifyErrorState(error: "Internal server error"));
          }
        } else {
          emit(NoverifyErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
