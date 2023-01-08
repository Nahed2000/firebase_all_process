// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_all_process/get/image_get_controller.dart';
//
// import '../../model/api_response.dart';
// import '../../util/helper.dart';
//
// class ImagesScreen extends StatefulWidget {
//   const ImagesScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ImagesScreen> createState() => _ImagesScreenState();
// }
//
// class _ImagesScreenState extends State<ImagesScreen> with Helper {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.blueGrey),
//         title: const Text(
//           'Images Screen',
//           style: TextStyle(
//             color: Colors.blueGrey,
//             fontSize: 18,
//           ),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () =>
//                   Navigator.pushNamed(context, 'uploadImagesScreen'),
//               icon: const Icon(Icons.camera))
//         ],
//       ),
//       body: SafeArea(
//         child: GetX<ImageGetxController>(
//           builder: (controller) {
//             // if (controller.loading.isTrue) {
//             //   return const Center(
//             //     child: CircularProgressIndicator(
//             //       color: Colors.blueGrey,
//             //     ),
//             //   );
//             // }
//             if (controller.imagesList.isNotEmpty) {
//               return GridView.builder(
//                 padding: const EdgeInsets.all(20),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemBuilder: (context, index) => Card(
//                   elevation: 4,
//                   clipBehavior: Clip.antiAlias,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Stack(
//                     children: [
//                       CachedNetworkImage(
//                         imageUrl: controller.imagesList[index].imageUrl,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) =>
//                                 CircularProgressIndicator(
//                                     value: downloadProgress.progress),
//                         errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.black26,
//                             // borderRadius: BorderRadius.circular(25)),
//                           ),
//                           height: 50,
//                           // width: double.infinity,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   controller.imagesList[index].image,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () async =>
//                                     await _deleteImage(index: index),
//                                 icon: Icon(Icons.delete),
//                                 color: Colors.red,
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 itemCount: controller.imagesList.length,
//               );
//             } else {
//               return const Center(child: Text("Don't have any Image"));
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> _deleteImage({required int index}) async {
//     ApiResponse response =
//     await ImageGetxController.to.deleteImage(index: index);
//     showSnackBar(context:context, message: response.message, error: !response.status);
//   }
// }
