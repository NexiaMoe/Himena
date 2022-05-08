import 'package:NexiaMoe_EighTeen/global/PublicDrawer.dart';
import 'package:NexiaMoe_EighTeen/screen/animeInfo.dart';
import 'package:NexiaMoe_EighTeen/screen/newUpload.dart';
import 'package:flutter/foundation.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NexiaMoe EighTeen',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'NexiaMoe EighTeen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PublicDrawer(),
      body: NewUpload(),
    );
  }
}
