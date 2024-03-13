import 'package:flutter/material.dart';
import 'package:notes_app_withsqllite/add_notes.dart';
import 'package:notes_app_withsqllite/sqldb.dart';
import 'package:notes_app_withsqllite/update_notes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  List<Map> note = [];
  Future readData() async {
    // List<Map> response = await sqlDb.readData('SELECT * FROM notes');
     List<Map> response = await sqlDb.read('notes');
    note.addAll(response);
    if (this.mounted) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNotes(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Container(
        child: ListView(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: note.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                        title: Text("${note[i]['title']}"),
                        subtitle: Text("${note[i]['note']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  // int response = await sqlDb.deleteData(
                                  //     'Delete FROM notes WHERE id=${note[i]['id']} ');
                                  int response=await sqlDb.delete('notes', 'id=${note[i]['id']}');
                                  if (response > 0) {
                                    note.removeWhere((element) =>
                                        element['id'] == note[i]['id']);
                                    setState(() {});
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Home()));
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => UpdateNotes(
                                        oldTitle: note[i]['title'],
                                        oldNote: note[i]['note'],
                                        oldColor: note[i]['color'],
                                        id: note[i]['id'],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                          ],
                        )),
                  );
                })
          ],
        ),
      )),
    );
  }
}
