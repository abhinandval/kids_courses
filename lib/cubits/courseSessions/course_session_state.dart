part of 'course_session_cubit.dart';

@immutable
abstract class CourseSessionState {}

class CourseSessionLoading extends CourseSessionState {}

class CourseSessionSuccess extends CourseSessionState {
  final List<MentorProfileData> profileSessions;

  CourseSessionSuccess(this.profileSessions);
}

class CourseSessionFailed extends CourseSessionState {}
