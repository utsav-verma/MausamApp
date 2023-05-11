import 'package:flutter/material.dart';
import 'package:mausam/Activity/home.dart';
import 'package:mausam/Activity/loading.dart';
// import 'package:mausam/Activity/location.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/loading': (context) => const Loading(),
    },
  ));
}
