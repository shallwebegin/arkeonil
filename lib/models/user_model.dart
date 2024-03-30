// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String surname;
  final String username;
  final String email;
  String? profilePhoto;
  String? uid;

  UserModel({
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    this.profilePhoto,
    this.uid,
  });

  UserModel copyWith({
    String? name,
    String? surname,
    String? username,
    String? email,
    String? profilePhoto,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'username': username,
      'email': email,
      'profilePhoto': profilePhoto,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      surname: map['surname'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, surname: $surname, username: $username, email: $email, profilePhoto: $profilePhoto, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.surname == surname &&
        other.username == username &&
        other.email == email &&
        other.profilePhoto == profilePhoto &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        username.hashCode ^
        email.hashCode ^
        profilePhoto.hashCode ^
        uid.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
