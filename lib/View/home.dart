import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_2/sql/sqldb.dart';

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
    isLoading=false;
    if (this.mounted) {
      setState(() {});
    }
  }

  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Watch List'), centerTitle: true),
      body: ListView(
        children: [
          ListView.builder(
            itemCount: snapshot.data!.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text("${snapshot.data![i]['title']}"),
                  subtitle: Text("${snapshot.data![i]['type']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          int response = await sqlDb.updateData(
                            "DELETE FROM WatchList WHERE id=${snapshot.data![i]['id']}",
                          );
                          if (response > 0) {
                            Navigator.of(context).pushReplacementNamed("home");
                          }
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          int response = await sqlDb.deleteData(
                            "DELETE FROM WatchList WHERE id=${snapshot.data![i]['id']}",
                          );
                          if (response > 0) {
                            Navigator.of(context).pushReplacementNamed("home");
                          }
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // ElevatedButton(onPressed: (){
          //   changeTheme();
          // }, child: Text('Light theme'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Navigator.of(context).pushNamed("Insert");
        },
        tooltip: 'Insert',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class ChangeTheme extends StatefulWidget {
//   const ChangeTheme({super.key});

//   @override
//   State<ChangeTheme> createState() => _ChangeThemeState();
// }

// class _ChangeThemeState extends State<ChangeTheme> {
//  ThemeMode _themeMode = ThemeMode.system;
//   void changeTheme(ThemeMode themeMode) {
//     setState(() {
//       _themeMode = themeMode;
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
  
// }
