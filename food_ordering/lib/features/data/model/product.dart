import 'package:floor/floor.dart';

@Entity(tableName: "products")
class ProductModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? name;
  final String? price;

  ProductModel({this.id, this.name,this.price});
}