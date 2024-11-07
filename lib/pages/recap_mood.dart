import 'package:flutter/material.dart';

class RecapMoodPage extends StatelessWidget {
  const RecapMoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recap Mood"),
      ),
      body: const Center(
        child: Text("Recap Mood Page"),
      ),
    );
  }
}
