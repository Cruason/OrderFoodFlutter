// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ChatDao? _chatDaoInstance;

  MessageDao? _messageDaoInstance;

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `chats` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `first_user_id` INTEGER, `second_user_id` INTEGER, `last_message_id` INTEGER, `color` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `messages` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `chat_id` INTEGER, `sender_id` INTEGER, `message` TEXT, `timeStampMillis` INTEGER, `isRed` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userName` TEXT, `phone` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ChatDao get chatDao {
    return _chatDaoInstance ??= _$ChatDao(database, changeListener);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$ChatDao extends ChatDao {
  _$ChatDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _chatModelInsertionAdapter = InsertionAdapter(
            database,
            'chats',
            (ChatModel item) => <String, Object?>{
                  'id': item.id,
                  'first_user_id': item.firstUserId,
                  'second_user_id': item.secondUserId,
                  'last_message_id': item.lastMessageId,
                  'color': item.color?.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChatModel> _chatModelInsertionAdapter;

  @override
  Future<List<ChatModel>> getChatsByUser(int userId) async {
    return _queryAdapter.queryList(
        'Select * FROM chats WHERE first_user_id = ?1 OR second_user_id = ?1',
        mapper: (Map<String, Object?> row) => ChatModel(
            id: row['id'] as int?,
            firstUserId: row['first_user_id'] as int?,
            secondUserId: row['second_user_id'] as int?,
            lastMessageId: row['last_message_id'] as int?,
            color: row['color'] == null
                ? null
                : ProfileColor.values[row['color'] as int]),
        arguments: [userId]);
  }

  @override
  Future<ChatModel?> getChatById(int id) async {
    return _queryAdapter.query('Select * FROM chats WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ChatModel(
            id: row['id'] as int?,
            firstUserId: row['first_user_id'] as int?,
            secondUserId: row['second_user_id'] as int?,
            lastMessageId: row['last_message_id'] as int?,
            color: row['color'] == null
                ? null
                : ProfileColor.values[row['color'] as int]),
        arguments: [id]);
  }

  @override
  Future<int> insertChat(ChatModel chatModel) {
    return _chatModelInsertionAdapter.insertAndReturnId(
        chatModel, OnConflictStrategy.replace);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _messageModelInsertionAdapter = InsertionAdapter(
            database,
            'messages',
            (MessageModel item) => <String, Object?>{
                  'id': item.id,
                  'chat_id': item.chatId,
                  'sender_id': item.senderId,
                  'message': item.message,
                  'timeStampMillis': item.timeStampMillis,
                  'isRed': item.isRed == null ? null : (item.isRed! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MessageModel> _messageModelInsertionAdapter;

  @override
  Future<List<MessageModel>> getMessagesByChat(int chatId) async {
    return _queryAdapter.queryList('SELECT * FROM messages WHERE chat_id = ?1',
        mapper: (Map<String, Object?> row) => MessageModel(
            id: row['id'] as int?,
            chatId: row['chat_id'] as int?,
            senderId: row['sender_id'] as int?,
            message: row['message'] as String?,
            timeStampMillis: row['timeStampMillis'] as int?,
            isRed: row['isRed'] == null ? null : (row['isRed'] as int) != 0),
        arguments: [chatId]);
  }

  @override
  Future<MessageModel?> getMessageById(int id) async {
    return _queryAdapter.query('SELECT * FROM messages WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MessageModel(
            id: row['id'] as int?,
            chatId: row['chat_id'] as int?,
            senderId: row['sender_id'] as int?,
            message: row['message'] as String?,
            timeStampMillis: row['timeStampMillis'] as int?,
            isRed: row['isRed'] == null ? null : (row['isRed'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<int> insertMessage(MessageModel messageModel) {
    return _messageModelInsertionAdapter.insertAndReturnId(
        messageModel, OnConflictStrategy.replace);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'userName': item.userName,
                  'phone': item.phone
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  @override
  Future<UserModel?> getUserByPhone(String phone) async {
    return _queryAdapter.query('Select * FROM users WHERE phone = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int?,
            userName: row['userName'] as String?,
            phone: row['phone'] as String?),
        arguments: [phone]);
  }

  @override
  Future<UserModel?> getUserById(int id) async {
    return _queryAdapter.query('Select * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int?,
            userName: row['userName'] as String?,
            phone: row['phone'] as String?),
        arguments: [id]);
  }

  @override
  Future<int> insertUser(UserModel userModel) {
    return _userModelInsertionAdapter.insertAndReturnId(
        userModel, OnConflictStrategy.replace);
  }
}
