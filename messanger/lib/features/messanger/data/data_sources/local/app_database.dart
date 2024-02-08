

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:floor/floor.dart';
import 'package:floor/floor.dart';
import 'package:floor/floor.dart';
import 'package:floor/floor.dart';
import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/data/data_sources/local/dao/chat_dao.dart';
import 'package:messanger/features/messanger/data/data_sources/local/dao/message_dao.dart';
import 'package:messanger/features/messanger/data/model/chat_model.dart';
import 'package:messanger/features/messanger/data/model/message_model.dart';
import 'package:messanger/features/messanger/data/model/user_model.dart';

import 'dao/user_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'app_database.g.dart';

@Database(version: 1, entities: [ChatModel, MessageModel, UserModel])
abstract class AppDataBase extends FloorDatabase{
  ChatDao get chatDao;
  MessageDao get messageDao;
  UserDao get userDao;
}
