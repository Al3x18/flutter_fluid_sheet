// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:fluid_sheet/fluid_sheet.dart';
import 'package:fluid_sheet/test_data/race_details_data.dart';
import 'package:fluid_sheet/test_data/example_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showSheet() {
    showFluidSheet(
      context: context,
      backgroundColor: Colors.white,
      useSafeArea: false,
      //builder: (context) => const RaceDetailsData(), // F1 Race details example
       builder: (context) => const ExampleContent(), // Simple content example
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Fluid Sheet Example')),
      body: Center(
        child: ElevatedButton(onPressed: _showSheet, child: const Text('Show Fluid Sheet')),
      ),
    );
  }
}