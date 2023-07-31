import 'package:flutter/material.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:my_app/providers/fetch_weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fetchedData;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchData(); // TODO: Geolocator
  }

  Future<void> _getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      // TODO: Handle if not given permission
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
      });
    }
  }

  Future<void> _fetchData() async {
    try {
      String data = await fetchWeatherData();
      setState(() {
        fetchedData = data;
      });
    } catch (e) {
      setState(() {
        fetchedData = 'Error fetching data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              fetchedData != null
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        fetchedData!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : Container(),
              currentPosition != null
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Position: $currentPosition',
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : Container(),
            ]),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
