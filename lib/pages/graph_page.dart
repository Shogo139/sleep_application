import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphPage extends StatefulWidget {
  final List<List<FlSpot>> graphHistory;

  const GraphPage({super.key, required this.graphHistory});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  int currentIndex = 0;

  void showPreviousGraph() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void showNextGraph() {
    if (currentIndex < widget.graphHistory.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reversing the graphHistory so newer data is displayed to the right
    final currentGraphData = widget.graphHistory.reversed.toList()[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('睡眠データ'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: showPreviousGraph,
                color: currentIndex < widget.graphHistory.length - 1
                    ? Colors.grey
                    : Colors.black, // Disable when at the oldest graph
              ),
              Text('データ ${widget.graphHistory.length - currentIndex} / ${widget.graphHistory.length}'),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: showNextGraph,
                color: currentIndex > 0 ? Colors.grey : Colors.black, // Disable when at the newest graph
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 300, // Fixed graph height
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentGraphData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}