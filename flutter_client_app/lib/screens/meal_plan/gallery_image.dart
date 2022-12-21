import 'dart:io';
import 'package:flutter/material.dart';

class DisplayGalleryImage extends StatelessWidget {
  final String? imagePath;

  const DisplayGalleryImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DFU Photo')),
      body: Image.file(File(imagePath!)),
      // floatingActionButton: ElevatedButton.icon(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push();
      //   },
      //   icon: const Icon(
      //     Icons.analytics_outlined,
      //     size: 20.0,
      //   ),
      //   label: const Text('Analyze Image'),
      // ),
    );
  }
}
