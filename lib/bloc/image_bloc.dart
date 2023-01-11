import 'package:firebase_all_process/bloc/crud_state.dart';
import 'package:firebase_all_process/firebase/controller/fb_firestorge_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'crud_event.dart';

class ImageBloc extends Bloc<CrudEvent, CrudState> {
  ImageBloc(CrudState initialState) : super(initialState) {
    on<CreateEvent>(createEvent);
    on<DeleteEvent>(deleteEvent);
    on<ReadEvent>(readEvent);
  }

  final FireStorageController _fireStorageController = FireStorageController();
  List<Reference> ref = <Reference>[];

  void createEvent(CreateEvent event, Emitter emit) async {
    UploadTask uploadTask = _fireStorageController.create(file: event.file);
    await uploadTask.snapshotEvents.listen((TaskSnapshot event) {
      if (event.state == TaskState.success) {
        ref.add(event.ref);
        emit(ProcessState(
            processType: ProcessType.create,
            message: 'Image Upload Successfully',
            status: true));
        emit(ReadState(data: ref));
      } else if (event.state == TaskState.error) {
        emit(ProcessState(
            processType: ProcessType.create,
            message: 'Image Upload Failed',
            status: false));
      }
    }).asFuture();
  }

  void deleteEvent(DeleteEvent event, Emitter emit) async {
    // bool status = await _fireStorageController.delete(path: event.path);
    // if (status) {
    //   int index = ref.indexWhere((element) => element.fullPath == event.path);
    //   if (index != -1) {
    //     ref.removeAt(index);
    //   }
    // }
    bool deleted =
        await _fireStorageController.delete(path: ref[event.index].fullPath);
    if (deleted) {
      ref.removeAt(event.index);
      emit(ReadState(data: ref));
    }
    String message =
        deleted ? 'Image Successfully Deleted' : 'Image Deleted Failed!';
    emit(ProcessState(
        processType: ProcessType.delete, message: message, status: deleted));
  }

  void readEvent(ReadEvent event, Emitter emitter) async {
    ref = await _fireStorageController.read();
    emitter(ReadState(data: ref));
  }
}
