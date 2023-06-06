import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            launch('https://maps.google.com');
          },
          child: Text('Open Google Maps'),
          backgroundColor: Colors.red[600],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              launch('https://maps.google.com');
            },
            child: Text('Open Google Maps'),
          ),
        ),
      ),
    );
  }
}

