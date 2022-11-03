import 'package:flutter/material.dart';
import 'package:trinity_w/helper/design.dart';
import 'package:trinity_w/view/contacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trinity W',
      theme: ThemeData(
        primarySwatch: AppDesign.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const ShowContacts(),
      // home: const EditContacts(),
    );
  }
}