import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
//Class - different, method
//instance - different data;

class worker {
  //Constructor
  late String location;
  worker({required this.location}) {
    location = this.location;
  }
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  Future<void> getData() async {
    //Get Data

    try {
      // String city_name ;
      String url =
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=f0b129415dade6178f618894ca7e4d61";
      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      // Getting Temp,Humidity
      Map temp_data = data['main'];
      double get_temp = temp_data['temp'] - 273.15;
      String get_humidity = temp_data['humidity'].toString();

      //Getting Speed
      Map wind = data['wind'];
      double get_air_speed = wind['speed'] * 3.6;

      //Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String get_min_des = weather_main_data['main'];
      String get_desc = weather_main_data['description'];
      String get_icon = weather_main_data['icon'];
      //Assingning Value
      temp = get_temp.toStringAsFixed(1); //C
      humidity = get_humidity; //%
      air_speed = get_air_speed.toStringAsFixed(1); //Km/hr
      description = get_desc; //String
      main = get_min_des; //String
      icon = get_icon.toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't Find the Data";
      main = "Can't Find the Data";
      icon = "03n";
    }
  }
}
