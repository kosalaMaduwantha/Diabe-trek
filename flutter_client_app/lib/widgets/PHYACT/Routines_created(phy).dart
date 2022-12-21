import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/PHYACT/create_new_routine_p1(routines_created_pweek)(phy).dart';

class Routine extends StatefulWidget {
  Routine({Key? key}) : super(key: key);



  // The function that fetches data from the API



  @override
  State<Routine> createState() => _Routine();

  void setState(Null Function() param0) {}
}

class _Routine extends State<Routine> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");
      _fetchData();
    });

  }

  List _loadedWeeks = [];
  Future<void> _fetchData() async {
    const apiUrl = 'http://152.67.160.154:5000/get_routines_from_db_weeks/?u_id=1';

    HttpClient client = HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);

    setState(() {
      _loadedWeeks = data;
    });


  }


  @override
  Widget build(BuildContext context) {
    return  Container(

          child: SafeArea(
              child: _loadedWeeks.isEmpty
                  ? Text("no routines available"): ListView.separated(

                itemCount: _loadedWeeks.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  const CreateRoutineP02()));
                            Navigator.pushNamed(context, "second",arguments: {"week":_loadedWeeks[index]['week_no']});
                                                          },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(99,105,150,1.0),
                        child: Text("${index+1}"),
                      ),
                      title: Text("Week "+"${_loadedWeeks[index]['week_no']}"),
                      trailing: Icon(Icons.more_vert),

                    ),
                  );

                },
                separatorBuilder: (context, index) { // <-- SEE HERE
                  return Divider();
                },
              ))
      );

  }
}




