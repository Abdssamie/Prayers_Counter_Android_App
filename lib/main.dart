import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:official_official_official/helpers/helpers.dart';
import 'package:official_official_official/app_main_pages/adhkar_screen.dart';
import 'package:official_official_official/app_main_pages/settings_page.dart';
import 'package:official_official_official/app_main_pages/home_page.dart';
import 'package:official_official_official/helpers/green_colors_scheme.dart';
import 'package:provider/provider.dart';
import 'package:official_official_official/providers/theme_provider.dart';


void main() async {
  // Ensure all bindings are initialized before AdaptiveTheme.
  WidgetsFlutterBinding.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final isDarkMode = AdaptiveThemeMode.dark == savedThemeMode;
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(isDarkMode: isDarkMode)),
      ],
      child: MyApp(
          savedThemeMode: savedThemeMode,
          isDarkMode: isDarkMode,
          sharedPreferences: sharedPreferences),
    ),
  );
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

  static const IconData kaaba =
      IconData(0xf66b, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  int currentPageIndex = 0;
  String? _selectedAdhkar;
  final List<String> _adhkarList = [
    'SubhanAllah',
    'Alhamdulillah',
    'Allahu Akbar',
    // Add more adhkars here
  ];


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    var isDarkMode = themeProvider.isDarkMode;

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
            child: Scrollbar(
              thumbVisibility: true, // Makes the scrollbar always visible
              thickness: 6.0, // Adjust the scrollbar's width
              radius: const Radius.circular(10), // Gives the scrollbar a rounded look
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const Placeholder();
                    case 1:
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MainApp()),
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
                            MaterialPageRoute(builder: (context) => const AdhkarPage()),
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
      ),
      bottomNavigationBar: NavigationBar(
        height: 75,
        indicatorShape: const StadiumBorder(),
        indicatorColor: getIndicatorColor(isDarkMode),
        destinations: [
          NavigationDestination(
            tooltip: "Tooltip test",
            selectedIcon: Icon(Icons.mosque_outlined,
                size: 35, color: getBackgroundColor(isDarkMode)),
            icon: Icon(Icons.mosque_outlined,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'Salat times',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.format_list_bulleted_outlined,
                size: 33, color: getBackgroundColor(isDarkMode)),
            icon: Icon(Icons.format_list_bulleted_outlined,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'Adhkar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_book_outlined,
                size: 33, color: getBackgroundColor(isDarkMode)),
            icon: Icon(Icons.menu_book_outlined,
                size: 30, color: getIconColor(isDarkMode)),
            label: 'Quran',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.more,
                size: 33, color: getBackgroundColor(isDarkMode)),
            icon: Icon(Icons.more, size: 30, color: getIconColor(isDarkMode)),
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
        const HomePage(),
        const AdhkarPage(),
        const Center(),
        const Center(),
      ][currentPageIndex],
    );
  }
}

