import 'dart:convert';

class Profile {
  final String profileId;
  final String userId;
  final String firstName;
  final String lastName;
  final int age;
  final String createdAt;
  final String updatedAt;
  Profile({
    required this.profileId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
  });

  Profile copyWith({
    String? profileId,
    String? userId,
    String? firstName,
    String? lastName,
    int? age,
    String? createdAt,
    String? updatedAt,
  }) {
    return Profile(
      profileId: profileId ?? this.profileId,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileId': profileId,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      profileId: map['profileId'] ?? '',
      userId: map['userId'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(profileId: $profileId, userId: $userId, firstName: $firstName, lastName: $lastName, age: $age, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.profileId == profileId &&
        other.userId == userId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return profileId.hashCode ^
        userId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
