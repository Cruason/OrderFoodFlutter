import 'package:food_ordering/features/domain/entity/order_field.dart';

class TableOrderEntity{
  final int? tableId;
  final List<OrderField> orderFields;

  TableOrderEntity({required this.tableId, required this.orderFields});
}