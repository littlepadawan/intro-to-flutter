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
      data: const ExpansionTileThemeData(
        tilePadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        backgroundColor: Colors.white, // Color of the expanded tile
        collapsedBackgroundColor: Colors.white,
      ),
      child: ListView.builder(
        itemCount: forecastDays.length,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (context, index) {
          ForecastDay forecastDay = forecastDays[index];
          if (forecastDay.entries.isEmpty) {
            return Container();
          }

          return Day(date: forecastDay.date, entries: forecastDay.entries);
        },
      ),
    );
  }
}

class Day extends StatelessWidget {
  final DateTime date;
  final List<ForecastEntry> entries;

  const Day({Key? key, required this.date, required this.entries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        DateFormat('EEEE, MMMM d').format(date),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderElement(
                    flexAmount: 2,
                    content: 'Time',
                    alignRight: false,
                  ),
                  HeaderElement(
                    flexAmount: 2,
                    content: 'Temp. °C',
                    alignRight: false,
                  ),
                  HeaderElement(
                    flexAmount: 3,
                    content: 'Prob. precip. %',
                    alignRight: true,
                  ),
                  HeaderElement(
                    flexAmount: 3,
                    content: 'Wind(Gust) m/s',
                    alignRight: true,
                  ),
                ],
              ),
            ),
            const Divider(),
            ...entries.map((entry) {
              return Entry(entry: entry);
            }).toList(),
          ],
        ),
      ],
    );
  }
}

class HeaderElement extends StatelessWidget {
  final int flexAmount;
  final String content;
  final bool alignRight;

  const HeaderElement(
      {Key? key,
      required this.flexAmount,
      required this.content,
      required this.alignRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexAmount,
      child: Text(
        content,
        style: const TextStyle(fontSize: 14),
        textAlign: alignRight ? TextAlign.right : TextAlign.start,
      ),
    );
  }
}

class Entry extends StatelessWidget {
  final ForecastEntry entry;

  const Entry({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              DateFormat('h:mm a').format(entry.time),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/weather_icons/${entry.icon}.png',
              height: 52,
              width: 52,
            ),
          ),
          Expanded(
              flex: 1,
              child: Text('${entry.temperature}°',
                  style: const TextStyle(fontSize: 14))),
          Expanded(
            flex: 3,
            child: Text(
              '${entry.pop}',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${entry.windSpeed} (${entry.windGust})',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 1,
            child: Transform.rotate(
              angle: entry.windDeg * (pi / 180), // Transform to radians
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }
}
