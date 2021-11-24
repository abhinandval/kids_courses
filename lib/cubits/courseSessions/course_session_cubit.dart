import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/profile_sessions.dart';
import '../../models/profiles.dart';
import '../../models/session_info.dart';

part 'course_session_state.dart';

class CourseSessionCubit extends Cubit<CourseSessionState> {
  CourseSessionCubit() : super(CourseSessionLoading());

  void fetchData() async {
    emit(CourseSessionLoading());
    final rawProfiles = await rootBundle.loadString('assets/profiles.json');
    final rawProfileSessions =
        await rootBundle.loadString('assets/fake_data.json');

    final List parsedProfiles = json.decode(rawProfiles)['profiles'];
    final Map<String, dynamic> parsedProfileSessions =
        json.decode(rawProfileSessions)['data'];

    final profiles =
        List<Profile>.from(parsedProfiles.map((x) => Profile.fromMap(x)));

    List<MentorProfileData> profileSessions = [];

    parsedProfileSessions.forEach((key, value) {
      final profileId = key;
      List<SessionInfo> sessions = List<SessionInfo>.from(
          value?.map((x) => SessionInfo.fromMap(x)) ?? const []);

      if (profiles.any((profile) => profile.profileId == profileId)) {
        profileSessions.add(MentorProfileData(
          profileId,
          profiles.firstWhere((profile) => profile.profileId == profileId),
          sessions,
        ));
      }
    });

    emit(CourseSessionSuccess(profileSessions));
  }
}
