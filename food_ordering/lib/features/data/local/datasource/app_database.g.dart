// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TableDao? _tableDaoInstance;

  ProductDao? _productDaoInstance;

  OrderDao? _orderDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `tables` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `products` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `price` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `orders` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `table_id` INTEGER, `product_id` INTEGER, `quantity` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderResponse` (`id` INTEGER, `table_id` INTEGER, `quantity` INTEGER, `product_name` TEXT, `product-price` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TableDao get tableDao {
    return _tableDaoInstance ??= _$TableDao(database, changeListener);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  OrderDao get orderDao {
    return _orderDaoInstance ??= _$OrderDao(database, changeListener);
  }
}

class _$TableDao extends TableDao {
  _$TableDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tableModelInsertionAdapter = InsertionAdapter(
            database,
            'tables',
            (TableModel item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TableModel> _tableModelInsertionAdapter;

  @override
  Future<List<TableModel>> getAllTables() async {
    return _queryAdapter.queryList('SELECT * FROM tables',
        mapper: (Map<String, Object?> row) =>
            TableModel(id: row['id'] as int?, name: row['name'] as String?));
  }

  @override
  Future<void> insertTable(TableModel tableModel) async {
    await _tableModelInsertionAdapter.insert(
        tableModel, OnConflictStrategy.replace);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productModelInsertionAdapter = InsertionAdapter(
            database,
            'products',
            (ProductModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductModel> _productModelInsertionAdapter;

  @override
  Future<List<ProductModel>> getAllProduct() async {
    return _queryAdapter.queryList('SELECT * FROM products',
        mapper: (Map<String, Object?> row) => ProductModel(
            id: row['id'] as int?,
            name: row['name'] as String?,
            price: row['price'] as String?));
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    await _productModelInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }
}

class _$OrderDao extends OrderDao {
  _$OrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _orderModelInsertionAdapter = InsertionAdapter(
            database,
            'orders',
            (OrderModel item) => <String, Object?>{
                  'id': item.id,
                  'table_id': item.tableId,
                  'product_id': item.productId,
                  'quantity': item.quantity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderModel> _orderModelInsertionAdapter;

  @override
  Future<List<OrderResponse>> getOrderByTable(int id) async {
    return _queryAdapter.queryList(
        'SELECT orders.*, products.name AS product_name, products.price AS product_price FROM orders JOIN products ON orders.product_id = products.id WHERE orders.table_id = ?1',
        mapper: (Map<String, Object?> row) => OrderResponse(id: row['id'] as int?, tableId: row['table_id'] as int?, quantity: row['quantity'] as int?, productName: row['product_name'] as String?, productPrice: row['product-price'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertOrder(OrderModel orderModel) async {
    await _orderModelInsertionAdapter.insert(
        orderModel, OnConflictStrategy.replace);
  }
}
