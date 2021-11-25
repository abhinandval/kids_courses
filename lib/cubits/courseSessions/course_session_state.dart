part of 'course_session_cubit.dart';

@immutable
abstract class CourseSessionState {}

class CourseSessionLoading extends CourseSessionState {
  final String message;

  CourseSessionLoading([this.message = 'loading . . .']);
}

class CourseSessionSuccess extends CourseSessionState {
  final List<MentorProfileData> profileSessions;

  CourseSessionSuccess(this.profileSessions);
}

class CourseSessionFailed extends CourseSessionState {}
