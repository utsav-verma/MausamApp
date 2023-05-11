import 'package:flutter/material.dart';
import 'package:mausam/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String temp;
  late String hum;
  late String air_apeed;
  late String desc;
  late String main;
  late String icon;
  late String city = "Kolkata";
  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_apeed = instance.air_speed;
    desc = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/home", arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_apeed,
        "desc_value": desc,
        "main_value": main,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)!.settings.arguments as Map?;
    // city = "Kolkata";
    if (search != null) {
      city = search['searchText'];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 250),
              Image.asset("assets/images/logo.png", height: 240, width: 240),
              Text(
                "Mausam App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Made by Utsav",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              SpinKitWave(
                color: Colors.white,
                size: 35.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
