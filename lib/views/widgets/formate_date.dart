import 'package:intl/intl.dart';

formateDate(time) {
  // Parse the string into a DateTime object
  DateTime dateTime = DateTime.parse(time).toLocal();

  return DateFormat("d-MMM-yyyy").format(dateTime);
}
