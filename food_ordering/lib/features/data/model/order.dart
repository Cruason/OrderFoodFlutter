
import 'package:floor/floor.dart';
import 'package:food_ordering/features/data/model/product.dart';

@Entity(tableName: "orders")
class OrderModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: "table_id")
  final int? tableId;
  @ColumnInfo(name: "product_id")
  @ForeignKey(
    entity: ProductModel,
    parentColumns: ['id'],
    childColumns: ['productId'],
  )
  final int? productId;
  final int? quantity;

  OrderModel({ this.id,  this.tableId,  this.productId,  this.quantity});
}