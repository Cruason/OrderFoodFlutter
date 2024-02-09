import 'package:food_ordering/features/data/local/datasource/app_database.dart';
import 'package:food_ordering/features/data/model/order.dart';
import 'package:food_ordering/features/data/model/product.dart';
import 'package:food_ordering/features/data/model/table.dart';
import 'package:food_ordering/features/domain/entity/order_field.dart';
import 'package:food_ordering/features/domain/entity/product.dart';
import 'package:food_ordering/features/domain/entity/table.dart';
import 'package:food_ordering/features/domain/entity/table_order.dart';
import 'package:food_ordering/features/domain/repository/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final AppDatabase appDatabase;

  OrderRepositoryImpl({required this.appDatabase});

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    try {
      final result = await appDatabase.productDao.getAllProduct();
      print("data " + result.toString());
      final productList = List<ProductEntity>.from(result
          .map((e) => ProductEntity(id: e.id, name: e.name, price: e.price)));
      return productList;
    } catch (e) {
      print("error " + e.toString());
      return [];
    }
  }

  @override
  Future<List<TableEntity>> getAllTable() async {
    try {
      final result = await appDatabase.tableDao.getAllTables();
      print("data " + result.toString());
      final tableList = List<TableEntity>.from(
          result.map((e) => TableEntity(id: e.id, name: e.name)));
      return tableList;
    } catch (e) {
      print("error " + e.toString());
      return [];
    }
  }

  @override
  Future<TableOrderEntity> getOrderById(int tableId) async {
    try {
      final result = await appDatabase.orderDao.getOrderByTable(tableId);
      print("data " + result.toString());
      final orderList = List<OrderField>.from(result.map((e) => OrderField(
          productEntity: ProductEntity(
              id: e.productId, name: e.productName, price: e.productPrice),
          quantity: e.quantity)));
      final tableOrder =
          TableOrderEntity(tableId: tableId, orderFields: orderList);
      return tableOrder;
    } catch (e) {
      print("error " + e.toString());
      return TableOrderEntity(tableId: tableId, orderFields: []);
    }
  }

  @override
  Future<void> insertOrder(int tableId, OrderField orderField) async {
    try {
      await appDatabase.orderDao.insertOrder(OrderModel(
          tableId: tableId,
          productId: orderField.productEntity?.id,
          quantity: orderField.quantity));
      print("insert order");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> insertProduct(ProductEntity productEntity) async{
    try{
      await appDatabase.productDao.insertProduct(ProductModel(name: productEntity.name, price: productEntity.price));
      print("insert product");
    }catch (e){
      print(e.toString());
    }
  }

  @override
  Future<void> insertTable(TableEntity tableEntity)async {
    try{
      await appDatabase.tableDao.insertTable(TableModel(name: tableEntity.name));
      print("insert table");
    }catch (e){
      print(e.toString());
    }
  }
}
