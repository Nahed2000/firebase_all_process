import 'package:firebase_all_process/firebase/controller/fb_firestore_controller.dart';
import 'package:firebase_all_process/model/notes.dart';
import 'package:firebase_all_process/util/helper.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.note}) : super(key: key);
  final Notes? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helper {
  late TextEditingController titleController;
  late TextEditingController infoController;

  @override
  void initState() {
    // TODO: implement initState
    titleController = TextEditingController(text: widget.note?.title);
    infoController = TextEditingController(text: widget.note?.info);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          getTitleScreen(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Title',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                )),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: infoController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'info',
              prefixIcon: const Icon(Icons.info),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async => await _performSave(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }

  String getTitleScreen() => noteIsNull() ? 'Create Note' : 'Update Note';

  Future<void> _performSave() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (titleController.text.isNotEmpty && infoController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter Required Data..!', error: true);
    return false;
  }

  Future<void> save() async {
    bool status = noteIsNull()
        ? await FbFireStoreController().create(notes: notes)
        : await FbFireStoreController().update(notes: notes);
    String message = status ? 'Note Saved Successfully' : 'Note Saved Failed';
    showSnackBar(context: context, message: message, error: !status);
    if (noteIsNull()) {
      _clear();
    } else {
      Navigator.pop(context);
    }
  }

  void _clear() {
    titleController.text = '';
    infoController.text = '';
  }

  Notes get notes {
    Notes note = noteIsNull() ? Notes() : widget.note!;
    note.title = titleController.text;
    note.info = infoController.text;
    return note;
  }

  bool noteIsNull() => widget.note == null;
}
