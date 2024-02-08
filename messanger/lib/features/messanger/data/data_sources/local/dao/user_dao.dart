
import 'package:floor/floor.dart';
import 'package:messanger/features/messanger/data/model/user_model.dart';

@dao
abstract class UserDao{
  @Insert(onConflict: OnConflictStrategy.replace)
    Future<int> insertUser(UserModel userModel);
  
  @Query("Select * FROM users WHERE phone = :phone")
  Future<UserModel?> getUserByPhone(String phone);

  @Query("Select * FROM users WHERE id = :id")
  Future<UserModel?> getUserById(int id);
}