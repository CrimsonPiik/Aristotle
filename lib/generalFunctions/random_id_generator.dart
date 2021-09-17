import 'dart:math';
import 'package:intl/intl.dart';

const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
Random random = Random();

/// #### This generates a random ID, used like this:
/// ```id = generateId();```
/// ##### ~Huthaifa
String generateId() {
  String randomLetters = List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  String now = (DateTime.now().millisecondsSinceEpoch / 1000).round().toString().substring(7);
  String formatted = DateFormat('yyMMdhmm').format(DateTime.now()).substring(1);
  return formatted + now + randomLetters;
}

String generateCustomId(String name) {
  String randomLetters = List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  String now = (DateTime.now().millisecondsSinceEpoch / 1000).round().toString().substring(7);
  String formatted = DateFormat('yyMMdhmm').format(DateTime.now()).substring(1);
  return formatted + now + randomLetters;
}

int generateTimeStampNumber() {
  var now = DateTime.now().millisecondsSinceEpoch.toString().substring(3);

  return int.parse(now);
}
