import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(ReportsPage());
}

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Vibration Data Visualization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VibrationChart(),
    );
  }
}

class VibrationChart extends StatefulWidget {
  @override
  _VibrationChartState createState() => _VibrationChartState();
}

class _VibrationChartState extends State<VibrationChart> {
  List<FlSpot> xVibrationPoints = [];
  bool isLoading = true;
  List<List<dynamic>> rawData = [];
  int selectedRowCount = 30;  // Default value for rows to plot
  List<int> rowOptions = [10, 20, 50, 100, 200];  // Options for dropdown

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
  const url = 'http://10.0.2.2:5000/data';  // Use 10.0.2.2 for Android emulator to access localhost
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
        List<dynamic> dataList = jsonResponse['data'];
        rawData = List<List<dynamic>>.from(
          dataList.map((i) => [i['AccelerationX'], i['AccelerationY']])
        );
        printFirst30Rows(rawData);  // Debugging: Print the first 30 rows
        processAndDisplayData();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Data key not found');
      }
    } else {
      throw Exception('Failed to load data with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred while fetching data: $e');
    setState(() {
      isLoading = false;
    });
  }
}


 void processAndDisplayData() {
  List<FlSpot> points = [];
  int rowsToProcess = min(selectedRowCount, rawData.length);
  for (int i = 0; i < rowsToProcess; i++) {
    List<dynamic> item = rawData[i];
    double xValue = item[0];
    double yValue = item[1];
    points.add(FlSpot(xValue, yValue));
  }

  setState(() {
    xVibrationPoints = points;
  });
}



  void printFirst30Rows(List<List<dynamic>> data) {
    for (int i = 0; i < min(30, data.length); i++) {
      print('Row ${i + 1}: ${data[i]}');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Acceleration X vs Y')),
    body: isLoading
      ? Center(child: CircularProgressIndicator())
      : Column(
          children: [
            DropdownButton<int>(
              value: selectedRowCount,
              items: rowOptions.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value rows'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  selectedRowCount = newValue!;
                  processAndDisplayData();  // Recalculate with new row count
                });
              },
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: xVibrationPoints,
                        isCurved: true,
                        color: Colors.blue,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      )
                    ],
                    minX: 6.00,
                    maxX: 7.20,
                    minY: -2,  // Adjust based on your data range
                    maxY: 0,
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(value.toStringAsFixed(2)),
                              space: 8, // Adjust space depending on your layout
                            );
                          },
                          reservedSize: 40,
                          interval: 0.05,  // Specify the interval for labels
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(value.toStringAsFixed(1));
                          },
                          reservedSize: 32,
                          interval: 0.05,  // Adjust depending on the Y-axis data range
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}
}
