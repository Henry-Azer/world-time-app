import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool isDayTime = false;

  WorldTime(this.location, this.flag, this.url);

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      DateTime dateTime = getDateTime(data);
      isDayTime = getIsDayTime(dateTime);
      time = DateFormat().add_jm().format(dateTime);
    } catch (exception) {
      if (kDebugMode) print("Caught error: $exception");
      time = "";
    }
  }

  DateTime getDateTime(Map data) {
    return DateTime.parse(data['datetime'])
        .add(Duration(hours: int.parse(data['utc_offset'].substring(1, 3))));
  }

  bool getIsDayTime(DateTime dateTime) {
    return dateTime.hour > 6 && dateTime.hour < 19;
  }
}
