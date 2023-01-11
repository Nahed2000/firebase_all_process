import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_all_process/firebase/controller/fb_auth_acontroller.dart';
import 'package:firebase_all_process/firebase/controller/fb_firestore_controller.dart';
import 'package:firebase_all_process/model/fb_response.dart';
import 'package:firebase_all_process/util/helper.dart';
import 'package:flutter/material.dart';

import '../../model/notes.dart';
import 'note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notes Screen',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteScreen(),
                )),
            icon: Icon(Icons.note_add_outlined)),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'imagesScreen'),
              icon: Icon(Icons.camera)),
          IconButton(
              onPressed: () async {
                await FbAuthController().logout();
                Navigator.pushReplacementNamed(context, 'loginScreen');
              },
              icon: const Icon(Icons.logout)),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot<Notes>>(
        stream: FbFireStoreController().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(thickness: 5),
              padding: EdgeInsets.all(20),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    navigateToUpdateScreen(snapshot, index);
                  },
                  title: Text(snapshot.data!.docs[index].data().title),
                  subtitle: Text(snapshot.data!.docs[index].data().info),
                  trailing: IconButton(
                      onPressed: () async =>
                          delete(path: snapshot.data!.docs[index].id),
                      icon: const Icon(Icons.delete, color: Colors.red)),
                );
              },
            );
          } else {
            return const Center(child: Text("don't have any data ...!"));
          }
        },
      ),
    );
  }

  Future<void> delete({required String path}) async {
    bool deleted = await FbFireStoreController().delete(path: path);
    String message =
        deleted ? 'Delete Note Successfully' : 'Deleted Note Failed..!';
    if (deleted) {
      showSnackBar(context: context, message: message, error: !deleted);
    }
  }

  void navigateToUpdateScreen(
      AsyncSnapshot<QuerySnapshot<Notes>> snapshot, int index) {
    QueryDocumentSnapshot<Notes> noteSnapshot = snapshot.data!.docs[index];
    Notes note = noteSnapshot.data();
    note.id = noteSnapshot.id;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteScreen(
            note: note,
          ),
        ));
  }
}
