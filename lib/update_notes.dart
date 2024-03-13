import 'package:flutter/material.dart';
import 'package:notes_app_withsqllite/home.dart';
import 'package:notes_app_withsqllite/sqldb.dart';

class UpdateNotes extends StatefulWidget {
  const UpdateNotes(
      {super.key,
      required this.oldTitle,
      required this.oldNote,
      required this.oldColor,
      required this.id});
  final String oldTitle;
  final String oldNote;
  final String oldColor;
  final int id;
  @override
  State<UpdateNotes> createState() {
    return _UpdateNotes();
  }
}

class _UpdateNotes extends State<UpdateNotes> {
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
  void initState() {
    super.initState();
    textNote.text = widget.oldNote;
    textTitle.text = widget.oldTitle;
    textColor.text = widget.oldColor;
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
                              // int response = await sqlDb.updateData(
                              //     'UPDATE notes SET note="${textNote.text}" ,title=" ${textTitle.text}",color="${textColor.text}" WHERE id =${widget.id}');
                              int response=await sqlDb.update('notes',{
                                'title':textTitle.text,
                                'note':textNote.text,
                                'color':textColor.text
                              },"id=${widget.id}");
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
                              'Update Note',
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
