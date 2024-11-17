import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:official_official_official/helpers.dart';
import 'package:official_official_official/green_colors_scheme.dart';
import 'package:flutter/widgets.dart';

void main() async {
  // Ensure all bindings are initialized before AdaptiveTheme.
  WidgetsFlutterBinding.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final isDarkMode = AdaptiveThemeMode.dark == savedThemeMode;
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(
      savedThemeMode: savedThemeMode,
      isDarkMode: isDarkMode,
      sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final bool? isDarkMode;
  final SharedPreferences? sharedPreferences;

  const MyApp({
    super.key,
    this.savedThemeMode,
    this.isDarkMode,
    this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
              title: 'Flutter Android Application',
              theme: theme,
              home: const MainApp(),
            ));
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  final List<Map<String, dynamic>> moreDestinations = [
    {'icon': Icons.view_list_outlined, 'label': 'Ahadith'},
    {'icon': Icons.mosque_outlined, 'label': 'Nearby Mosques'},
    {'icon': Icons.settings_outlined, 'label': 'Settings'},
  ];
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData kaaba = IconData(0xf66b, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  int currentPageIndex = 0;
  int _counter = 0;
  String? _selectedAdhkar;
  final List<String> _adhkarList = [
    'SubhanAllah',
    'Alhamdulillah',
    'Allahu Akbar',
    // Add more adhkars here
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentMode = AdaptiveTheme.of(context).mode;
    var isDarkMode = currentMode == AdaptiveThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getCardColor(isDarkMode),
        title: const Text(
          'Salati Jannati',
          style: TextStyle(
            fontFamily: 'IBMPlexSansArabic',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      drawer: Drawer(
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Container(
            alignment: Alignment.center,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const Image(
                      image:
                          AssetImage("assets/images/mosque-building-fund.jpeg"),
                    );
                  case 1:
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainApp()),
                        );
                      },
                      leading: const Icon(Icons.home,
                          size: 30.0, color: Colors.deepOrange),
                      title: const Text(
                        "Home",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    );
                  case 2:
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdhkarPage()),
                        );
                      },
                      leading: const Icon(Icons.auto_stories,
                          size: 30.0, color: Colors.deepOrange),
                      title: const Text(
                        "Adhkar",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    );
                  case 3:
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()),
                        );
                      },
                      leading: const Icon(Icons.settings,
                          size: 30.0, color: Colors.deepOrange),
                      title: const Text(
                        "Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    );
                  case 4:
                    return ListTile(
                      leading: const Icon(Icons.star_rate,
                          size: 30.0, color: Colors.deepOrange),
                      title: GestureDetector(
                        onTap: () => launchGooglePlay("com.facebook.katana"),
                        child: const Text(
                          "Rate us",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 20,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 90,
        indicatorColor: getFontColor(isDarkMode),
        destinations: [
          NavigationDestination(
            tooltip: "Tooltip test",
            selectedIcon: Icon(Icons.mosque_outlined,
              size: 35, color: getBackgroundColor(isDarkMode)
            ),
            icon: Icon(Icons.mosque_outlined,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'Salat times',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.format_list_bulleted_outlined,
              size: 33, color: getBackgroundColor(isDarkMode)
            ),
            icon: Icon(Icons.format_list_bulleted_outlined,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'Adhkar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_book_outlined,
              size: 33, color: getBackgroundColor(isDarkMode)
            ),
            icon: Icon(Icons.menu_book_outlined,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'Quran',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.more,
              size: 33, color: getBackgroundColor(isDarkMode)
            ),
            icon: Icon(Icons.more,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'More',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: getCardColor(isDarkMode),
        animationDuration: const Duration(milliseconds: 700),
      ),
      body: [
        const Center(),
        const Center(),
        const Center(),
        const Center(),
      ][currentPageIndex],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userInput = '';
  late SharedPreferences? _prefs;

  // TODO: Fix bugs about widget inheritance and global state management
  // TODO: Try to use Provider or StreamBuilder for better state management

  @override
  Widget build(BuildContext context) {
    const darkModeText = "Dark Mode";
    bool isDarkMode = AdaptiveThemeMode.dark == AdaptiveTheme.of(context).mode;
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
                    isDarkMode = AdaptiveThemeMode.dark ==
                        AdaptiveTheme.of(context).mode;
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

class AdhkarPage extends StatefulWidget {
  const AdhkarPage({super.key});

  @override
  AdhkarPageState createState() => AdhkarPageState();
}

class AdhkarPageState extends State<AdhkarPage> {
  final List<String> adhkarList = const [
    "SubhanAllah",
    // Glory be to Allah (Recite 33 times)
    "Alhamdulillah",
    // All praise is due to Allah (Recite 33 times)
    "Allahu Akbar",
    // Allah is the Greatest (Recite 34 times)
    "La ilaha illallah",
    // There is no god but Allah
    "Astaghfirullah",
    // I seek forgiveness from Allah
    "SubhanAllahi wa bihamdihi, SubhanAllahil Azeem",
    // Glory be to Allah and praise Him, glory be to Allah, the Supreme.
    "Bismillah",
    // In the name of Allah
    "La hawla wa la quwwata illa billah",
    // There is no power and no strength except with Allah
    "Hasbiyallahu la ilaha illa Huwa",
    // Allah is sufficient for me; there is no deity except Him.
    "Radheetu billahi Rabba wa bil Islami deena wa bi Muhammadin Nabiyya",
    // I am pleased with Allah as my Lord, with Islam as my religion, and with Muhammad as my Prophet.
    "Allahumma inni as’aluka al-'afiyah",
    // O Allah, I ask You for health and safety.
    "Allahumma salli ala Muhammad wa ala aali Muhammad",
    // O Allah, send blessings upon Muhammad and the family of Muhammad.
    "Ya Hayyu Ya Qayyum, bi rahmatika astagheeth",
    // O Ever-Living, O Sustainer, in Your mercy, I seek relief.
    "Allahumma inni a'udhu bika min al-hammi wal-hazan",
    // O Allah, I seek refuge in You from worry and grief.
    "Rabbi zidni ilma",
    // My Lord, increase me in knowledge.
    "SubhanAllahi wa bihamdihi, 'adada khalqihi, wa ridha nafsihi",
    // Glory be to Allah and His praise, as numerous as His creation and as much as He is pleased.
    "Ya Allah, Ya Rahman, Ya Raheem",
    // O Allah, O Merciful, O Compassionate
    "Rabbi habli min ladunka rahmah",
    // My Lord, grant me mercy from Your presence.
    "Allahumma la sahla illa ma ja'altahu sahla",
    // O Allah, there is no ease except what You make easy.
    "Ameen",
    // Amen
    "Allahumma inni as'aluka al-jannah",
    // O Allah, I ask You for Paradise.
    "Allahumma inni a’udhu bika min ‘adhab al-qabr",
    // O Allah, I seek refuge in You from the torment of the grave.
    "Rabbi inni lima anzalta ilayya min khayrin faqir",
    // My Lord, I am in need of whatever good You send down to me.
    "La ilaha illa anta subhanaka inni kuntu minaz-zalimeen",
    // There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers.
    "Astaghfirullaha rabbi min kulli dhambin",
    // I seek forgiveness from my Lord for all sins.
    "Allahumma ajirni min an-nar",
    // O Allah, save me from the Fire.
    "Allahumma innaka 'afuwwun tuhibbul-'afwa fa'fu 'anni",
    // O Allah, You are forgiving and love forgiveness, so forgive me.
    "Bismillahilladhi la yadurru ma’ ismihi shay’un",
    // In the name of Allah, with whose name nothing in the heavens or the earth can cause harm.
    "Alhamdulillah allathee at'amana wa saqana",
    // Praise be to Allah who fed us and gave us drink.
    "Ya Muqallib al-qulub, thabbit qalbi ala deenik",
    // O Turner of the hearts, make my heart firm upon Your religion.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adhkar"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
          child: Scrollbar(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: adhkarList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.fiber_manual_record),
                        title: Text(adhkarList[index]),
                        tileColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[200]
                                : Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                        style: ListTileStyle.drawer,
                      ),
                    );
                  }))),
    );
  }
}
