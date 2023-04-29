part of 'image_slider_cubit.dart';

@immutable
abstract class ImageSliderState {}

class ImageSliderInitial extends ImageSliderState {}

class ImageSliderLoadingState extends ImageSliderState {}

class ImageSliderSuccessState extends ImageSliderState {
  final SliderResponse sliderResponse;

  ImageSliderSuccessState(this.sliderResponse);

  @override
  List<Object> get props => [sliderResponse];
}

class ImageSliderErrorState extends ImageSliderState {
  final String error;

  ImageSliderErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
