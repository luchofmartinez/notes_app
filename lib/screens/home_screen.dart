import 'package:flutter/material.dart';

import 'package:notes_app/models/note.dart';
import 'package:notes_app/provider/db_provider.dart';
import 'package:notes_app/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas"),
        actions: [Container()],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey,
        child: const NotesList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(115, 84, 122, 1),
        onPressed: () => Navigator.pushNamed(context, '/agregar').then((value) {
          setState(() {});
        }),
        child: const Icon(
          Icons.note_add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

}

class NotesList extends StatefulWidget { 
 
  const NotesList({
    Key? key, 
  }) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> { 
  List<Note> listadoNotas = [];

  @override
  void initState() {
    super.initState();
    initDb();
    getNotas(); 
  } 

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  void getNotas() async {
    await DatabaseRepository.instance.getAllTodos().then((value) {
      setState(() {
        listadoNotas = value;
      });
    });
  }

  void _deleteNote(Note pNota) {
    setState(() {
      //notes.removeWhere((element) => element == pNota);
    });
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
            children: [
              listadoNotas.isNotEmpty
                  ? ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listadoNotas.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _buildNotes(
                            pNote: listadoNotas[index],
                            functionCallback: _deleteNote,
                          ),
                        );
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text("Sin notas aun"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildNotes extends StatefulWidget {
  final Note pNote;
  final Function(Note) functionCallback;

  const _buildNotes({
    Key? key,
    required this.pNote,
    required this.functionCallback,
  }) : super(key: key);

  @override
  State<_buildNotes> createState() => _buildNotesState();
}

class _buildNotesState extends State<_buildNotes> {
  late Note note;

  @override
  void initState() {
    super.initState();
    note = widget.pNote;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onLongPress: () {
                showDialog(
                  barrierDismissible: false,
                  useSafeArea: true,
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                        child: const Text("Si"),
                        onPressed: () {
                          setState(() {
                            widget.functionCallback(note);
                          });
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    title: const Center(child: Text("Eliminando nota")),
                    content: const Text("¿Estas seguro de borrar esta nota?"),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotaScreen.edit(note),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.35,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          note.descripcion,
                          maxLines: 2,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
