import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定ページ'),
      ),
      body: const Center(
        child: Text('設定画面'),
      ),
    );
  }
}
