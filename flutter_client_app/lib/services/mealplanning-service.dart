import 'dart:convert';

import 'package:http/http.dart';

class MealPlanningService {
  String url = "http://152.67.160.154:5000//food";
  //send fooditems to backend
  Future<void> sendFoodItems(List<String> foodItems) async {
    Map<String,String>data = {};

    for(var i = 0; i < foodItems.length; i++){
      data.addAll({
        'object${i}': foodItems[i]
      });
    }  
    Response res = await post(Uri.parse(url), body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    print(res.body);
  }

  //get fooditems

}