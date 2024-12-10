import 'package:flutter/material.dart';
import 'package:official_official_official/helpers/green_colors_scheme.dart';
import 'package:provider/provider.dart';
import '../helpers/helpers.dart';
import 'package:official_official_official/providers/theme_provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: Center(
        child: Scrollbar(
          thickness: 6.0,  // Make scrollbar a bit thicker
          radius: const Radius.circular(10),  // Round the edges of the scrollbar
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: adhkarList.length,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey, // Divider between items
                height: 1,
                thickness: 1,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black54 : Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.fiber_manual_record),
                  title: Text(
                    adhkarList[index],
                    style: TextStyle(
                      color: getFontColor(isDarkMode),
                      fontSize: 16, // Clearer font size
                      fontWeight: FontWeight.w500, // Slightly bolder text
                    ),
                  ),
                  tileColor: getBackgroundColor(isDarkMode),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  style: ListTileStyle.drawer,
                ),
              );
            },
          ),
        ),
      )
    );
  }
}
