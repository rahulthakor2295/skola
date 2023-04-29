part of 'teacher_leaves_cubit.dart';

@immutable
abstract class TeacherLeaveState {}

class TeacherLeaveInitial extends TeacherLeaveState {}

class TeacherLeaveLoadingState extends TeacherLeaveState {}

class TeacherLeaveSuccessState extends TeacherLeaveState {
  final LeaveRequestResponse response;

  TeacherLeaveSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class TeacherLeaveErrorState extends TeacherLeaveState {
  final String error;

  TeacherLeaveErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
