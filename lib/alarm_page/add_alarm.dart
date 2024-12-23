import 'package:flutter/material.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _repeat = false;
  String _label = '';
  bool _snooze = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アラームを追加'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: const Text('アラーム時間'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (time != null) {
                    setState(() {
                      _selectedTime = time;
                    });
                  }
                },
              ),
            ),
            SwitchListTile(
              title: const Text('繰り返し'),
              value: _repeat,
              onChanged: (value) {
                setState(() {
                  _repeat = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'ラベル'),
              onChanged: (value) {
                _label = value;
              },
            ),
            SwitchListTile(
              title: const Text('スヌーズ'),
              value: _snooze,
              onChanged: (value) {
                setState(() {
                  _snooze = value;
                });
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // 保存ボタンを少し上に配置
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'time': _selectedTime.format(context),
                    'repeat': _repeat,
                    'label': _label.isEmpty ? 'アラーム' : _label,
                    'snooze': _snooze,
                    'enabled': true,
                  });
                },
                child: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
