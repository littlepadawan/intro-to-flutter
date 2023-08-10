import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/forecast_data.dart';

class ForecastDisplay extends StatelessWidget {
  final List<ForecastDay> forecastDays;

  const ForecastDisplay({Key? key, required this.forecastDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: forecastDays.length,
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
              children: forecastDay.entries.map((entry) {
                return ListTile(
                  leading:
                      Image.asset('assets/weather_icons/${entry.icon}.png'),
                  title: Text(
                    DateFormat('h:mm a').format(entry.time),
                  ),
                  subtitle: Text(
                    '${entry.temperature} °C - ${entry.weatherDescription}',
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
