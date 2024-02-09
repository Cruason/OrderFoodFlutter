import 'package:floor/floor.dart';

@Entity()
class OrderResponse {
  @PrimaryKey()
  final int? id;
  @ColumnInfo(name: "table_id")
  final int? tableId;
  final int? quantity;
  @ColumnInfo(name: "product_id")
  final int? productId;
  @ColumnInfo(name: "product_name")
  final String? productName;
  @ColumnInfo(name: "product-price")
  final String? productPrice;

  OrderResponse(
      {this.id,
      this.tableId,
      this.quantity,
      this.productId,
      this.productName,
      this.productPrice});
}
