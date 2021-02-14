import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:fyp_dieta/src/model/food_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<FoodResponse> fetchFood(String query) async {
  const String fields =
      '{"fields": [ "item_name", "item_type", "item_description", "item_id","nf_calories","nf_protein","nf_sugars", "nf_total_fat"]}';

  final http.Response response = await http.post(
    'https://api.nutritionix.com/v1_1/search',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'appId': DotEnv().env['APPID'],
      'appKey': DotEnv().env['APPKEY'],
      'query': query,
      'fields': jsonDecode(fields)['fields']
    }),
  );
  developer.log('status code${response.statusCode}');
  developer.log(response.body.toString());
  return FoodResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>);
}
