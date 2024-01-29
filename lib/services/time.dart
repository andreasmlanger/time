import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// http://worldtimeapi.org/api/timezone
// https://www.flaticon.com/packs/countrys-flags
List<WorldTime> locations = [
  WorldTime(url: 'Asia/Almaty', location: 'Almaty', flag: 'kazakhstan.png'),
  WorldTime(url: 'America/Bogota', location: 'Bogota', flag: 'colombia.png'),
  WorldTime(url: 'America/Argentina/Buenos_Aires', location: 'Buenos Aires', flag: 'argentina.png'),
  WorldTime(url: 'Africa/Johannesburg', location: 'Cape Town', flag: 'south-africa.png'),
  WorldTime(url: 'Asia/Ho_Chi_Minh', location: 'Hanoi', flag: 'vietnam.png'),
  WorldTime(url: 'Europe/Lisbon', location: 'Lisbon', flag: 'portugal.png'),
  WorldTime(url: 'Europe/Berlin', location: 'Munich', flag: 'germany.png'),
  WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
  WorldTime(url: 'America/Sao_Paulo', location: 'Rio de Janeiro', flag: 'brazil.png'),
  WorldTime(url: 'America/Los_Angeles', location: 'San Diego', flag: 'usa.png'),
  WorldTime(url: 'Australia/Sydney', location: 'Sydney', flag: 'australia.png'),
  WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'japan.png'),
];

class WorldTime {

  String location;  // location name for UI
  String flag; // url to asset flag icon
  String url; // location url for API endpoint
  bool isDayTime = true;
  late String time; // time in that location

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
    int count = 0;
    while (count < 10) {  // try a max of 10 times
      try {
        String str = 'http://worldtimeapi.org/api/timezone/$url';
        Uri uri = Uri.parse(str);
        http.Response response = await http.get(uri);
        Map data = jsonDecode(response.body);
        String datetime = data['datetime'];
        String offset = data['utc_offset'];

        // Extract hours and minutes from daytime
        int offsetHours = int.parse(offset.substring(0, 3));
        int offsetMinutes = int.parse(offset.substring(4, 6));

        DateTime utc = DateTime.parse(datetime);
        DateTime now = utc.add(Duration(hours: offsetHours, minutes: offsetMinutes));

        time = DateFormat.Hm().format(now);

        isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
        break;
      }
      catch (e) {
        time = 'Error';
      }
    }
  }
}
