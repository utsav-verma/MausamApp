// ignore_for_file: await_only_futures
import 'package:mausam/Worker/worker.dart';
import 'dart:convert';
import 'dart:ffi' hide Size;
import 'dart:math';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Async - Funnction Starts early but return is delayed
  //Future.delayed - Function start after some delay.
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    var city_name = ["Mubai", "Delhi", "Kolkata", "Indore", "Praygraj"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    String icon = info['icon_value'];
    String get_city = info['city_value'];
    String air = info['air_speed_value'];
    String desc = info['desc_value'];
    String main = info['main_value'];
    String hum = info['hum_value'];
    String temp = info['temp_value'];
    print(desc);
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: AppBar(
      //     backgroundColor: Color.fromARGB(255, 127, 177, 239),
      //   ),
      // ),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: NewGradientAppBar(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [Colors.cyan, Color.fromARGB(255, 144, 202, 249)]),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // stops: [0.1,0.9],
                    colors: [
                  Color.fromARGB(255, 21, 101, 192),
                  Color.fromARGB(255, 100, 181, 246)
                ])),
            child: Column(children: <Widget>[
              Container(
                ///Search Wala Container

                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      print(searchController.text);
                      if ((searchController.text).replaceAll(" ", "") == "") {
                        print("Blank Search");
                      } else {
                        Navigator.pushReplacementNamed(context, "/loading",
                            arguments: {"searchText": searchController.text});
                      }
                    },
                    child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search $city",
                      ),
                    ),
                  ),
                ]),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Row(children: [
                        Image.network(
                            "https://openweathermap.org/img/wn/$icon@2x.png"),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "$main",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("In $get_city",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcon.getIcon('wi-thermometer')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$temp",
                                style: TextStyle(fontSize: 70),
                              ),
                              Text(
                                "C",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(29),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcon.getIcon('wi-cloudy-windy')),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "$air",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text("km/hr"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 200,
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(29),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcon.getIcon('wi-humidity')),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "$hum",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "%",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Column(children: [
                  Text("Made By Utsav"),
                  Text("Data Provided By Openweathermap.org"),
                ]),
              ),
              SizedBox(
                height: 70,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
