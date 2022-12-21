import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_styles.dart';
import '../../widgets/PHYACT/Recommended_activities(phy).dart';
import '../../widgets/PHYACT/add_botton_routine(phy).dart';
import '../../widgets/PHYACT/Routines_created(phy).dart';
import '../HomePage.dart';

class CreateRoutineP01 extends StatelessWidget {
  const CreateRoutineP01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(99,105,150,1.0),
        body: ListView(
          children: [
            const Gap(20),

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
                              Text("DIAB-TREK", style: Styles.headlineStyle2.copyWith(color: Colors.white,fontSize: 25),),
                              Gap(1),
                              Text("Physical Routine", style: Styles.headlineStyle4.copyWith(color: Colors.white),)
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/icon/option02.png",
                                      ))),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Gap(55),
                Container(
                    height: 700,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    child: Routine()
                  ),
          ],

        ),
        floatingActionButton: AddTodoButton(),
      ),
    );
  }
}
