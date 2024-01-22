import 'package:flutter/material.dart';
import 'package:gundappana_kruti/model/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ValueListenableBuilder<Box<Model>>(
            valueListenable: getBox().listenable(),
            builder: (context, box, _) {
              final contents = box.values.toList().cast<Model>();
              var kaggas2List = <Model>[];

              for (var kagga in contents) {
                if (kagga.id.contains("mk")) {
                  kaggas2List.add(kagga);
                }
              }

              // Sort by id
              kaggas2List.sort((a, b) => a.id.compareTo(b.id));

              return buildContent(kaggas2List);
            },
          ),
        ));
  }

  static Box<Model> getBox() => Hive.box<Model>("hive_box");

  Widget buildContent(rituals) {
    return Center(child: Text("Nothing to show"));
  }
}
