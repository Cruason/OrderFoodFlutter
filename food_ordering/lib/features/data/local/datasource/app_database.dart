
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:food_ordering/features/data/local/datasource/dao/order_dao.dart';
import 'package:food_ordering/features/data/local/datasource/dao/product_dao.dart';
import 'package:food_ordering/features/data/local/datasource/dao/table_dao.dart';
import 'package:food_ordering/features/data/model/order.dart';
import 'package:food_ordering/features/data/model/order_response.dart';
import 'package:food_ordering/features/data/model/product.dart';
import 'package:food_ordering/features/data/model/table.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [TableModel, ProductModel, OrderModel, OrderResponse])
abstract class AppDatabase extends FloorDatabase{
    TableDao get tableDao;
    ProductDao get productDao;
    OrderDao get orderDao;
}