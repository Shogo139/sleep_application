import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepGraphDrawer {
  List<FlSpot> sleepData = [];

  //データの追加
  void addData (double timeElapsed, double acceleration) {
    sleepData.add(FlSpot(timeElapsed, acceleration));
  }

  Widget buildGraph() {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: sleepData,
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            isStrokeCapRound: true,
          ),
        ],
        //titlesData: FlTitlesData(
          //leftTitles: SideTitles(showTitles: true),
          //bottomTitles: SideTitles(showTitles: true),
        //),
      ),
    );
  }
}
