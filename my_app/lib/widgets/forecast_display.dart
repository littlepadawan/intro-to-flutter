import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/forecast_data.dart';

class ForecastDisplay extends StatelessWidget {
  final List<ForecastDay> forecastDays;

  const ForecastDisplay({Key? key, required this.forecastDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTileTheme(
      data: ExpansionTileThemeData(
        tilePadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 8), // Padding around each tile
        backgroundColor: Colors.white, // Color of the expanded tile
        collapsedBackgroundColor: Colors.white,
      ),
      child: ListView.builder(
        itemCount: forecastDays.length,
        padding: EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) {
          ForecastDay forecastDay = forecastDays[index];
          if (forecastDay.entries.isEmpty) {
            return Container();
          }

          return ExpansionTile(
            title: Text(
              DateFormat('EEEE, MMMM d').format(forecastDay.date),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            initiallyExpanded: true,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Time',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child:
                              Text('Temp. °C', style: TextStyle(fontSize: 14)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Prob. precip. %',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Wind(Gust) m/s',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ...forecastDay.entries.map((entry) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                  DateFormat('h:mm a').format(entry.time),
                                  style: TextStyle(fontSize: 14))),
                          Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/weather_icons/${entry.icon}.png',
                                height: 52,
                                width: 52,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text('${entry.temperature}°',
                                  style: TextStyle(fontSize: 14))),
                          Expanded(
                              flex: 3,
                              child: Text(
                                '${entry.pop}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.right,
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                '${entry.windSpeed} (${entry.windGust})',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.right,
                              )),
                          Expanded(
                            flex: 1,
                            child: Transform.rotate(
                              angle: entry.windDeg *
                                  (pi / 180), // Transform to radians
                              child: Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
