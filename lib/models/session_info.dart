import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../utils/colors.dart';
import 'course_status_data.dart';
import 'session_tile_data.dart';

class SessionInfo {
  final String subscribedCourseId;
  final String userId;
  final String profileId;
  final String courseChildId;
  final String slotId;
  final String paymentId;
  final String status;
  final CourseChild courseChild;
  final List<SubscribedSession> subscribedSessions;
  final CourseSlot? courseSlot;

  SessionInfo({
    required this.subscribedCourseId,
    required this.userId,
    required this.profileId,
    required this.courseChildId,
    required this.slotId,
    required this.paymentId,
    required this.status,
    required this.courseChild,
    required this.subscribedSessions,
    this.courseSlot,
  });

  SessionInfo copyWith({
    String? subscribedCourseId,
    String? userId,
    String? profileId,
    String? courseChildId,
    String? slotId,
    String? paymentId,
    String? status,
    CourseChild? courseChild,
    List<SubscribedSession>? subscribedSessions,
    CourseSlot? courseSlot,
  }) {
    return SessionInfo(
      subscribedCourseId: subscribedCourseId ?? this.subscribedCourseId,
      userId: userId ?? this.userId,
      profileId: profileId ?? this.profileId,
      courseChildId: courseChildId ?? this.courseChildId,
      slotId: slotId ?? this.slotId,
      paymentId: paymentId ?? this.paymentId,
      status: status ?? this.status,
      courseChild: courseChild ?? this.courseChild,
      subscribedSessions: subscribedSessions ?? this.subscribedSessions,
      courseSlot: courseSlot ?? this.courseSlot,
    );
  }

  factory SessionInfo.fromMap(Map<String, dynamic> map) {
    return SessionInfo(
      subscribedCourseId: map['subscribedCourseId'] ?? '',
      userId: map['userId'] ?? '',
      profileId: map['profileId'] ?? '',
      courseChildId: map['courseChildId'] ?? '',
      slotId: map['slotId'] ?? '',
      paymentId: map['paymentId'] ?? '',
      status: map['status'] ?? '',
      courseChild: CourseChild.fromMap(map['course_child']),
      subscribedSessions: List<SubscribedSession>.from(
          map['subscribed_sessions']
                  ?.map((x) => SubscribedSession.fromMap(x)) ??
              const []),
      courseSlot: map['courseSlot'] == null
          ? null
          : CourseSlot.fromMap(map['courseSlot']),
    );
  }

  CourseStatusData get toSessionTileData {
    final completedSessionsCount = subscribedSessions
        .where((session) => session.status == 'COMPLETED')
        .length;

    final ratingCount =
        subscribedSessions.fold<int>(0, (sum, session) => sum + session.rating);

    final sessionTiles = subscribedSessions
        .map(
          (session) => SessionTileData(
            sessionDescription: session.session.title,
            sessionNumber: session.session.sessionIndex,
            favCount: session.rating,
            creditCount: 0,
            isLocked: session.status == "LOCKED",
          ),
        )
        .toList(growable: false);

    return CourseStatusData(
      primaryColor:
          ColorUtils.getColorFromHex(courseChild.courseParent.style.accent),
      secondaryColor:
          ColorUtils.getColorFromHex(courseChild.courseParent.style.background),
      contentTitle: courseChild.title,
      completedSessionsCount: completedSessionsCount,
      totalSessionsCount: subscribedSessions.length,
      creditCount: 0,
      ratingCount: ratingCount,
      sessions: sessionTiles,
    );
  }

  factory SessionInfo.fromJson(String source) =>
      SessionInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SessionInfo(subscribedCourseId: $subscribedCourseId, userId: $userId, profileId: $profileId, courseChildId: $courseChildId, slotId: $slotId, paymentId: $paymentId, status: $status, course_child: $courseChild, subscribed_sessions: $subscribedSessions, courseSlot: $courseSlot)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SessionInfo &&
        other.subscribedCourseId == subscribedCourseId &&
        other.userId == userId &&
        other.profileId == profileId &&
        other.courseChildId == courseChildId &&
        other.slotId == slotId &&
        other.paymentId == paymentId &&
        other.status == status &&
        other.courseChild == courseChild &&
        listEquals(other.subscribedSessions, subscribedSessions) &&
        other.courseSlot == courseSlot;
  }

  @override
  int get hashCode {
    return subscribedCourseId.hashCode ^
        userId.hashCode ^
        profileId.hashCode ^
        courseChildId.hashCode ^
        slotId.hashCode ^
        paymentId.hashCode ^
        status.hashCode ^
        courseChild.hashCode ^
        subscribedSessions.hashCode ^
        courseSlot.hashCode;
  }
}

class CourseChild {
  final String courseChildId;
  final String title;
  final List<AgeGroup> ageGroup;
  final int duration;
  final int frequency;
  final CourseParent courseParent;
  CourseChild({
    required this.courseChildId,
    required this.title,
    required this.ageGroup,
    required this.duration,
    required this.frequency,
    required this.courseParent,
  });

  CourseChild copyWith({
    String? courseChildId,
    String? title,
    List<AgeGroup>? ageGroup,
    int? duration,
    int? frequency,
    CourseParent? courseParent,
  }) {
    return CourseChild(
      courseChildId: courseChildId ?? this.courseChildId,
      title: title ?? this.title,
      ageGroup: ageGroup ?? this.ageGroup,
      duration: duration ?? this.duration,
      frequency: frequency ?? this.frequency,
      courseParent: courseParent ?? this.courseParent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseChildId': courseChildId,
      'title': title,
      'ageGroup': ageGroup.map((x) => x.toMap()).toList(),
      'duration': duration,
      'frequency': frequency,
      'course_parent': courseParent.toMap(),
    };
  }

  factory CourseChild.fromMap(Map<String, dynamic> map) {
    return CourseChild(
      courseChildId: map['courseChildId'] ?? '',
      title: map['title'] ?? '',
      ageGroup: List<AgeGroup>.from(
          map['ageGroup']?.map((x) => AgeGroup.fromMap(x)) ?? const []),
      duration: map['duration']?.toInt() ?? 0,
      frequency: map['frequency']?.toInt() ?? 0,
      courseParent: CourseParent.fromMap(map['course_parent']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseChild.fromJson(String source) =>
      CourseChild.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course_child(courseChildId: $courseChildId, title: $title, ageGroup: $ageGroup, duration: $duration, frequency: $frequency, course_parent: $courseParent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseChild &&
        other.courseChildId == courseChildId &&
        other.title == title &&
        listEquals(other.ageGroup, ageGroup) &&
        other.duration == duration &&
        other.frequency == frequency &&
        other.courseParent == courseParent;
  }

  @override
  int get hashCode {
    return courseChildId.hashCode ^
        title.hashCode ^
        ageGroup.hashCode ^
        duration.hashCode ^
        frequency.hashCode ^
        courseParent.hashCode;
  }
}

class AgeGroup {
  final int value;
  final bool inclusive;
  AgeGroup({
    required this.value,
    required this.inclusive,
  });

  AgeGroup copyWith({
    int? value,
    bool? inclusive,
  }) {
    return AgeGroup(
      value: value ?? this.value,
      inclusive: inclusive ?? this.inclusive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'inclusive': inclusive,
    };
  }

  factory AgeGroup.fromMap(Map<String, dynamic> map) {
    return AgeGroup(
      value: map['value']?.toInt() ?? 0,
      inclusive: map['inclusive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgeGroup.fromJson(String source) =>
      AgeGroup.fromMap(json.decode(source));

  @override
  String toString() => 'AgeGroup(value: $value, inclusive: $inclusive)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgeGroup &&
        other.value == value &&
        other.inclusive == inclusive;
  }

  @override
  int get hashCode => value.hashCode ^ inclusive.hashCode;
}

class CourseParent {
  final String courseParentId;
  final String title;
  final Style style;
  final String slug;
  final Segment segment;
  CourseParent({
    required this.courseParentId,
    required this.title,
    required this.style,
    required this.slug,
    required this.segment,
  });

  CourseParent copyWith({
    String? courseParentId,
    String? title,
    Style? style,
    String? slug,
    Segment? segment,
  }) {
    return CourseParent(
      courseParentId: courseParentId ?? this.courseParentId,
      title: title ?? this.title,
      style: style ?? this.style,
      slug: slug ?? this.slug,
      segment: segment ?? this.segment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseParentId': courseParentId,
      'title': title,
      'style': style.toMap(),
      'slug': slug,
      'segment': segment.toMap(),
    };
  }

  factory CourseParent.fromMap(Map<String, dynamic> map) {
    return CourseParent(
      courseParentId: map['courseParentId'] ?? '',
      title: map['title'] ?? '',
      style: Style.fromMap(map['style']),
      slug: map['slug'] ?? '',
      segment: Segment.fromMap(map['segment']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseParent.fromJson(String source) =>
      CourseParent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course_parent(courseParentId: $courseParentId, title: $title, style: $style, slug: $slug, segment: $segment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseParent &&
        other.courseParentId == courseParentId &&
        other.title == title &&
        other.style == style &&
        other.slug == slug &&
        other.segment == segment;
  }

  @override
  int get hashCode {
    return courseParentId.hashCode ^
        title.hashCode ^
        style.hashCode ^
        slug.hashCode ^
        segment.hashCode;
  }
}

class Style {
  final String accent;
  final String background;
  Style({
    required this.accent,
    required this.background,
  });

  Style copyWith({
    String? accent,
    String? background,
  }) {
    return Style(
      accent: accent ?? this.accent,
      background: background ?? this.background,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accent': accent,
      'background': background,
    };
  }

  factory Style.fromMap(Map<String, dynamic> map) {
    return Style(
      accent: map['accent'] ?? '',
      background: map['background'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Style.fromJson(String source) => Style.fromMap(json.decode(source));

  @override
  String toString() => 'Style(accent: $accent, background: $background)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Style &&
        other.accent == accent &&
        other.background == background;
  }

  @override
  int get hashCode => accent.hashCode ^ background.hashCode;
}

class Segment {
  final Style style;
  final String image;
  Segment({
    required this.style,
    required this.image,
  });

  Segment copyWith({
    Style? style,
    String? image,
  }) {
    return Segment(
      style: style ?? this.style,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'style': style.toMap(),
      'image': image,
    };
  }

  factory Segment.fromMap(Map<String, dynamic> map) {
    return Segment(
      style: Style.fromMap(map['style']),
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Segment.fromJson(String source) =>
      Segment.fromMap(json.decode(source));

  @override
  String toString() => 'Segment(style: $style, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Segment && other.style == style && other.image == image;
  }

  @override
  int get hashCode => style.hashCode ^ image.hashCode;
}

class SubscribedSession {
  final int rating;
  final String status;
  final Session session;
  SubscribedSession({
    required this.rating,
    required this.status,
    required this.session,
  });

  SubscribedSession copyWith({
    int? rating,
    String? status,
    Session? session,
  }) {
    return SubscribedSession(
      rating: rating ?? this.rating,
      status: status ?? this.status,
      session: session ?? this.session,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'status': status,
      'session': session.toMap(),
    };
  }

  factory SubscribedSession.fromMap(Map<String, dynamic> map) {
    return SubscribedSession(
      rating: map['rating']?.toInt() ?? 0,
      status: map['status'] ?? '',
      session: Session.fromMap(map['session']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscribedSession.fromJson(String source) =>
      SubscribedSession.fromMap(json.decode(source));

  @override
  String toString() =>
      'Subscribed_session(rating: $rating, status: $status, session: $session)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubscribedSession &&
        other.rating == rating &&
        other.status == status &&
        other.session == session;
  }

  @override
  int get hashCode => rating.hashCode ^ status.hashCode ^ session.hashCode;
}

class Session {
  final String sessionId;
  final int sessionIndex;
  final String title;
  Session({
    required this.sessionId,
    required this.sessionIndex,
    required this.title,
  });

  Session copyWith({
    String? sessionId,
    int? sessionIndex,
    String? title,
  }) {
    return Session(
      sessionId: sessionId ?? this.sessionId,
      sessionIndex: sessionIndex ?? this.sessionIndex,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'sessionIndex': sessionIndex,
      'title': title,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['sessionId'] ?? '',
      sessionIndex: map['sessionIndex']?.toInt() ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  @override
  String toString() =>
      'Session(sessionId: $sessionId, sessionIndex: $sessionIndex, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Session &&
        other.sessionId == sessionId &&
        other.sessionIndex == sessionIndex &&
        other.title == title;
  }

  @override
  int get hashCode =>
      sessionId.hashCode ^ sessionIndex.hashCode ^ title.hashCode;
}

class CourseSlot {
  final String courseSlotId;
  final List<String> slotDates;
  final List<String> daysOfWeek;
  CourseSlot({
    required this.courseSlotId,
    required this.slotDates,
    required this.daysOfWeek,
  });

  CourseSlot copyWith({
    String? courseSlotId,
    List<String>? slotDates,
    List<String>? daysOfWeek,
  }) {
    return CourseSlot(
      courseSlotId: courseSlotId ?? this.courseSlotId,
      slotDates: slotDates ?? this.slotDates,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseSlotId': courseSlotId,
      'slotDates': slotDates,
      'daysOfWeek': daysOfWeek,
    };
  }

  factory CourseSlot.fromMap(Map<String, dynamic> map) {
    return CourseSlot(
      courseSlotId: map['courseSlotId'] ?? '',
      slotDates: List<String>.from(map['slotDates'] ?? const []),
      daysOfWeek: List<String>.from(map['daysOfWeek'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseSlot.fromJson(String source) =>
      CourseSlot.fromMap(json.decode(source));

  @override
  String toString() =>
      'CourseSlot(courseSlotId: $courseSlotId, slotDates: $slotDates, daysOfWeek: $daysOfWeek)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseSlot &&
        other.courseSlotId == courseSlotId &&
        listEquals(other.slotDates, slotDates) &&
        listEquals(other.daysOfWeek, daysOfWeek);
  }

  @override
  int get hashCode =>
      courseSlotId.hashCode ^ slotDates.hashCode ^ daysOfWeek.hashCode;
}
