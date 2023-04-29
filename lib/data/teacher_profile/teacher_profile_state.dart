part of 'teacher_profile_cubit.dart';

@immutable
abstract class TeacherProfileState {}

class TeacherProfileInitial extends TeacherProfileState {}

class TeacherProfileLoadingState extends TeacherProfileState {}

class TeacherProfileSuccessState extends TeacherProfileState {
  final TeacherProfileModel response;

  TeacherProfileSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class TeacherProfileErrorState extends TeacherProfileState {
  final String error;

  TeacherProfileErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
