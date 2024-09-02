import 'package:flutter/foundation.dart';

class UiTableData {
  final List<String> columns;
  final List<Cells> rows;
  UiTableData({
    required this.columns,
    required this.rows,
  });

  UiTableData copyWith({
    List<String>? columns,
    List<Cells>? rows,
  }) {
    return UiTableData(
      columns: columns ?? this.columns,
      rows: rows ?? this.rows,
    );
  }

  @override
  String toString() => 'UiTableData(columns: $columns, rows: $rows)';

  @override
  bool operator ==(covariant UiTableData other) {
    if (identical(this, other)) return true;

    return listEquals(other.columns, columns) && listEquals(other.rows, rows);
  }

  @override
  int get hashCode => columns.hashCode ^ rows.hashCode;
}

class Cells {
  final List<String> cell;
  Cells({
    required this.cell,
  });

  Cells copyWith({
    List<String>? cell,
  }) {
    return Cells(
      cell: cell ?? this.cell,
    );
  }

  @override
  String toString() => 'Cells(cell: $cell)';

  @override
  bool operator ==(covariant Cells other) {
    if (identical(this, other)) return true;

    return listEquals(other.cell, cell);
  }

  @override
  int get hashCode => cell.hashCode;
}
