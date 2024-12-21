import 'package:flutter/material.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('グラフページ'),
      ),
      body: const Center(
        child: Text('グラフの表示'),
      ),
    );
  }
}
