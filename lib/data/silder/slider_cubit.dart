// import 'dart:ui';
//
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/rendering.dart';
// import 'package:meta/meta.dart';
//
// import '../../network/entity/slider_model.dart';
// import '../../network/repository/Repository.dart';
//
// part 'slider_state.dart';
//
// class SliderCubit extends Cubit<SliderState> {
//   final Repository? repository;
//
//   SliderCubit({required this.repository}) : super(SliderInitial());
//
//   Future<Slidermodel?> sliderImage() async {
//     emit(SliderLoadingState());
//     Slidermodel? slider;
//     try {
//       print("Api call  -=====>");
//       slider = (await repository?.sliderImages()) as Slidermodel?;
//       print("Api respose  -=====>");
//       emit(SliderSucsessState(slider!));
//       print("Sucees");
//     } on DioError catch (ex) {
//       print("Api error  -=====> ${ex.error}");
//       if (ex.type == DioErrorType.connectionTimeout) {
//         print("error");
//
//         emit(SliderErrorState(
//             error:
//             "Connection time out. Please check your internet connection."));
//       } else {
//         if (ex.response?.statusCode == 400) {
//           try {
//             Map<String, dynamic> map = ex.response?.data;
//             emit(SliderErrorState(error: map['message']));
//           } catch (e) {
//             emit(SliderErrorState(error: "Internal server error"));
//           }
//         } else {
//           emit(SliderErrorState(error: "Internal server error!"));
//         }
//       }
//     }
//   }
//   }
// }
