import 'package:intl/intl.dart';

class DateFormatters {
  // Private constructor
  DateFormatters._privateConstructor();

  // Singleton instance variable
  static DateFormatters? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to DateFormatters.instance will return the same instance that was created before.

  // Getter to access the singleton instance
  static DateFormatters get instance {
    _instance ??= DateFormatters._privateConstructor();
    return _instance!;
  }

  //get date in mm/yyyy format
  String mmYYYYFormat({required DateTime date}) {
    String _formattedDate = DateFormat('MM/yyyy').format(date);
    return _formattedDate;
  }

  //get date in mm/yyyy format
  String ddmmYYYYFormat({required DateTime date}) {
    String _formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return _formattedDate;
  }
}
