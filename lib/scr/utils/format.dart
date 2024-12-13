import 'package:intl/intl.dart';

class Format {
  // String? value;

  static String? DateTimeToString(DateTime value) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(value);
    String result = formattedDate;
    return result;
  }

  static String StringBirthday(String value) {
    DateTime birthday = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(value);
    var inputDate = DateTime.parse(birthday.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
    //Using inHours instead of days b/c of daylight savings
  }


  static String? moneyFormat(double price){
    final numberFormat = new NumberFormat("#,##0.00", "en_US");
    String x = numberFormat.format(price);
    return x;
  }

  static String? dateTimeParse(String input){
    DateTime birthday = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(input);
    var inputDate = DateTime.parse(birthday.toString());
    // var outputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

}
