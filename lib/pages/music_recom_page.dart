import 'package:flutter/material.dart';

class MusicRecomPage extends StatelessWidget {
  const MusicRecomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Recommendation"),
      ),
      body: const Center(
        child: Text("Music Recommendation Page"),
      ),
    );
  }
}
