// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:diabe_trek/screens/meal_plan/fooditem-card.dart';
import 'package:diabe_trek/services/mealplanning-service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import 'package:diabe_trek/screens/meal_plan/news_info_widget.dart';
import 'package:diabe_trek/screens/meal_plan/camera_screen.dart';
import 'package:diabe_trek/screens/meal_plan/gallery_image.dart';
import 'package:diabe_trek/routes/screen_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List<String> foodItemList = [
    'Bread',
    'Egg',
    'Meat',
    'Noodles-Pasta',
    'Rice',
    'Seafood',
    'Vegetable-fruit',
    'Soup'
  ];
  List<Image> foodItemImageList = [
    Image.asset('assets/images/bread.jpg', width: 80, height: 80),
    Image.asset('assets/images/egg.jpg', width: 80, height: 80),
    Image.asset('assets/images/meat.jpg', width: 80, height: 80),
    Image.asset('assets/images/noodles.jpg', width: 80, height: 80),
    Image.asset('assets/images/rice.jpg', width: 80, height: 80),
    Image.asset('assets/images/seafood.jpg', width: 80, height: 80),
    Image.asset('assets/images/soup.jpg', width: 80, height: 80),
    Image.asset('assets/images/vegetable.jpg', width: 80, height: 80),
  ];
  List<String> selectedFoodItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DFU Selfcare Feature')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                // Container(child: const NewsInfo()),
                Text(
                  "Select Food Item",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                Container(
                  height: 500,
                  child: ListView.builder(
                      itemCount: foodItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FoodItemCard(
                          image: foodItemImageList[index],
                          foodItemName: foodItemList[index],
                          callback: (foodItemName, val) {
                            if(val == true){
                              setState(() {
                                selectedFoodItems.add(foodItemName);
                              });
                            }else{
                              setState(() {
                                selectedFoodItems.remove(foodItemName);
                              });
                            }
                          }
                        );
                      }),
                ),
                const Gap(30),
                Container(
                  child: (ElevatedButton.icon(
                    onPressed: () {
                      new MealPlanningService().sendFoodItems(selectedFoodItems);
                      //print(selectedFoodItems);
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 20.0,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(18.0),
                      ),
                    ),
                    label: const Text('Continue'),
                  )),
                ),
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
                          fixedSize: const Size(double.infinity, 80.0),
                          textStyle: const TextStyle(fontSize: 15),
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 10.0, 10.0, 10.0)),
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
                          fixedSize: const Size(double.infinity, 80.0),
                          textStyle: const TextStyle(fontSize: 15),
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 10.0, 10.0, 10.0)),
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
                        fixedSize: const Size(double.infinity, 80.0),
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
      ),
    );
  }
}
