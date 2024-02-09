import 'package:food_ordering/features/data/local/datasource/app_database.dart';
import 'package:food_ordering/features/data/repository/order_repository_impl.dart';
import 'package:food_ordering/features/domain/repository/order_repository.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;


Future<void> initializeDependencies() async{
    final database = await $FloorAppDatabase.databaseBuilder("app_database.db").build();

    di.registerSingleton<AppDatabase>(database);
    di.registerSingleton<OrderRepository>(OrderRepositoryImpl(appDatabase: di()));
}
