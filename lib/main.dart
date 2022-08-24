import 'dart:async';
import 'dart:developer';

import 'package:aveonotification/aveonotification.dart';
import 'package:aveonotificationtest/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  FcmNotification(
      serverKey:
          'AAAAxywvjj8:APA91bHwkjy9JabmTxHVx9fx6n_oqrIBGVweEQALNeg6mUFHj-kPsrgicOjpAYnVqjrbKLJ96ywpvByVijr_eDX6zVXhN-U0NR3AKmcw3q1nBEDaAsuTE3lGMx4TCLouWQAZ5hSdP-zq');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int counter = 0;

  void _incrementCounter() {
    setState(() {});
  }

  void startTimer() {
    Stream<int> stream =
        Stream.periodic(Duration(seconds: 1), (t) => t + 1).take(10);
    stream.listen((event) {
      print('object-------' + event.toString());
    });
    Timer.periodic(const Duration(seconds: 1), (t) {
      counter = t.tick;
      if (t.tick == 10) {
        startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}