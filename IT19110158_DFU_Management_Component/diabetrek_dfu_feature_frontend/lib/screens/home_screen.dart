// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:diabetrek_dfu_feature_frontend/screens/news_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:diabetrek_dfu_feature_frontend/screens/camera_screen.dart';
import 'package:diabetrek_dfu_feature_frontend/screens/gallery_image.dart';
import 'package:diabetrek_dfu_feature_frontend/routes/screen_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DFU Selfcare Feature')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(20),
              Container(child: const NewsInfo()),
              const Gap(30),
              Row(children: [
                const Gap(20.0),
                Container(
                  child: (ElevatedButton.icon(
                    onPressed: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(firstCamera),
                        ),
                      );
                    },
                    icon: const Icon(Icons.camera, size: 20.0),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200.0, 200.0),
                        textStyle: const TextStyle(fontSize: 15),
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
                    label: const Text('Capture A Photo'),
                  )),
                ),
                const Gap(10.0),
                Container(
                  child: (ElevatedButton.icon(
                    onPressed: () async {
                      final image = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      setState(() {});

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DisplayGalleryImage(imagePath: image?.path),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.image_search_rounded,
                      size: 20.0,
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200.0, 200.0),
                        textStyle: const TextStyle(fontSize: 15),
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
                    label: const Text('Upload From Gallery'),
                  )),
                ),
              ]),
              const Gap(10.0),
              Container(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(createRoute());
                  },
                  icon: const Icon(
                    Icons.history_edu_rounded,
                    size: 20.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(400.0, 160.0),
                      textStyle: const TextStyle(fontSize: 15),
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
                  label: const Text('Wound History'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
