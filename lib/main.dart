import 'package:flutter/material.dart';

void main() {
  runApp(const AlarmApp());
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlarmApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AlarmPage(),
    );
  }
}

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
              fontSize: 16,
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                print('アイコン1が押されました');
              },
              icon: const Icon(Icons.alarm, size: 30),
            ),
            IconButton(
              onPressed: () {
                print('アイコン2が押されました');
              },
              icon: const Icon(Icons.access_time, size: 30),
            ),
            IconButton(
              onPressed: () {
                print('アイコン3が押されました');
              },
              icon: const Icon(Icons.bedtime, size: 30),
            ),
            IconButton(
              onPressed: () {
                print('アイコン4が押されました');
              },
              icon: const Icon(Icons.settings, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
