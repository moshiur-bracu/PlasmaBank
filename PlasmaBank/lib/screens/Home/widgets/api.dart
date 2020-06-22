import 'package:PlasmaBank/screens/Home/widgets/bangladesh.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class Api {
  
  Future makeGetRequest() async {

  // make request
  Response response = await get('http://23.251.153.29/api/covid19?country=ban&format=json');

  if (response.statusCode == 200) {
      // 6
      //print(response.body);
      String jsonResponse = (response.body).toString();
      Map<String, dynamic> jsonString = jsonDecode(jsonResponse);
      String deaths = jsonResponse[4][1];
      print(deaths);
      //return response.body;
    } else {
      print(response.statusCode);
    }

    

}
}