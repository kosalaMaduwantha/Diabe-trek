// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_styles.dart';
import '../HomePage.dart';
import 'DPN_q2.dart';
import 'package:http/http.dart' as http;

class dpn_q1 extends StatefulWidget {
  const dpn_q1({Key? key}) : super(key: key);

  @override
  State<dpn_q1> createState() => _dpn_q1();

  void setState(Null Function() param0) {}
}

class _dpn_q1 extends State<dpn_q1> {
  Map<String, dynamic> _rectDPN = {};

  void main(String preg) async {

    http.Response response = await postActs(preg);



    Map<String, dynamic> data = json.decode(response.body);

    setState(() {
      _rectDPN = data;
    });

    print(_rectDPN);
  }



  Future<http.Response> postActs(String preg) {
    return http.post(
      Uri.parse('http://192.168.8.101:3000/put_entry_rec/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "Pregnancies":preg,

      }),
    );

  }


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
                  Gap(55),
                  Container(
                    child: Text("Are you pregnant?", style: Styles.headlineStyle2.copyWith(color: Colors.blueGrey,fontSize: 30),),

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
                            onPressed: () {
                              main("Yes");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const dpn_q2()));

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
                              main("No");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const dpn_q2()));
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
