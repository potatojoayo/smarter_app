import 'package:intl/intl.dart';

final dateFormatter = DateFormat('yyyy-MM-dd');
final timeFormatter = DateFormat('HH:mm:ss');

DateTime? fromGraphQLDateTimeNullableToDartDateTimeNullable(String? date) =>
    date == null ? null : DateTime.parse(date);

String fromDartDateTimeNullableToGraphQLDateTimeNullable(DateTime? date) =>
    dateFormatter.format(date!);

DateTime fromGraphQLTimeToDartDateTime(String time) =>
    DateTime.parse('1970-01-01T${time}Z');

String fromDartDateTimeToGraphQLTime(DateTime? date) =>
    timeFormatter.format(date!);
