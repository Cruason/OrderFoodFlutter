import 'package:food_ordering/features/domain/entity/order_field.dart';
import 'package:food_ordering/features/domain/entity/product.dart';
import 'package:food_ordering/features/domain/entity/table.dart';
import 'package:food_ordering/features/domain/entity/table_order.dart';

abstract class OrderRepository{

  Future<void> insertTable(TableEntity tableEntity);
  Future<List<TableEntity>> getAllTable();

  Future<void> insertProduct(ProductEntity productEntity);
  Future<List<ProductEntity>> getAllProduct();

  Future<void> insertOrder(int tableId, OrderField orderField);
  Future<TableOrderEntity> getOrderById(int tableId);
}