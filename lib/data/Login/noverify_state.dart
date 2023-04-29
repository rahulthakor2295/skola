part of 'noverify_cubit.dart';

@immutable
abstract class NoverifyState {}

class NoverifyInitial extends NoverifyState {}

class NoverifyLoadingState extends NoverifyState {}

class NoverifySuccessState extends NoverifyState {
  final LoginResponse response;

  NoverifySuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class NoverifyErrorState extends NoverifyState {
  final String error;

  NoverifyErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
