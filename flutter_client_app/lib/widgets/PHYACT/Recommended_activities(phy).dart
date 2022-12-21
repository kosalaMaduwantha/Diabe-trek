import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:diabe_trek/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../screens/PHYACT/create_new_routine_p3(recommend act form).dart';

class RecommendedActs extends StatefulWidget {
  RecommendedActs({Key? key}) : super(key: key);



  // The function that fetches data from the API


  @override
  State<RecommendedActs> createState() => _RecommendedActs();

  void setState(Null Function() param0) {}
}

class _RecommendedActs extends State<RecommendedActs> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");
      main();
    });

  }

  List _rectActs = [];

  void main() async {
    http.Response response = await getActs();

    List data = json.decode(response.body);

    setState(() {
      _rectActs = data;
    });

    print(data);
  }



  Future<http.Response> getActs() {
    return http.get(
      Uri.parse('http://152.67.160.154:5000/get_activities_key/?u_id=1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );

  }


  @override
  Widget build(BuildContext context) {



    return Container(

        child: SafeArea(
            child: _rectActs.isEmpty
                ?Text("empty"):ListView.builder(
              padding: EdgeInsets.only(bottom: 15),
              itemCount: _rectActs.length+1,
              itemBuilder: (context, index) => (index != _rectActs.length)
                ? ListTile(
                  title: Text(_rectActs[index]["activity"],style: Styles.headlineStyle2.copyWith(fontWeight: FontWeight.w400),),
                  subtitle:
                  Text('description: ${_rectActs[index]["activity"]}'),
                trailing: Icon(Icons.more_vert),
                ): ListTile(

                leading:  SizedBox(
                  height: 65,
                  child: ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateRoutineP03()));
                      },
                    icon: Icon(Icons.save),  //icon data for elevated button
                    label: Text("     Recommend new physical activities             "), //label text
                    style: ElevatedButton.styleFrom(


                          primary: Color.fromRGBO(99,105,150,1.0) //elevated btton background color
                      ),
                     ),
                ),
              ),)

            ),

      
            
    );
  }
}



