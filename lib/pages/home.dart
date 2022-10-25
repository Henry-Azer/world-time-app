import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    var isDayTime = data['isDayTime'];
    String bgImage = isDayTime ? 'day' : 'night';
    Color? bgColor = isDayTime ? Colors.lightBlue[400] : Colors.black;
    Color fontColor = isDayTime ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('resources/images/$bgImage.jpg'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 0),
          child: Column(
            children: [
              TextButton.icon(
                  onPressed: () async {
                    var result = await Navigator.pushNamed(context, '/location') as Map;
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: fontColor,
                  ),
                  label: Text(
                    "Change Location",
                    style: TextStyle(color: fontColor, fontSize: 16.0),
                  )),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 38.0, letterSpacing: 2.0, color: fontColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Text(
                data['time'],
                style: TextStyle(fontSize: 60.0, color: fontColor),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
