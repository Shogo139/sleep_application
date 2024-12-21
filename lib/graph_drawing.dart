import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepGraphDrawer {
  List<FlSpot> allData = [];
  bool isZoomedOut = false;
  double? fixedMaxX;

  // データの追加
  void addData(double timeElapsed, double acceleration) {
    allData.add(FlSpot(timeElapsed, acceleration));
  }

  // データのリセット
  void clearData() {
    allData.clear();
    fixedMaxX = null;
    isZoomedOut = false;
  }

  void toggleZoom() {
    isZoomedOut = !isZoomedOut;
    if (isZoomedOut && fixedMaxX == null) {
      fixedMaxX = allData.isNotEmpty ? allData.last.x : 10;
    }
  }

  Widget buildGraph() {
    List<FlSpot> sleepData = isZoomedOut
        ? allData
        : allData.length > 50
        ? allData.sublist(allData.length - 50)
        : allData;

    double maxX = isZoomedOut
        ? (fixedMaxX ?? (sleepData.isNotEmpty ? sleepData.last.x : 10))
        : (sleepData.isNotEmpty ? sleepData.last.x : 10);
    double minX = isZoomedOut ? 0 : (maxX - 10);
    double maxY = 20.0;
    double minY = 0.0;

    return LineChart(
      LineChartData(
        backgroundColor: Colors.grey[200],
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: sleepData,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            isStrokeCapRound: true,
          ),
        ],
      ),
    );
  }
}
