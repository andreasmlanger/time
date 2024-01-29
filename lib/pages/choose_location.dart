import 'package:flutter/material.dart';
import 'package:time/services/storage_local.dart';
import 'package:time/services/time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  late String location;
  late String flag;
  late String time;
  late bool isDayTime;

  void updateTime(index) async {
    await saveLocationIndex(index);
    WorldTime instance = locations[index];
    await instance.getTime();
    location = instance.location;
    flag = instance.flag;
    time = instance.time;
    isDayTime = instance.isDayTime;
    navigateBackToHome();
  }

  void navigateBackToHome() {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context, {
        'location': location,
        'flag': flag,
        'time': time,
        'isDayTime': isDayTime,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Choose a Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          )
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
            child: Container(
              child: Card (
                color: Colors.teal[900],
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(
                    locations[index].location,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/flags/${locations[index].flag}')
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
