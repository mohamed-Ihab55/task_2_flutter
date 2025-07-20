import 'package:flutter/material.dart';
import 'package:task_2/sql/sqldb.dart';

class UpgradeWatchList extends StatefulWidget {
  const UpgradeWatchList({
    super.key,
    this.title,
    this.id,
    this.type,
    this.category,
  });
  final title;
  final id;
  final type;
  final category;
  @override
  State<UpgradeWatchList> createState() => _UpgradeWatchListState();
}

@override
class _UpgradeWatchListState extends State<UpgradeWatchList> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController category = TextEditingController();
  @override
  void initState() {
    title.text = widget.title;
    type.text = widget.type;
    category.text = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit The Movie"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'Title of the Movie',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xffADAEBC),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    controller: type,
                    decoration: InputDecoration(
                      hintText: 'Type',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xffADAEBC),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    controller: category,
                    decoration: InputDecoration(
                      hintText: 'Category',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xffADAEBC),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  GestureDetector(
                    onTap: () async {
                      int response = await sqlDb.updateData(
                        '''UPDATE WatchList SET title="${title.text}",
                        type="${type.text}", category="${category.text}" WHERE id = ${widget.id}''',
                      );
                      if (response > 0) {
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                      print(response);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Text(
                          "Update The Movie",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
