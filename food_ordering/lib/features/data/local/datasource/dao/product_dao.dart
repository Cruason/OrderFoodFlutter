import 'package:floor/floor.dart';
import 'package:food_ordering/features/data/model/product.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM products')
  Future<List<ProductModel>> getAllProduct();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(ProductModel product);
}