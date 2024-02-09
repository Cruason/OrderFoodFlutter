import 'package:floor/floor.dart';
import 'package:food_ordering/features/data/model/table.dart';

@dao
abstract class TableDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTable(TableModel tableModel);

  @Query("SELECT * FROM tables")
  Future<List<TableModel>> getAllTables();
}