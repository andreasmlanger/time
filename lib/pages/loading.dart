import 'package:flutter/material.dart';
import 'package:time/services/storage_local.dart';
import 'package:time/services/time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String location;
  late String flag;
  late String time;
  late bool isDayTime;

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  void setupWorldTime() async {
    int locationIndex = await getLocationIndex() ?? 0;
    WorldTime instance = locations[locationIndex];
    await instance.getTime();
    location = instance.location;
    flag = instance.flag;
    time = instance.time;
    isDayTime = instance.isDayTime;
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
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
      backgroundColor: Colors.teal[800],
      body: const Center(
        child: SpinKitWave(  // https://pub.dev/packages/flutter_spinkit
          color: Colors.white,
          size: 50.0,
        )
      ),
    );
  }
}
