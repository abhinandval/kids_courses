import 'package:flutter/material.dart' show Color;

import 'session_tile_data.dart';

class CourseStatusData {
  final Color primaryColor;
  final Color secondaryColor;
  final String contentTitle;
  final int completedSessionsCount;
  final int totalSessionsCount;
  final int creditCount;
  final int ratingCount;
  final int remainingSessionsCount;
  final List<SessionTileData> sessions;
  final bool isCompleted;

  CourseStatusData({
    required this.primaryColor,
    required this.secondaryColor,
    required this.contentTitle,
    required this.completedSessionsCount,
    required this.totalSessionsCount,
    required this.creditCount,
    required this.ratingCount,
    required this.sessions,
  })  : remainingSessionsCount = totalSessionsCount - completedSessionsCount,
        isCompleted = totalSessionsCount == completedSessionsCount;
}
