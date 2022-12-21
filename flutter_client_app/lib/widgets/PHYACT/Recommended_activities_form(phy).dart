import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../screens/PHYACT/create_new_routine_p2(recommended activities)(phy).dart';

class RecommendedActsForm extends StatefulWidget {
  RecommendedActsForm({Key? key}) : super(key: key);



  // The function that fetches data from the API


  @override
  State<RecommendedActsForm> createState() => _RecommendedActsForm();

  void setState(Null Function() param0) {}
}

class _RecommendedActsForm extends State<RecommendedActsForm> {

  List _rectActs = [];

  void main(String age, String gen, String wei, String hei, String blpr, String chol, String gluc, String diab, String discom,
      String cps, String fhhd, String cigcom) async {
    
    http.Response response = await postActs(age, gen, wei, hei, blpr, chol, gluc, diab, discom,
        cps, fhhd, cigcom);

    List data = json.decode(response.body);

    setState(() {
      _rectActs = data;
    });

    print(data);
  }



  Future<http.Response> postActs(String age, String gen, String wei, String hei, String blpr, String chol, String gluc, String diab, String discom,
      String cps, String fhhd, String cigcom) {
    return http.post(
      Uri.parse('http://152.67.160.154:5000/get_pred_params/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "Age":age,
        "gender":gen,
        "weight":wei,
        "height":hei,
        "BloodPressure":blpr,
        "cholestrol":chol,
        "Glucose":gluc,
        "diabetes":diab,
        "discomfirt_chest":discom,
        "current_physical_activity_status":cps,
        "family_history_heart_disease":fhhd,
        "cigerette_consumption":cigcom

      }),
    );

  }

  int _activeStepIndex = 0;
  static const List<String> gender_list = <String>['Male','Female'];
  String dropdownValue_gender = gender_list.first;
  static const List<String> diabetes_list = <String>['Yes','No'];
  String dropdownValue_diabetes = diabetes_list.first;
  static const List<String> discomfirt_chest_list = <String>['Yes','No'];
  String dropdownValue_discomfirt_chest = discomfirt_chest_list.first;
  static const List<String> current_physical_activity_status_list = <String>['Inactive','Moderate','Active'];
  String dropdownValue_current_physical_activity_status_list = current_physical_activity_status_list.first;
  static const List<String> family_history_heart_disease_list = <String>['Yes','No'];
  String dropdownValue_family_history_heart_disease = family_history_heart_disease_list.first;
  static const List<String> cigerette_consumption_list = <String>['No','Daily','Weekly','Monthly'];
  String dropdownValue_cigerette_consumption = cigerette_consumption_list.first;

  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController bloodPressure = TextEditingController();
  TextEditingController cholestrol = TextEditingController();
  TextEditingController glucose = TextEditingController();
  TextEditingController diabetes = TextEditingController();
  TextEditingController discomfirt_chest = TextEditingController();
  TextEditingController current_physical_activity_status = TextEditingController();
  TextEditingController family_history_heart_disease = TextEditingController();
  TextEditingController cigerette_consumption = TextEditingController();


  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Age', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: age,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your age',
              ),
            ),

          ],
        ),
      ),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Gender', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(

          child: Row(
            children: [
              Column(

                children: [
                  const SizedBox(
                    height: 8,
                  ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        width: 300,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton<String>(
                            value: dropdownValue_gender,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                        ),
                          onChanged: (String? value) {
                        // This is called when the user selects an item.
                          setState(() {
                            dropdownValue_gender = value!;
                              });
                            },
                            items: gender_list.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                          }).toList(),
                        ),
                      )

                ],
              ),
            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Dimensions', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: weight,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter your weight (kg)',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: height,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter your height (cm)',
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 3,
        title: const Text('bloodPressure', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: bloodPressure,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter your Blood Pressure level (diastolic)',
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 4,
        title: const Text('cholestrol', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: cholestrol,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter your glucose level',
                ),
              ),

            ],
          ),
        )),

    Step(
        state:
        _activeStepIndex <= 5 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 5,
        title: const Text('glucose', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: glucose,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter your gender',
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 6 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 6,
        title: const Text('Diabetes', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(

          child: Row(
            children: [
              Column(

                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    width: 300,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                      value: dropdownValue_diabetes,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue_diabetes = value!;
                        });
                      },
                      items: diabetes_list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )

                ],
              ),
            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 7 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 7,
        title: const Text('discomfort chest', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                width: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  value: dropdownValue_discomfirt_chest,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue_discomfirt_chest = value!;
                    });
                  },
                  items: discomfirt_chest_list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 8 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 8,
        title: const Text('current_physical_activity_status', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                width: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  value: dropdownValue_current_physical_activity_status_list,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue_current_physical_activity_status_list = value!;
                    });
                  },
                  items: current_physical_activity_status_list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 9 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 9,
        title: const Text('family_history_heart_disease', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                width: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  value: dropdownValue_family_history_heart_disease,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue_family_history_heart_disease = value!;
                    });
                  },
                  items: family_history_heart_disease_list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 10 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 10,
        title: const Text('cigerette_consumption', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                width: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  value: dropdownValue_cigerette_consumption,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue_cigerette_consumption = value!;
                    });
                  },
                  items: cigerette_consumption_list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
        )),
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 11,
        title: const Text('Confirm Details', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('age: ${age.text}'),
                Text('gender: ${dropdownValue_gender}'),
                Text('height: ${height.text}'),
                Text('weight: ${weight.text}'),
                Text('bloodPressure: ${bloodPressure.text}'),
                Text('cholestrol: ${cholestrol.text}'),
                Text('glucose: ${glucose.text}'),
                Text('diabetes: ${dropdownValue_diabetes}'),
                Text('discomfirt_chest: ${dropdownValue_discomfirt_chest}'),
                Text('current_physical_activity_status: ${dropdownValue_current_physical_activity_status_list}'),
                Text('family_history_heart_disease: ${dropdownValue_family_history_heart_disease}'),
                Text('cigerette_consumption: ${dropdownValue_cigerette_consumption}'),


              ],
            ))),


  ];

  @override
  Widget build(BuildContext context) {


    return Container(
      child: SafeArea(
        child: Container(

            child: Theme(
              data: ThemeData(
                  accentColor: Color.fromRGBO(99,105,150,1.0),
                  colorScheme: ColorScheme.light(
                  primary: Color.fromRGBO(99,105,150,1.0)
                  ),
              ),
              child: Stepper(
                type: StepperType.vertical,
                currentStep: _activeStepIndex,
                steps:  stepList(),
                onStepContinue: () {
                  if (_activeStepIndex < (stepList().length - 1)) {
                    setState(() {
                      _activeStepIndex += 1;
                    });
                  } else {

                    if(dropdownValue_gender == 'Male'){
                      dropdownValue_gender = '1';
                    }
                    else{
                      dropdownValue_gender = '0';
                    }

                    if(dropdownValue_diabetes == 'Yes'){
                      dropdownValue_diabetes = '1';
                    }
                    else{
                      dropdownValue_diabetes = '0';
                    }

                    if(dropdownValue_discomfirt_chest == 'Yes'){
                      dropdownValue_discomfirt_chest = '1';
                    }
                    else{
                      dropdownValue_discomfirt_chest = '0';
                    }

                    if(dropdownValue_current_physical_activity_status_list == 'Inactive'){
                      dropdownValue_current_physical_activity_status_list = '0';
                    }
                    else if (dropdownValue_current_physical_activity_status_list == 'Moderate'){
                      dropdownValue_current_physical_activity_status_list = '1';
                    }
                    else{
                      dropdownValue_current_physical_activity_status_list = '2';
                  }

                    if(dropdownValue_family_history_heart_disease == 'Yes'){
                      dropdownValue_family_history_heart_disease = '1';
                    }
                    else{
                      dropdownValue_family_history_heart_disease = '0';
                    }

                    if(dropdownValue_cigerette_consumption == 'No'){
                      dropdownValue_cigerette_consumption = '0';
                    }
                    else if (dropdownValue_cigerette_consumption == 'Daily'){
                      dropdownValue_cigerette_consumption = '1';
                    }
                    else if (dropdownValue_cigerette_consumption == 'Weekly'){
                      dropdownValue_cigerette_consumption = '2';
                    }
                    else{
                      dropdownValue_cigerette_consumption = '2';
                    }




                    main(age.text, dropdownValue_gender, weight.text, height.text, bloodPressure.text,
                        cholestrol.text, glucose.text, dropdownValue_diabetes, dropdownValue_discomfirt_chest,
                        dropdownValue_current_physical_activity_status_list,
                        dropdownValue_family_history_heart_disease, dropdownValue_cigerette_consumption);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateRoutineP02())).then((value) =>
                    setState((){}));
                  }
                },
                onStepCancel: () {
                  if (_activeStepIndex == 0) {
                    return;
                  }

                  setState(() {
                    _activeStepIndex -= 1;
                  });
                },
                onStepTapped: (int index) {
                  setState(() {
                    _activeStepIndex = index;
                  });
                },
                controlsBuilder: (context, ControlsDetails controls) {
                  final isLastStep = _activeStepIndex == stepList().length - 1;
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controls.onStepContinue,
                            child: (isLastStep)
                                ? const Text('Submit')
                                : const Text('Next'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (_activeStepIndex > 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controls.onStepCancel,
                              child: const Text('Back'),
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
        ),
      ),
    );
  }
}




