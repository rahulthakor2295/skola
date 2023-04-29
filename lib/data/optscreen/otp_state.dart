part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {
  LoginResponse response;

  OtpSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class OtpErrorState extends OtpState {
  final String error;

  OtpErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
