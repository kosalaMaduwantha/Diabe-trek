import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../screens/PHYACT/create_new_routine_p2(recommended activities)(phy).dart';
import 'DPN_result.dart';

class DpnForm extends StatefulWidget {
  DpnForm({Key? key}) : super(key: key);



  // The function that fetches data from the API


  @override
  State<DpnForm> createState() => _DpnForm();

  void setState(Null Function() param0) {}
}

class _DpnForm extends State<DpnForm> {

  Map<String, dynamic> _rectDPN = {};

  get key => null;

  void main(String preg, String glucose, String blpr, String skinthickness, String insulin, String bmi, String age, String numb, String pain, String tingling,
      String retino, String urin) async {
    
    http.Response response = await postActs(preg, glucose, blpr, skinthickness, insulin, bmi, age, numb, pain,
        tingling, retino, urin);



    Map<String, dynamic> data = json.decode(response.body);

    setState(() {
      _rectDPN = data;
    });

    print(_rectDPN);
  }



  Future<http.Response> postActs(String preg, String glucose, String blpr, String skinthickness, String insulin, String bmi, String age, String numb, String pain, String tingling,
      String retino, String urin) {
    return http.post(
      Uri.parse('http://192.168.8.101:3000/get_symptoms_dpn/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "Pregnancies":preg,
        "Glucose":glucose,
        "BloodPressure":blpr,
        "SkinThickness":skinthickness,
        "Insulin":insulin,
        "BMI":bmi,
        "Age":age,
        "Numb_on_cotton_wool":numb,
        "Pain_in_legs":pain,
        "Tingling_Sensation":tingling,
        "Retinopathy_screened_grading":retino,
        "Urine_micro_albumin":urin,

      }),
    );

  }

  int _activeStepIndex = 0;
  static const List<String> numb_list = <String>['Yes','No'];
  String dropdownValue_numb = numb_list.first;
  static const List<String> pain_list = <String>['Yes','No'];
  String dropdownValue_pain = pain_list.first;
  static const List<String> tingling_list = <String>['Yes','No'];
  String dropdownValue_tingling = tingling_list.first;


  TextEditingController preg = TextEditingController();
  TextEditingController glucose = TextEditingController();
  TextEditingController bloodPressure = TextEditingController();
  TextEditingController skinthickness = TextEditingController();
  TextEditingController insulin = TextEditingController();
  TextEditingController bmi = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController retino = TextEditingController();

  TextEditingController urin = TextEditingController();


  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Number of pregnancies', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: preg,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the count',
              ),
            ),
          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Glucose Level', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: glucose,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the glucose level',
              ),
            ),
          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Blood Pressure: ', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: bloodPressure,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the amount',
              ),
            ),

          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Skin Thickness: ', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: skinthickness,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the amount',
              ),
            ),

          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Insulin intake: ', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: insulin,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the amount',
              ),
            ),

          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('BMI: ', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: bmi,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your BMI',
              ),
            ),

          ],
        ),
      ),
    ),
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Age: ', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: age,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your current age',
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
        title: const Text('Numb when walking on wool', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
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
                            value: dropdownValue_numb,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.blueGrey),
                            underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                        ),
                          onChanged: (String? value) {
                        // This is called when the user selects an item.
                          setState(() {
                            dropdownValue_numb = value!;
                              });
                            },
                            items: numb_list.map<DropdownMenuItem<String>>((String value) {
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
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Pain in legs', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
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
                      value: dropdownValue_pain,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.blueGrey),
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue_pain = value!;
                        });
                      },
                      items: pain_list.map<DropdownMenuItem<String>>((String value) {
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
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Tingling sensation in the soles', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
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
                      value: dropdownValue_tingling,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.blueGrey),
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue_tingling = value!;
                        });
                      },
                      items: tingling_list.map<DropdownMenuItem<String>>((String value) {
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
        _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 3,
        title: const Text('Retino therapy screened grading', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: retino,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter the grading numeric amount',
                ),
              ),

            ],
          ),
        )),
    Step(
        state:
        _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 4,
        title: const Text('Urine Micro Albumin count', style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2,),),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: urin,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number only',
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
                Text('Pregnancy count: ${preg.text}'),
                Text('Glucose level: ${glucose.text}'),
                Text('Blood Pressure: ${bloodPressure.text}'),
                Text('Skin thickness: ${skinthickness.text}'),
                Text('Insulin: ${insulin.text}'),
                Text('BMI: ${bmi.text}'),
                Text('Age: ${age.text}'),
                Text('Numbness: ${dropdownValue_numb}'),
                Text('Pain in legs: ${dropdownValue_pain}'),
                Text('Tingling sensation: ${dropdownValue_tingling}'),
                Text('Retinotherapy Screened Grading: ${retino.text}'),
                Text('Urine Micro Albumin Amount: ${urin.text}'),


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
                  accentColor: Color.fromRGBO(15,52,106,1.0),
                  colorScheme: ColorScheme.light(
                  primary: Color.fromRGBO(15,52,106,1.0)
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

                    if(dropdownValue_numb == 'Yes'){
                      dropdownValue_numb = '1';
                    }
                    else{
                      dropdownValue_numb = '0';
                    }

                    if(dropdownValue_pain == 'Yes'){
                      dropdownValue_pain = '1';
                    }
                    else{
                      dropdownValue_pain = '0';
                    }

                    if(dropdownValue_tingling == 'Yes'){
                      dropdownValue_tingling = '1';
                    }
                    else{
                      dropdownValue_tingling = '0';
                    }





                    main(preg.text,glucose.text, bloodPressure.text, skinthickness.text, insulin.text, bmi.text,
                  age.text, dropdownValue_numb, dropdownValue_pain, dropdownValue_tingling,retino.text,urin.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  dpn_result(text: '',))).then((value) =>
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




