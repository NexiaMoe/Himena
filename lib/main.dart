import 'package:nexiamoe_eighteen/global/PublicDrawer.dart';
import 'package:nexiamoe_eighteen/screen/newUpload.dart';
import 'package:flutter/material.dart';

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
    return const Scaffold(
      drawer: PublicDrawer(),
      body: NewUpload(),
    );
  }
}
