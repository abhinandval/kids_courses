import 'dart:convert';

class SessionTileData {
  final String sessionDescription;
  final int sessionNumber;
  final int favCount;
  final int creditCount;
  final bool isLocked;

  SessionTileData._(
    this.sessionDescription,
    this.sessionNumber,
    this.favCount,
    this.creditCount, [
    this.isLocked = false,
  ]);

  SessionTileData({
    required this.sessionDescription,
    required this.sessionNumber,
    required this.favCount,
    required this.creditCount,
    this.isLocked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'sessionDescription': sessionDescription,
      'sessionNumber': sessionNumber,
      'favCount': favCount,
      'creditCount': creditCount,
      'isLocked': isLocked,
    };
  }

  factory SessionTileData.fromMap(Map<String, dynamic> map) {
    return SessionTileData._(
      map['sessionDescription'] ?? '',
      map['sessionNumber'] ?? 0,
      map['favCount'] ?? 0,
      map['creditCount'] ?? 0,
      map['isLocked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionTileData.fromJson(String source) =>
      SessionTileData.fromMap(json.decode(source));

  static List<SessionTileData> get dummyDatas =>
      _dummyData.map((e) => SessionTileData.fromMap(e)).toList();
}

const _dummyData = [
  {
    "sessionNumber": 1,
    "sessionDescription": "Slide & Wiper",
    "creditCount": 10,
    "favCount": 12,
  },
  {
    "sessionNumber": 2,
    "sessionDescription": "Quick recap & ATL Stomp",
    "creditCount": 5,
    "favCount": 1,
    "isLocked": true,
  }
];
