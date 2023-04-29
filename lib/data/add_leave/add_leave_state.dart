part of 'add_leave_cubit.dart';

@immutable
abstract class AddLeaveState {}

class AddLeaveInitial extends AddLeaveState {}

class AddLeaveLoadingState extends AddLeaveState {}

class AddLeaveSuccessState extends AddLeaveState {
  final AddLeaveResponseModel addLeaveResponseModel;

  AddLeaveSuccessState(this.addLeaveResponseModel);

  @override
  List<Object> get props => [addLeaveResponseModel];
}

class AddLeaveErrorState extends AddLeaveState {
  final String error;

  AddLeaveErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
