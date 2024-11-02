import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure all bindings are initialized before AdaptiveTheme.
  WidgetsFlutterBinding.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final isDarkMode = AdaptiveThemeMode.dark == savedThemeMode;
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(savedThemeMode: savedThemeMode, isDarkMode: isDarkMode, sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final bool? isDarkMode;
  final SharedPreferences? sharedPreferences;

  const MyApp({super.key, this.savedThemeMode, this.isDarkMode, this.sharedPreferences});

  @override
  Widget build(BuildContext context) {

    return AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          title: 'Flutter Android Application',
          theme: theme,
          home: const HomeScreen(),
        )
    );
  }
}



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Showcase',
          style: TextStyle(
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Flutter!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ScaleTransition(
              scale: _animation,
              child: const FlutterLogo(size: 100),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailsScreen()),
                );
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userInput = '';
  late SharedPreferences _prefs;
  // TODO: Fix bugs about widget inheritance and global state management
  // TODO: Try to use Provider or StreamBuilder for better state management

  @override
  Widget build(BuildContext context) {
    const darkModeText = "الوضع الليلي";
    bool isDarkMode =  AdaptiveThemeMode.dark == AdaptiveTheme.of(context).mode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'عداد الأذكار',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      AdaptiveTheme.of(context).toggleThemeMode();
                      isDarkMode = AdaptiveThemeMode.dark == AdaptiveTheme.of(context).mode;
                    },
                    activeColor: Colors.black,
                    activeTrackColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      darkModeText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
            ),
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
                child: const Text("")
            )
          ],
        ),
      ),
    );
  }
}