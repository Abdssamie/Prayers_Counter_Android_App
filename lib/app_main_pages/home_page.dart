import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../helpers/geo_locator.dart';
import 'package:official_official_official/providers/theme_provider.dart';
import 'package:adhan/adhan.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import '../helpers/green_colors_scheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _latitude = 36.7783; // default to california
  double _longitude = 119.4179; // default to california
  String _statusMessage = "Fetching location...";  // Status message
  Map<String, String> prayersTimes = {"fajr":"","sunrise":"","dhuhr":"","asr":"","maghrib":"","isha":""};

  @override
  void initState() {
    super.initState();
    _requestLocationAccess(); // requests location access if not provided
    fetchAndUsePrayerTimes();
  }


  // Call the determinePosition function
  Future<Map<String, String>> _getCurrentLocationAndPrayerTimes() async {
    try {
      Position position = await determinePosition(); // This will only run when the location permission is given
      _latitude = position.latitude.toDouble();
      print(_latitude);
      _longitude = position.longitude.toDouble();
      print(_longitude);

      // Update the state with the fetched location
      setState(() {
        _statusMessage = "Location fetched: ($_latitude, $_longitude)";
      });

      final myCoordinates = Coordinates(_latitude, _longitude); // Replace with your own location lat, lng.
      final params = CalculationMethod.karachi.getParameters();
      print(params);
      params.madhab = Madhab.hanafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      print(prayerTimes);

      print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
      String fajr_time = DateFormat.jm().format(prayerTimes.fajr);
      String sunrise_time = DateFormat.jm().format(prayerTimes.sunrise);
      String dhuhr_time = DateFormat.jm().format(prayerTimes.dhuhr);
      String asr_time = DateFormat.jm().format(prayerTimes.asr);
      String maghrib_time = DateFormat.jm().format(prayerTimes.maghrib);
      String isha_time = DateFormat.jm().format(prayerTimes.isha);

      print(fajr_time);
      print(sunrise_time);
      print(dhuhr_time);
      print(asr_time);
      print(maghrib_time);
      print(isha_time);

      Map<String, String> prayerTimes_ = {
        "fajr": fajr_time,
        "sunrise": sunrise_time,
        "dhuhr": dhuhr_time,
        "asr": asr_time,
        "maghrib": maghrib_time,
        "isha": isha_time,
  };

      return prayerTimes_; // Now you can return the prayer_times
    } catch (e) {
      // Handle errors
      setState(() {
        _statusMessage = e.toString();
      });
      return {"fajr":"","sunrise":"","dhuhr":"","asr":"","maghrib":"","isha":""}; // Return a list of empty strings in case of an error
    }
  }

  Future<void> _requestLocationAccess() async {
    PermissionStatus status = await Permission.location.request();

    try {
      if (status.isGranted) {
        print("Permission Granted");
      }
      else if (status.isDenied || status.isPermanentlyDenied) {
        print("Permission Denied");
      }
      else if(status.isRestricted) {
        print("Permission Restricted");
      }

    } catch (e) {
        print(e.toString());
    }

  }

  void fetchAndUsePrayerTimes() async {
    try {
      Map<String, String> prayersTimes_ = await _getCurrentLocationAndPrayerTimes();

      // Now you can use the prayerTimes list
      print("Prayer Times: $prayersTimes_");
      setState(() {
        prayersTimes = prayersTimes_;
      });
    } catch(e) {
      print("Error fetching Time: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _requestLocationAccess(),
        child: const Icon(Icons.local_library_outlined),
      ),
      body: Container(
        decoration:
          BoxDecoration(
            image: DecorationImage(
              opacity: isDarkMode ? 0.5:1,
              fit: BoxFit.cover,
              image: const AssetImage('assets/images/mosque-4134459_1920.jpg'),
            )
          ),
        child: ListView(
          children: prayersTimes.entries.map<Widget>((entry) {
            return ListTile(
              title: Text(
                entry.key,
                style: TextStyle(
                  color: getFontColor(isDarkMode),
                ),
              ),
              subtitle: Text(entry.value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
