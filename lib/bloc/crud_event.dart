import 'dart:io';

abstract class CrudEvent {}

class ReadEvent extends CrudEvent {}

class CreateEvent extends CrudEvent {
  final File file;

  CreateEvent({required this.file});
}

class DeleteEvent extends CrudEvent {
  // final String path;
  final int index;

  DeleteEvent({required this.index});
}
