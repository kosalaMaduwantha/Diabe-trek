import 'dart:convert';

import 'package:diabe_trek/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../screens/PHYACT/create_new_routine_p1(routines_created)(phy).dart';




class RoutineReg extends StatefulWidget {
  const RoutineReg({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<RoutineReg> {
  // Generate a list of available hobbies here
  TextEditingController calories = TextEditingController();
  TextEditingController no_hours = TextEditingController();
  //
  List<Map> PhyActs = [];
  List selectedItems = [];
  List _rectActs = [];

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

  void main() async {
    http.Response response = await getActs();

    List<Map> data = json.decode(response.body).cast<Map<dynamic, dynamic>>();

    setState(() {
      PhyActs = data;
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

  void reg(String act01, String act02, String act03, int no_hours, int trgCalories
      , int w_no, int y_of, int d_no, int m_of) async {

    http.Response response = await postActs(act01, act02, act03, no_hours, trgCalories,w_no, y_of, d_no, m_of);

    List data = json.decode(response.body);

    setState(() {
      _rectActs = data;
    });

    print(data);
  }

  Future<http.Response> postActs(String act01, String act02, String act03, int no_hours, int trgCalories
      , int w_no, int y_of, int d_no, int m_of) {
    return http.post(
      Uri.parse('http://152.67.160.154:5000/post_routines_per_day/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{

        "ac01":act01,
        "ac02":act02,
        "ac03":act03,
        "no_hours":no_hours,
        "target_calories":trgCalories,
        "week_no":w_no,
        "year_of":y_of,
        "day_no":d_no,
        "month_of":m_of

      }),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Select your preferred Activity',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

              // The checkboxes will be here
              Column(
                  children: PhyActs.map((act) {
                    return CheckboxListTile(
                        value: act["isChecked"],
                        title: Text(act["activity"]),
                        onChanged: (newValue) {
                          setState(() {
                            act["isChecked"] = newValue;
                          });
                        });
                  }).toList()),

              // Display the result here
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: PhyActs.map((act) {
                  if (act["isChecked"] == true) {
                    selectedItems.add(act["activity"]);

                    return Card(
                      elevation: 3,
                      color: Color.fromRGBO(99,105,150,1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(act["activity"],style: Styles.headlineStyle4.copyWith(color: Colors.white),),
                      ),
                    );
                  }

                  return Container();
                }).toList(),
              ),
              const SizedBox(height: 50),


              TextFormField(
                controller: calories,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Calorie amount',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: no_hours,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter no of hours',
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 45,
                child: ElevatedButton.icon(

                  onPressed: (){
                      final now = DateTime.now();
                      print(now.year);
                      print(now.month);
                      print(now.day);
                      var week = (now.day/7).ceil();
                      print(week);

                      reg(selectedItems[1], selectedItems[2], selectedItems[3], int.parse(no_hours.text), int.parse(calories.text)
                          , week, now.year, now.day, now.month);

                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateRoutineP01()));

                  },
                  icon: Icon(Icons.save),  //icon data for elevated button
                  label: Text("              Create new Activity routine                      "), //label text
                  style: ElevatedButton.styleFrom(


                      primary: Color.fromRGBO(99,105,150,1.0) //elevated btton background color
                  ),
                ),
              ),
            ]),
          ),
        ),

    );
  }
}