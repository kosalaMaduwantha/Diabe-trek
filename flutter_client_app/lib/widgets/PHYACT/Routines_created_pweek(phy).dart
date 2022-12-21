import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routine_pweek extends StatefulWidget {
  Routine_pweek({Key? key,}) : super(key: key);



  // The function that fetches data from the API



  @override
  State<Routine_pweek> createState() => _Routine_pweek();

  void setState(Null Function() param0) {}
}

class _Routine_pweek extends State<Routine_pweek> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    _fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");
      _fetchData();
    });

  }



  List _loaded = [];





  Future<void> _fetchData() async {

    var apiUrl = 'http://152.67.160.154:5000/get_routines_from_db/?u_id=1&no_week=2';

    HttpClient client = HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);

    setState(() {
      _loaded = data;
    });


  }


  @override
  Widget build(BuildContext context) {

    return Container(

          child: SafeArea(
              child: _loaded.isEmpty
                  ? Text("no routines available"): ListView.separated(

                itemCount: _loaded.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: (){},
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(99,105,150,1.0),
                        child: Text("${index+1}"),
                      ),
                      title: Text(""+"${_loaded[index]['activity']}"),
                      subtitle: Text("no min "+"${_loaded[index]['no_min']} " + "d-${_loaded[index]['day_no']}"),
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




