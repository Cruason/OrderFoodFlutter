import 'package:messanger/core/constants/constants.dart';

class UserEntity {
  final int? id;
  final String? username;
  final String? phone;

  UserEntity({this.id, this.username, this.phone});

  UserEntity copyWith(
      {int? id, String? username, String? phone, ProfileColor? color}) {
    return UserEntity(
      id: id??this.id,
      username: username??this.username,
      phone: phone??this.phone,
    );
  }
}
