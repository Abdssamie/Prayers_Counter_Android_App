import 'package:flutter/material.dart';
import 'package:official_official_official/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:official_official_official/helpers/helpers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userInput = '';


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    const darkModeText = "Dark Mode";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          "Settings",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 27,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 8, 10),
                child: Icon(
                  Icons.dark_mode_sharp,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(18, 10, 0, 10),
                child: Text(
                  textAlign: TextAlign.start,
                  darkModeText,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                child: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    toggleTheme(context);
                    themeProvider.toggleTheme();
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.green,
                  inactiveTrackColor: Colors.white,
                ),
              ),
            ]),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Enter Text'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _userInput = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You entered: $_userInput')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
            OutlinedButton(
                onPressed: () {
                  AdaptiveTheme.of(context).setDark();
                },
                child: const Text(""))
          ],
        ),
      ),
    );
  }
}
