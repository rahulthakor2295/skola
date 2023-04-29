part of 'update_leave_status_cubit.dart';

@immutable
abstract class UpdateLeaveStatusState {}

class UpdateLeaveStatusInitial extends UpdateLeaveStatusState {}

class UpdateLeaveStatusLoadingState extends UpdateLeaveStatusState {}

class UpdateLeaveStatusSuccessState extends UpdateLeaveStatusState {
  final UpdateLeaveStatusModel response;

  UpdateLeaveStatusSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class UpdateLeaveStatusErrorState extends UpdateLeaveStatusState {
  final String error;

  UpdateLeaveStatusErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
