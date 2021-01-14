import 'dart:io';

class User {
  final String id;
  final String avatar;
  final String fullName;
  final DateTime createdAt;
  final String gender;
  final List<String> colors;
  final List<String> countries;

  User({
    this.id,
    this.avatar,
    this.fullName,
    this.createdAt,
    this.countries,
    this.colors,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? '',
        avatar: json['avatar'] ??
            'https://randomuser.me/api/portraits/women/55.jpg',
        fullName: json['fullName'] ?? 'No mame',
        createdAt: json['createdAt'] == null
            ? DateTime.now()
            : HttpDate.parse(json['createdAt']),
        gender: json['gender'] ?? 'Male',
        colors: json['colors'] == null ? [] : json['colors'].cast<String>(),
        countries:
            json['countries'] == null ? [] : json['countries'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "fullName": fullName,
        "createdAt": createdAt.toString(),
        "gender": gender,
        "colors": colors,
        "countries": countries,
      };

  @override
  String toString() {
    return 'User{id: $id, avatar: $avatar, fullName: $fullName, createdAt: $createdAt, gender: $gender, countriesLength: ${countries.length}, colors: ${colors.length}';
  }
}
