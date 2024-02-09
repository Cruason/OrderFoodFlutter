import 'package:floor/floor.dart';

@Entity(tableName: "tables")
class TableModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? name;

  TableModel({ this.id,  this.name});
}