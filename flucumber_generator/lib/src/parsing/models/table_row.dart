class TableRow {
  final bool isHeaderRow;
  final int rowIndex;
  final Iterable<String?> _columns;

  Iterable<String?> get columns => _columns;

  TableRow(
    this._columns,
    this.rowIndex, {
    required this.isHeaderRow,
  });
}
