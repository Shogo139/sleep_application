import 'package:flutter/material.dart';
import 'sensor.dart';
import 'graph_drawing.dart';
import 'dart:async';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor and Graph test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SensorGraphScreen(),
    );
  }
}

class SensorGraphScreen extends StatefulWidget {
  const SensorGraphScreen({super.key});

  @override
  SensorGraphScreenState createState() => SensorGraphScreenState();
}

class SensorGraphScreenState extends State<SensorGraphScreen> {

  double timeElapsed = 0.0;
  Timer? dataRecordingTimer;
  final SleepSensor sensorHelper = SleepSensor();
  final SleepGraphDrawer graphHelper = SleepGraphDrawer();
  bool isListening = false;

  @override
  void dispose() {
    dataRecordingTimer?.cancel();
    super.dispose();
  }

  void startReading() {
    if (isListening) return;
    setState(() {
      isListening = true;
      timeElapsed = 0.0; // タイムリセット
      graphHelper.clearData(); // グラフデータをリセット

    });

    sensorHelper.listenToSensor((acceleration, isLightSleep) {
      setState(() {
        timeElapsed += 1.0;
        graphHelper.addData(timeElapsed, acceleration);
      });
    });

    dataRecordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });   //TimerでsetState()を1秒ごとに呼び出し
  }

  void stopReading() {
    if(!isListening) return;
    setState(() {
      isListening = false;
    });

    dataRecordingTimer?.cancel();
    graphHelper.toggleZoom();
    setState(() {});
  }


  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor and Graph Test'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: graphHelper.buildGraph(),
          ),
          const SizedBox(height: 20),
          Text(
            'Current Acceleration: ${sensorHelper.acceleration.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            sensorHelper.isLightSleep ? 'Light Sleep Detected' : 'Deep Sleep',
            style: TextStyle(fontSize: 18, color: sensorHelper.isLightSleep ? Colors.green : Colors.red),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isListening ? stopReading : startReading,
            child: Text(isListening ? '読み取り終了' : '読み取り開始'),
          ),
        ],
      ),
    );
  }
}
