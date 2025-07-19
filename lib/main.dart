import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_2/View/home.dart';
import 'package:task_2/widges/add_witch_list.dart';
import 'package:task_2/widges/upgrade.dart';

void main() {
  runApp(WatchList());
}

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "Insert": (context) => AddWatchList(),
        "home": (context) => WatchListView(),
        "update": (context) => UpgradeWatchList(),
      },
      home: WatchListView(),
      theme: ThemeData(primarySwatch: Colors.grey),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

