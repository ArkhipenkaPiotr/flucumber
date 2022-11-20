import 'table_row.dart';

class GherkinTable {
  final Iterable<TableRow> rows;
  final TableRow? header;

  GherkinTable(
    this.rows,
    this.header,
  );

  int get variablesLength => rows.first.columns.length;
}
