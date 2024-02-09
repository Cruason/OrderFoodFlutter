import 'package:food_ordering/features/domain/entity/product.dart';

class OrderField{
  final ProductEntity? productEntity;
  final int? quantity;

  OrderField({required this.productEntity, required this.quantity});
}