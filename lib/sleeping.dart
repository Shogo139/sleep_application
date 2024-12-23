import 'package:flutter/material.dart';
import 'sensor.dart';
import 'graph_drawing.dart';
import 'dart:async';

class SleepingPage extends StatefulWidget {
  const SleepingPage({super.key});

  @override
  SleepingPageState createState() => SleepingPageState();
}

class SleepingPageState extends State<SleepingPage> {
  double timeElapsed = 0.0;
  Timer? dataRecordingTimer;
  final SleepSensor sensorHelper = SleepSensor();
  final SleepGraphDrawer graphHelper = SleepGraphDrawer();
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  @override
  void dispose() {
    stopListening(); // 確実に停止させる
    super.dispose();
  }

  void startListening() {
    if (isListening) return;

    setState(() {
      isListening = true;
      timeElapsed = 0.0; // タイムリセット
      graphHelper.clearData(); // グラフデータをリセット
    });

    // センサーからデータを取得
    sensorHelper.listenToSensor((acceleration, isLightSleep) {
      if (!isListening) return; // 停止後にデータを受け取らないようにする
      setState(() {
        timeElapsed += 1.0;
        graphHelper.addData(timeElapsed, acceleration);
      });
    });

    // グラフの更新
    dataRecordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isListening) {
        timer.cancel();
        return;
      }
      setState(() {});
    });
  }

  void stopListening() {
    if (!isListening) return;

    setState(() {
      isListening = false; // リスニング状態を解除
    });

    sensorHelper.stopListening(); // センサーのリスニングを停止
    dataRecordingTimer?.cancel(); // Timerをキャンセル
    graphHelper.toggleZoom(); // ズーム状態をリセットまたは切り替え
    debugPrint('Listening stopped. Data collection halted.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アラーム中'),
      ),
      body: Column(
        children: [
          SizedBox(height: 300, child: graphHelper.buildGraph()),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0), // ボタン位置調整
            child: ElevatedButton(
              onPressed: () {
                stopListening(); // データ収集を停止
                Navigator.pop(context, graphHelper.allData); // グラフデータを返却
              },
              child: const Text('アラーム停止'),
            ),
          ),
        ],
      ),
    );
  }
}
