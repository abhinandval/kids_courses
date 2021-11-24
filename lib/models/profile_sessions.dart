import 'course_status_data.dart';
import 'profiles.dart';
import 'session_info.dart';

class MentorProfileData {
  final String profileId;
  final Profile profileInfo;
  final List<SessionInfo> sessions;

  List<CourseStatusData> get completedSessions => sessions
      .where((element) => element.toSessionTileData.isCompleted)
      .map((e) => e.toSessionTileData)
      .toList(growable: false);

  List<CourseStatusData> get activeSessions => sessions
      .where((element) => !element.toSessionTileData.isCompleted)
      .map((e) => e.toSessionTileData)
      .toList(growable: false);

  MentorProfileData(this.profileId, this.profileInfo, this.sessions);
}
