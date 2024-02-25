import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const GamerDiary());
}

class GamerDiary extends StatelessWidget {
  const GamerDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamer Diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(
      ),
    );
  }
}

