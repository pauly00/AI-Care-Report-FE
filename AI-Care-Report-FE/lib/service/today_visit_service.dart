import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/today_visit.dart';

class TodayVisitService {
  static const String BASE_URL = 'https://www.safe-hi.xyz';
  
  static Future<List<TodayVisit>> getTodayList({
    required String todayDate,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/db/getTodayList'),
        headers: {
          'Content-Type': 'application/json',
          'header': token,
        },
        body: json.encode({
          'todayDate': todayDate,
          'header': token,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => TodayVisit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load today visits: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching today visits: $e');
    }
  }
}