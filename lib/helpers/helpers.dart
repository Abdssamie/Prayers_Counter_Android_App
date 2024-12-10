import 'package:flutter/cupertino.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:url_launcher/url_launcher.dart';


void toggleTheme(BuildContext context) {
  final currentMode = AdaptiveTheme.of(context).mode;

  if (currentMode == AdaptiveThemeMode.light) {
    AdaptiveTheme.of(context).setDark();
  } else {
    AdaptiveTheme.of(context).setLight();
  }

}

Future<void> launchGooglePlay(String packageName) async {
  final Uri url = Uri.parse("market://details?id=$packageName");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
  else {
    throw Exception("Could not launch $url");
  }
}


