import 'package:floor/floor.dart';



@Entity(tableName: "users")
class UserModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? userName;
  final String? phone;


  UserModel({this.id, this.userName, this.phone});
}