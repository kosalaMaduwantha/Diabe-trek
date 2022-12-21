import 'package:diabe_trek/screens/HomePage.dart';
import 'package:diabe_trek/widgets/PHYACT/add_botton_recommed(phy).dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_styles.dart';
import '../../widgets/PHYACT/Recommended_activities(phy).dart';
import '../../widgets/PHYACT/Recommended_activities_form(phy).dart';
import '../../widgets/PHYACT/add_botton_routine(phy).dart';
import '../../widgets/PHYACT/Routines_created(phy).dart';
import '../../widgets/PHYACT/checkboxRoutine.dart';

class CreateRoutineP04 extends StatelessWidget {
  const CreateRoutineP04({Key? key}) : super(key: key);

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
                              Gap(10),
                              Text("CREATE NEW ROUTINE", style: Styles.headlineStyle4.copyWith(color: Colors.white),)
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
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)
                      )
                    ),
                    child: RoutineReg()
                  ),
          ],

        ),

      ),
    );
  }
}
