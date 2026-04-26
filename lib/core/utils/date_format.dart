import 'package:intl/intl.dart';

String formatDateByDDMMMYYYY(DateTime date) {
  return DateFormat('d MMM YYYY').format(date);
}
