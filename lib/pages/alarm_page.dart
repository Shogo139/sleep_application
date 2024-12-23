import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../alarm_page/add_alarm.dart';
import '../sleeping.dart';
import 'graph_page.dart';

class AlarmPage extends StatefulWidget {
  final List<Map<String, dynamic>> alarms;
  final List<List<FlSpot>> graphHistory;

  const AlarmPage({super.key, required this.alarms, required this.graphHistory});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アラーム'),
        leading: widget.alarms.isNotEmpty
            ? TextButton(
          onPressed: () {
            setState(() {
              isEditing = !isEditing;
            });
          },
          child: Text(
            isEditing ? '完了' : '編集',
            style: const TextStyle(color: Colors.black),
          ),
        )
            : null,
        actions: [
          IconButton(
            onPressed: () async {
              final newAlarm = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAlarmPage()),
              );

              if (newAlarm != null) {
                setState(() {
                  widget.alarms.add({...newAlarm, 'enabled': false});
                });
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: widget.alarms.isEmpty
          ? const Center(child: Text('アラームがありません'))
          : ListView.builder(
        itemCount: widget.alarms.length,
        itemBuilder: (context, index) {
          final alarm = widget.alarms[index];
          return ListTile(
            title: Text('${alarm['time']} - ${alarm['label']}'),
            trailing: isEditing
                ? IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.alarms.removeAt(index);
                });
              },
            )
                : Switch(
              value: alarm['enabled'],
              onChanged: (value) async {
                setState(() {
                  widget.alarms[index]['enabled'] = value;
                });
                if (value) {
                  final graphData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SleepingPage(),
                    ),
                  );
                  if (graphData != null) {
                    setState(() {
                      widget.alarms[index]['enabled'] = false; // スイッチをオフ
                      widget.graphHistory.insert(0, graphData); // 新しいデータを先頭に追加
                      if (widget.graphHistory.length > 15) {
                        widget.graphHistory.removeLast(); // 最大15件保持
                      }
                    });
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
