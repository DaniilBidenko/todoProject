import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiagramTwoWidget extends StatefulWidget {
  const DiagramTwoWidget({Key? key}) : super(key: key);

  @override
  _DiagramTwoWidget createState() => _DiagramTwoWidget();
}

class _DiagramTwoWidget extends State<DiagramTwoWidget> {
  late int showingTooltip;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 50
        ),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 25,
                  left: 40
                ),
                child: Text('Распределение по приоритетам'),
                ),
                Padding(
                  padding: EdgeInsets.only(

                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                        child: AspectRatio(
                          aspectRatio: 2,
                            child: BarChart(
                              BarChartData(
                                barGroups: [
                                  generateGroupData(1, 10),
                                  generateGroupData(2, 18),
                                  generateGroupData(3, 4),
                                ],
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    handleBuiltInTouches: false,
                                    touchCallback: (event, response) {
                                      if (response != null && response.spot != null && event is FlTapUpEvent) {
                                        setState(() {
                                          final x = response.spot!.touchedBarGroup.x;
                                          final isShowing = showingTooltip == x;
                                        if (isShowing) {
                                          showingTooltip = -1;
                                        } else {
                                          showingTooltip = x;
                                        }
                                        });
                                      }
                                    },
                                  mouseCursorResolver: (event, response) {
                                    return response == null || response.spot == null
                                      ? MouseCursor.defer
                                        : SystemMouseCursors.click;
                                    }
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  )
            ],
          ),
        ),
        );
  }
}