import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../network/entity/slidermodel/sliderResponse.dart';
import '../../network/repository/Repository.dart';

part 'image_slider_state.dart';

class ImageSliderCubit extends Cubit<ImageSliderState> {
  final Repository? repository;

  ImageSliderCubit({required this.repository}) : super(ImageSliderInitial());

  void imageSlider(
      int schoolId, double versionId, int userId, String appType) async {
    print("Api call  -=====>");
    emit(ImageSliderLoadingState());
    SliderResponse? sliderResponse;
    try {
      print("Api call  -=====>");
      // response = await repository?.ImageSlider(mobile, app);
      sliderResponse =
          await repository?.sliderImage(schoolId, versionId, userId, "android");
      print("Api response  -=====>" + sliderResponse.toString());
      emit(ImageSliderSuccessState(sliderResponse!));
      // print(response.error);
      //
      // final res = json.decode(response as String) as Map<String, dynamic>;
      // print(res);
      // print("Sucees");
    } on DioError catch (ex) {
      print("Api error  -=====> ${ex.error}");
      if (ex.type == DioErrorType.connectTimeout) {
        print("error");

        emit(ImageSliderErrorState(
            error:
                "Connection time out. Please check your internet connection."));
      } else {
        if (ex.response?.statusCode == 400) {
          try {
            Map<String, dynamic> map = ex.response?.data;
            emit(ImageSliderErrorState(error: map['message']));
          } catch (e) {
            emit(ImageSliderErrorState(error: "Internal server error"));
          }
        } else {
          emit(ImageSliderErrorState(error: "Internal server error!"));
        }
      }
    }
  }
}
