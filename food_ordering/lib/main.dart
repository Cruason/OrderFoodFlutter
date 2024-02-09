import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_ordering/features/di/injection_container.dart';
import 'package:food_ordering/features/domain/entity/order_field.dart';
import 'package:food_ordering/features/domain/entity/product.dart';
import 'package:food_ordering/features/domain/entity/table.dart';
import 'package:food_ordering/features/domain/repository/order_repository.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  OrderRepository orderRepository = di();

  // final tables = generateDummyTableData();
  // for (var i=0;i<tables.length;i++){
  //   await orderRepository.insertTable(tables[i]);
  // }
  // final products = generateDummyProductData();
  // for (var i=0;i<products.length;i++){
  //   await orderRepository.insertProduct(products[i]);
  // }

  final tablesList = await orderRepository.getAllTable();
  print(tablesList.toString());

  final productList = await orderRepository.getAllProduct();
  print(productList.toString());

  //final orderList = [OrderField(productEntity: productList[0], quantity: 2), OrderField(productEntity: productList[1], quantity: 4) ,OrderField(productEntity: productList[2], quantity: 6)];

  // for(var i=0;i<orderList.length;i++)
  //   {
  //     await orderRepository.insertOrder(1, orderList[i]);
  //   }

  final result = await orderRepository.getOrderById(1);
  for(var order in result.orderFields){
    print("${order.productEntity?.name.toString()} + ${order.quantity.toString()}");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
    );
  }
}

List<TableEntity> generateDummyTableData() {
  return [
    TableEntity(id: null, name: 'Table 1'),
    TableEntity(id: null, name: 'Table 2'),
    TableEntity(id: null, name: 'Table 3'),
    // Add more dummy data as needed
  ];
}

List<ProductEntity> generateDummyProductData() {
  final random = Random();
  return List.generate(
    5, // Generate 5 dummy products
        (index) => ProductEntity(
      id: index + 1, // Assuming ids start from 1
      name: 'Product ${index + 1}',
      price: (5.0 + random.nextDouble() * 20.0).toStringAsFixed(2), // Random price between 5 and 25
    ),
  );
}
