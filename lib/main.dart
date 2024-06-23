import 'package:flutter/material.dart';
import 'package:flutter_item_tracker/presentation/screen/item_tracker_screen.dart';
import 'package:provider/provider.dart';

import 'presentation/controller/item_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ItemTrackerScreen(),
    );
  }
}
