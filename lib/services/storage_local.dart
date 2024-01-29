import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveLocationIndex(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('location', value);
}

Future<int?> getLocationIndex() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('location');
}
