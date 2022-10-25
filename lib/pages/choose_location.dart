import 'package:flutter/material.dart';

import '../services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime('London', 'uk.png', 'Europe/London'),
    WorldTime('Athens', 'greece.png', 'Europe/Berlin'),
    WorldTime('Cairo', 'egypt.png', 'Africa/Cairo'),
    WorldTime('Nairobi', 'kenya.png', 'Africa/Nairobi'),
    WorldTime('Chicago', 'usa.png', 'America/Chicago'),
    WorldTime('New York', 'usa.png', 'America/New_York'),
    WorldTime('Jakarta', 'indonesia.png', 'Asia/Jakarta'),
    WorldTime('Seoul', 'south_korea.png', 'Asia/Seoul'),
  ];

  void updateTime(index) async {
    WorldTime worldTime = locations[index];
    await worldTime.getTime();
    Navigator.pop(context, {
      'time': worldTime.time,
      'location': worldTime.location,
      'flag': worldTime.flag,
      'isDayTime': worldTime.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick a Location"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[850],
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  tileColor: Colors.grey[800],
                  onTap: () => updateTime(index),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        "resources/images/countries/${locations[index].flag}"),
                  ),
                  title: Text(
                    "${locations[index].location}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
