import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';

class NotaScreen extends StatelessWidget {
  final Note note;

  const NotaScreen({
    super.key,
    required this.note,
  });

  factory NotaScreen.edit(Note nota) {
    return NotaScreen(
      note: nota,
    );
  }

  factory NotaScreen.add() {
    return NotaScreen(
      note: Note(id: 0, descripcion: ''),
    );
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final noteController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nota - Nueva"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _formNewNote(formKey, noteController),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(115, 84, 122, 1),
        onPressed: () {
          Notes.nota.add(
            Note(id: Notes.nota.length, descripcion: noteController.text),
          );

          // Note(id: Notes.nota.length, descripcion: noteController.text),
          // )
          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        // : () {
        //     Notes.nota
        //             .where((element) => element.id == note.id)
        //             .first
        //             .descripcion ==
        //         noteController.text;
        //     Navigator.pushNamedAndRemoveUntil(
        //         context, '/home', (route) => false);
        //   },
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }

  Widget _formNewNote(
      GlobalKey<FormState> formKey, TextEditingController noteController) {
    if (note.descripcion.isNotEmpty || note.descripcion != '') {
      noteController.text = note.descripcion;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            maxLines: 10,
            controller: noteController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.blueGrey[100]!),
              ),
              hintText: "Escribe tu nota...",
              fillColor: Colors.blueGrey[300],
              filled: true,
            ),
            maxLength: 150,
          )
        ],
      ),
    );
  }
}

// class _formNewNote extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               maxLines: 10,
//               controller: noteController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide(color: Colors.blueGrey[100]!),
//                 ),
//                 hintText: "Escribe tu nota...",
//                 fillColor: Colors.blueGrey[300],
//                 filled: true,
//               ),
//               maxLength: 150,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
