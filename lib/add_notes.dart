import 'package:flutter/material.dart';
import 'package:notes_app_withsqllite/home.dart';
import 'package:notes_app_withsqllite/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});
  @override
  State<AddNotes> createState() {
    return _AddNotes();
  }
}

class _AddNotes extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController textNote = TextEditingController();
  TextEditingController textTitle = TextEditingController();
  TextEditingController textColor = TextEditingController();
  @override
  void dispose() {
    textNote.dispose();
    textTitle.dispose();
    textColor.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: ListView(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: textTitle,
                        decoration: InputDecoration(
                            hintText: ('please enter your title'),
                            enabledBorder: borderDecoration(),
                            focusedBorder: borderDecoration()),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: textNote,
                        decoration: InputDecoration(
                            hintText: ('please enter your note'),
                            enabledBorder: borderDecoration(),
                            focusedBorder: borderDecoration()),
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: textColor,
                        decoration: InputDecoration(
                            hintText: ('please enter your subtitle'),
                            enabledBorder: borderDecoration(),
                            focusedBorder: borderDecoration()),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .7,
                        child: ElevatedButton(
                            onPressed: () async {
//                               int response = await sqlDb.insertData('''
// INSERT INTO notes('title','note','color') VALUES ('${textTitle.text}','${textNote.text}','${textColor.text}')
// ''');
int response=await sqlDb.insert('notes',{
  'title': textTitle.text,
  'note':textNote.text,
  'color':textColor.text
});
                              print('==================$response');
                              if (response > 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Home()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 63, 103, 184),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Add Note',
                              style: TextStyle(color: Colors.black),
                            )),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder borderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black),
    );
  }
}
