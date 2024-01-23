import 'package:flutter/material.dart';
import 'package:gundappana_kruti/services/shared_pref.dart';

class KaggaScreen extends StatefulWidget {
  const KaggaScreen({super.key});

  @override
  State<KaggaScreen> createState() => _KaggaScreenState();
}

class _KaggaScreenState extends State<KaggaScreen> {
  final sizedBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    // Data from caller page
    Map data = ModalRoute.of(context)?.settings.arguments as Map;

    final kagga = data["kagga"];

    debugPrint("Length: ${kagga.tatparya.toString().length}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Kagga ${kagga.id.toString().replaceAll("_mk", "")}"), // Add the kagga Number and Mankutimma before it
        actions: <Widget>[
          IconButton(
            icon: Icon(SharedPreferencesManager().isFavKey(kagga.id.toString()) ? Icons.favorite_rounded : Icons.favorite_outline_rounded),
            onPressed: () {
              final isFav =
                  SharedPreferencesManager().isFavKey(kagga.id.toString());

              if (isFav) {
                SharedPreferencesManager().delFavKey(kagga.id.toString());
              } else {
                SharedPreferencesManager().addFavKey(kagga.id.toString());
              }

              setState(() {});
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bodyText(kagga.kaggaKannada),
              sizedBox,
              kagga.tatparya.toString().length <= 1 ? const SizedBox(height: 0) :  headingText("ಭಾವಾರ್ಥ"),
              kagga.tatparya.toString().length <= 1 ? const SizedBox(height: 0) :  bodyText(kagga.tatparya),
              sizedBox,
              headingText("Transliteration"),
              bodyText(kagga.kaggaEnglish),
              sizedBox,
              headingText("ವಾಚ್ಯಾರ್ಥ"),
              bodyText(kagga.meaningKannada),
              sizedBox,
              headingText("ವ್ಯಾಖ್ಯಾನ"),
              bodyText(kagga.vyakhyana),
              sizedBox        
            ],
          ),
        ),
      ),
    );
  }

  Widget headingText(String text){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.redAccent,
          // fontWeight: FontWeight.bold,
          fontSize: 14
        ),
      ),
    );
  }

  Widget bodyText(String text){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16
        ),
      ),
    );
  }
}
