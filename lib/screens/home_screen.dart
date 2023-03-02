// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  final noteList = Notes.nota;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey,
        child: NotesList(notes: noteList),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(115, 84, 122, 1),
        onPressed: () => Navigator.pushNamed(context, '/agregar'),
        child: const Icon(
          Icons.note_add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NotesList extends StatefulWidget {
  List<Note> notes;

  NotesList({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blueGrey[400],
          ),
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.notes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _buildNotes(
                      nota: widget.notes[index],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buildNotes extends StatefulWidget {
  Note nota;

  _buildNotes({
    Key? key,
    required this.nota,
  }) : super(key: key);

  @override
  State<_buildNotes> createState() => _buildNotesState();
}

class _buildNotesState extends State<_buildNotes> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotaScreen.edit(widget.nota),
                ));
              },
              child: SizedBox(
                height: 50,
                child: Center(child: Text(widget.nota.descripcion)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
