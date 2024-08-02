import 'package:flutter/material.dart';
import 'screens/stall_list_screen.dart';

void main() {
  runApp(GatherlyMediaApp());
}

class GatherlyMediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gatherly Media App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StallListScreen(),
    );
  }
}
