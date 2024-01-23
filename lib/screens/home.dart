import 'package:flutter/material.dart';
import 'package:gundappana_kruti/model/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gundappana_kruti/services/shared_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Box<Model> getBox() => Hive.box<Model>("hive_box");
}

class _HomePageState extends State<HomePage> {

  bool filterLike = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gundappana Kruti"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.favorite_outline_rounded,
              ),
              onPressed: () {

                filterLike = !filterLike;

                // SetState for changes to reflect
                setState(() {});
              },
            )
          ],
        ),
        body: ValueListenableBuilder<Box<Model>>(
          valueListenable: HomePage.getBox().listenable(),
          builder: (context, box, _) {
            final contents = box.values.toList().cast<Model>();
            var kaggas2List = <Model>[];

            for (var kagga in contents) {
              if (kagga.id.contains("mk") && (filterLike ? SharedPreferencesManager().isFavKey(kagga.id) : true)) {
                kaggas2List.add(kagga);
              }
            }

            // Sort by id
            kaggas2List.sort((a, b) => (int.parse(a.id.toString().replaceAll("_mk", "")).compareTo(int.parse(b.id.toString().replaceAll("_mk", "")))));

            return SingleChildScrollView(child: buildContent(kaggas2List, context));
          },
        ));
  }

  Widget buildContent(List kaggas, BuildContext context) {
    return Column(
      children: [
        for (final kagga in kaggas) buildCard(kagga, context),
        const SizedBox(height: 20)
      ],
    );
  }

  Widget buildCard(final kagga, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          debugPrint("Opening Kagga");
          Navigator.pushNamed(context, "/kagga", arguments: {"kagga": kagga});
        },
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                      child: Text(
                        kagga.id.toString().replaceAll("_mk", ""),
                        style: TextStyle(color: kagga.id.toString().contains("mk") ? Colors.redAccent : Colors.blueAccent)
                      ),
                    ),
                    Text(
                      kagga.kaggaKannada,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: (){
                    final isFav = SharedPreferencesManager().isFavKey(kagga.id.toString());

                    if(isFav){
                      SharedPreferencesManager().delFavKey(kagga.id.toString());
                    } else{
                      SharedPreferencesManager().addFavKey(kagga.id.toString());
                    }

                    setState(() {});
                  }, 
                icon: Icon(SharedPreferencesManager().isFavKey(kagga.id.toString()) ? Icons.favorite_rounded : Icons.favorite_outline_rounded))
              ]
            ),
          ),
        )
      ),
    );
  }
}
