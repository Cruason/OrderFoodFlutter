import 'package:floor/floor.dart';
import 'package:food_ordering/features/data/model/order.dart';
import 'package:food_ordering/features/data/model/order_response.dart';

@dao
abstract class OrderDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrder(OrderModel orderModel);

  @Query(
      "SELECT orders.*, products.name AS product_name, products.price AS product_price FROM orders JOIN products ON orders.product_id = products.id WHERE orders.table_id = :id")
  Future<List<OrderResponse>> getOrderByTable(int id);
}
