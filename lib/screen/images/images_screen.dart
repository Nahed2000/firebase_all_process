import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_all_process/bloc/crud_event.dart';
import 'package:firebase_all_process/bloc/crud_state.dart';
import 'package:firebase_all_process/bloc/image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/helper.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helper {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ImageBloc>(context).add(ReadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        title: const Text(
          'Images Screen',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, 'uploadImagesScreen'),
              icon: const Icon(Icons.camera))
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<ImageBloc, CrudState>(
          listener: (context, state) {
            state as ProcessState;
            showSnackBar(
                context: context, message: state.message, error: state.status);
          },
          listenWhen: (previous, current) =>
              current is ProcessState &&
              current.processType == ProcessType.delete,
          buildWhen: (previous, current) =>
              current is ReadState || current is LoadingState,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ),
              );
            } else if (state is ReadState && state.data.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      FutureBuilder<String>(
                          future: state.data[index].getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              return CachedNetworkImage(
                                imageUrl: snapshot.data!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            } else {
                              return const Icon(Icons.warning_amber,
                                  color: Colors.red);
                            }
                          }),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            // borderRadius: BorderRadius.circular(25)),
                          ),
                          height: 50,
                          // width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.data[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _deleteImage(index: index),
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: state.data.length,
              );
            } else {
              return const Center(child: Text("Don't have any Image"));
            }
          },
        ),
      ),
    );
  }

  _deleteImage({required int index}) {
    BlocProvider.of<ImageBloc>(context).add(DeleteEvent(index: index));
  }
}
