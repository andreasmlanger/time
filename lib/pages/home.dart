import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    final routeArguments = ModalRoute.of(context)?.settings.arguments;
    data = data.isNotEmpty ? data : routeArguments as Map<String, dynamic>? ?? {};

    // Set background
    String bgImage = data['isDayTime'] ? 'day.webp' : 'night.webp';
    Color? bgColor = data['isDayTime'] ? Colors.pink[700] : Colors.blueGrey[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: const TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data['time'],
                    style: const TextStyle(
                      fontSize: 128.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 500.0),
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                        'Change Location',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 20.0,
                        )
                    ),
                  ),
                ]
              ),
            ),
          )
      ),
    );
  }
}
