import 'package:diabe_trek/screens/PHYACT/create_new_routine_p1(routines_created)(phy).dart';
import 'package:diabe_trek/utils/app_styles.dart';
import 'package:diabe_trek/widgets/news_slidder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'DPN/DPN_page01.dart';
import 'meal_plan/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const Gap(40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text("Diab-Trek", style: Styles.headlineStyle2,),
                        Gap(1),
                        Text("app", style: Styles.headlineStyle4,)
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/icon/option.png",
                              ))),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Gap(20),
          const news_widget(),
          Gap(50),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                Text("Components", style: Styles.headlineStyle3,)

              ],
            ),
          ),
          Gap(45),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateRoutineP01()));
                      },
                      child: Container(

                        height: 145,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.04, 0.04],
                              colors: [Color.fromRGBO(99,105,150,1.0),Colors.white]
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3), // changes position of shadow
                            ),

                          ],
                        ),
                        child: Column(
                          children: [
                            Gap(8),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/icon/physical_activity.png",
                                      ))),
                            ),
                            Text("Physical Activity", style: Styles.headlineStyle1.copyWith(fontSize: 15),),
                            Text("create your own physical", style: Styles.headlineStyle4.copyWith(fontSize: 10),),
                            Text("Activity Routine", style: Styles.headlineStyle4.copyWith(fontSize: 10),),

                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap:  () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const dpn_start()));
                          },
                      child: Container(

                        height: 145,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.04, 0.04],
                              colors: [Color.fromRGBO(8,100,150,1.0),Colors.white],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Gap(8),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/icon/dpn_home.PNG",
                                      ))),
                            ),
                            Text("DPN Classification", style: Styles.headlineStyle1.copyWith(fontSize: 15),),
                            Text("Find if you are at risk", style: Styles.headlineStyle4.copyWith(fontSize: 10),),
                            Text("Answer few questions", style: Styles.headlineStyle4.copyWith(fontSize: 10),),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 145,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.03, 0.03],
                          colors: [Color.fromRGBO(8,8,44,1.0),Colors.white],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(

                        children: [
                          Gap(8),
                          Container(
                            height: 55,
                            width: 55,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/icon/dfu_feature.jpg",
                                    ))),
                          ),
                          Text("DFU Selfcare", style: Styles.headlineStyle1.copyWith(fontSize: 15),),
                          Text("Know Your Wound", style: Styles.headlineStyle4.copyWith(fontSize: 10),),


                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: Container(
                        height: 145,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.03, 0.03],
                            colors: [Color.fromRGBO(8,8,44,1.0),Colors.white],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Gap(8),
                            Container(
                              height: 55,
                              width: 55,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/icon/meal.png",
                                      ))),
                            ),
                            Text("Meal Planning", style: Styles.headlineStyle1.copyWith(fontSize: 15),),
                            Text("Plan a healthy diet", style: Styles.headlineStyle4.copyWith(fontSize: 10),),


                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
