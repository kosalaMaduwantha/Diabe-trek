// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_styles.dart';
import '../HomePage.dart';
import 'DPN_q10.dart';

class dpn_q9 extends StatelessWidget {
  const dpn_q9({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(15,52,106,1.0),
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
                          Gap(5),
                          Text("Diabetic Peripheral Neuropathy Analysis", style: Styles.headlineStyle4.copyWith(color: Colors.white),),
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
            Gap(160),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                children: [
                  Text("DPN Risk Detection", style: Styles.headlineStyle2.copyWith(color: Colors.white,fontSize: 30),),

                ],
              ),
            ),
            Gap(25),
            Container(

              height: 500,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  )
              ),

              child: Column(
                children: [
                  Gap(35),
                  Container(
                    child: Text("Do you feel any pain in your legs?", style: Styles.headlineStyle1.copyWith(fontSize: 23),),

                  ),
                  Gap(55),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(50,1,100,25),
                          child: FlatButton(
                            child: Text('Yes', style: TextStyle(fontSize: 20.0),),
                            color: Colors.blueGrey,
                            textColor: Colors.white,
                            onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const dpn_q10()));
                            },
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(10,1,50,25),
                          child: FlatButton(
                            child: Text('No', style: TextStyle(fontSize: 20.0),),
                            color: Colors.blueGrey,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const dpn_q10()));
                            },
                          ),
                        ),
                      ]
                  )








                ],
              ),
            ),
          ],

        ),

      ),
    );
  }
}
