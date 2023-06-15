import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('David', 25),
      ChartData('David', 5),
    ];
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
      series: <CircularSeries>[
        RadialBarSeries<ChartData, String>(
            maximumValue: 50,
            gap: '10%',
            radius: '90%',
            trackBorderWidth: 10,
            cornerStyle: CornerStyle.bothCurve,
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ],
      title: ChartTitle(text: 'HI'),
      legend: Legend(
        isVisible: true,
      ),
    ))));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
