import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/View/home.dart';
import 'package:task_2/themes/theme_provider.dart';
import 'package:task_2/widges/add_witch_list.dart';
import 'package:task_2/widges/upgrade.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: WatchList(),
    ),
  );
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
      initialRoute: "home",
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
