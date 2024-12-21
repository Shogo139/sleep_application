import 'package:flutter/material.dart';
import 'graph_page.dart';
import 'list_page.dart';
import 'settings_page.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            print('編集ボタンが押されました');
          },
          child: const Text(
            '編集',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('+ボタンが押されました');
            },
            icon: const Icon(Icons.add, color: Colors.black),
          ),
        ],
        title: const Text(
          'アラーム',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'アラームの一覧の表示',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
