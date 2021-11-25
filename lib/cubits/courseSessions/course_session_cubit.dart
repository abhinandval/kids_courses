import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api.dart';
import '../../models/profile_sessions.dart';
import '../../models/profiles.dart';
import '../../models/session_info.dart';

part 'course_session_state.dart';

class CourseSessionCubit extends Cubit<CourseSessionState> {
  CourseSessionCubit() : super(CourseSessionLoading());

  final api = API();

  void fetchData() async {
    emit(CourseSessionLoading('Getting Your Mentor Profiles'));

    api.fetchProfiles().then((pResponse) {
      if (pResponse.statusCode != 200) {
        emit(CourseSessionFailed());
      } else {
        final List parsedProfiles = json.decode(pResponse.body)['profiles'];

        emit(CourseSessionLoading('Getting Your Subscriptions'));

        api.fetchSubscriptions().then((sResponse) {
          if (sResponse.statusCode != 200) {
            emit(CourseSessionFailed());
          } else {
            final profiles = List<Profile>.from(
                parsedProfiles.map((x) => Profile.fromMap(x)));

            final Map<String, dynamic> parsedProfileSessions =
                json.decode(sResponse.body)['data'];

            List<MentorProfileData> profileSessions = [];

            parsedProfileSessions.forEach((key, value) {
              final profileId = key;
              List<SessionInfo> sessions = List<SessionInfo>.from(
                  value?.map((x) => SessionInfo.fromMap(x)) ?? const []);

              if (profiles.any((profile) => profile.profileId == profileId)) {
                profileSessions.add(MentorProfileData(
                  profileId,
                  profiles
                      .firstWhere((profile) => profile.profileId == profileId),
                  sessions,
                ));
              }
            });

            emit(CourseSessionSuccess(profileSessions));
          }
        });
      }
    });
  }
}
