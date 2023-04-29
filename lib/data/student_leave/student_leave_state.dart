part of 'student_leave_cubit.dart';

@immutable
abstract class StudentLeaveState {}

class StudentLeaveInitial extends StudentLeaveState {}

class StudentLeaveLoadingState extends StudentLeaveState {}

class StudentLeaveSuccessState extends StudentLeaveState {
  final StudentGetLeaveModel response;

  StudentLeaveSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class StudentLeaveErrorState extends StudentLeaveState {
  final String error;

  StudentLeaveErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
