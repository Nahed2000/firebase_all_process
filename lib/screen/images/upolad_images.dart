import 'dart:io';

import 'package:firebase_all_process/bloc/crud_event.dart';
import 'package:firebase_all_process/bloc/crud_state.dart';
import 'package:firebase_all_process/bloc/image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/helper.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({Key? key}) : super(key: key);

  @override
  State<UploadImagesScreen> createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> with Helper {
  XFile? _pikedImage;
  late ImagePicker imagePicker;
  double? _loadIndicator = 0;

  @override
  void initState() {
    // TODO: implement initState
    imagePicker = ImagePicker();
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
          'Upload Images Screen',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocListener<ImageBloc,CrudState>(
        listenWhen: (previous, current) =>
            current is ProcessState &&
            current.processType == ProcessType.create,
        listener: (context, state) {
          state as ProcessState;
          _changeLoadIndicator(value: state.status ? 1 : 0);
          showSnackBar(
              context: context, message: state.message, error: !state.status);
        },
        child: Column(
          children: [
            LinearProgressIndicator(
              color: Colors.green,
              backgroundColor: Colors.green.shade100,
              minHeight: 5,
              value: _loadIndicator,
            ),
            Expanded(
              child: _pikedImage == null
                  ? Center(
                      child: IconButton(
                          onPressed: () async => await pikImage(),
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 48,
                            color: Colors.blueGrey,
                          )),
                    )
                  : Image.file(File(_pikedImage!.path)),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.cloud_upload,
                color: Colors.black,
              ),
              onPressed: () => performImageUpload(),
              label: const Text(
                'Upload Images',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 75),
                  backgroundColor: Colors.blueGrey.shade300),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pikImage() async {
    XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera, maxHeight: 300);
    if (image != null) {
      setState(() {
        _pikedImage = image;
      });
    }
  }

  void performImageUpload() {
    print('*****');
    print(checkData());
    if (checkData()) {
      uploadImage();
    }
  }

  bool checkData() {
    if (_pikedImage != null) {
      return true;
    }
    showSnackBar(
        context: context,
        message: 'Please Select Image to Upload',
        error: true);
    return false;
  }

  void uploadImage() {
    _changeLoadIndicator();
    BlocProvider.of<ImageBloc>(context)
        .add(CreateEvent(file: File(_pikedImage!.path)));
  }

  void _changeLoadIndicator({double? value}) {
    setState(() {
      _loadIndicator = value;
    });
  }
}
