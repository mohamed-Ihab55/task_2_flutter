import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2/sql/sqldb.dart';
import 'package:task_2/themes/theme_provider.dart';
import 'package:task_2/widges/upgrade.dart';

class WatchListView extends StatefulWidget {
  const WatchListView({super.key});

  @override
  State<WatchListView> createState() => _WatchListViewState();
}

class _WatchListViewState extends State<WatchListView> {
  SqlDb sqlDb = SqlDb();
  List watchList = [];
  bool isLoading = true;
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM WatchList");
    watchList.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'My Watch List',
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Icon(Icons.dark_mode),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: ListView(
          children: [
            ListView.builder(
              itemCount: watchList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    title: Text(
                      "${watchList[i]['title']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    subtitle: Text(
                      "${watchList[i]['type']} / ${watchList[i]['category']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpgradeWatchList(
                                  title: watchList[i]['title'],
                                  type: watchList[i]['type'],
                                  id: watchList[i]['id'],
                                  category: watchList[i]['category'],
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            int response = await sqlDb.deleteData(
                              "DELETE FROM WatchList WHERE id=${watchList[i]['id']}",
                            );
                            if (response > 0) {
                              watchList.removeWhere(
                                (element) =>
                                    element['id'] == watchList[i]['id'],
                              );
                              setState(() {});
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          Navigator.of(context).pushNamed("Insert");
        },
        tooltip: 'Insert',
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }
}
