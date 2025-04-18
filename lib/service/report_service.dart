import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:safe_hi/model/report_model.dart';
import 'package:safe_hi/model/user_model.dart';
import 'package:path/path.dart' as path;

class ReportService {
  static const String baseUrl = 'http://211.188.55.88:3000';

  Future<List<ReportTarget>> fetchReportTargets() async {
    final response =
        await http.get(Uri.parse('$baseUrl/db/getDefaultReportList'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ReportTarget.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load report target list');
    }

    // --- Dummy ---
    // final List<Map<String, dynamic>> dummyData = [
//   {
//     "reportid": 1,
//     "reportstatus": 1,
//     "visittime": "2025-04-03 10:00",
//     "targetInfo": {
//       "targetid": 1,
//       "targetname": "이유진",
//       "address1": "대전 서구 대덕대로 150",
//       "address2": "경성 큰마을아파트 102동 103호",
//       "targetcallnum": "010-3889-3501",
//       "gender": 1,
//       "age": 77
//     }
//   },
//   {
//     "reportid": 6,
//     "reportstatus": 1,
//     "visittime": "2025-04-03 16:00",
//     "targetInfo": {
//       "targetid": 2,
//       "targetname": "김연우",
//       "address1": "대전 서구 대덕대로 150",
//       "address2": "경성 큰마을아파트 102동 103호",
//       "targetcallnum": "010-4567-8901",
//       "gender": 1,
//       "age": 80
//     }
//   },
//   {
//     "reportid": 7,
//     "reportstatus": 1,
//     "visittime": "2025-04-03 17:00",
//     "targetInfo": {
//       "targetid": 3,
//       "targetname": "이유진",
//       "address1": "대전 서구 대덕대로 150",
//       "address2": "경성 큰마을아파트 102동 103호",
//       "targetcallnum": "010-3889-3501",
//       "gender": 1,
//       "age": 77
//     }
//   }
// ];

    //return dummyData.map((e) => ReportTarget.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> uploadDefaultReport({
    required ReportTarget target,
    required UserModel user,
    required String visitType,
    required String endTime,
  }) async {
    final uri = Uri.parse('$baseUrl/db/uploadReportDefaultInfo');

    final body = {
      "reportid": target.reportId,
      "reportstatus": 1,
      "visittime": target.visitTime,
      "targetInfo": {
        "targetid": target.targetId,
        "targetname": target.targetName,
        "address1": target.address1,
        "address2": target.address2,
        "targetcallnum": target.phone,
        "gender": target.gender,
        "age": target.age,
      },
      "userInfo": {
        "email": user.email,
        "username": user.name,
        "callnum": user.phoneNumber,
        "birthday": user.birthDate,
        "etc": user.etc,
        "role": user.role,
        "gender": user.gender,
      },
      "visitType": visitType,
      'endTime': endTime,
    };

    debugPrint('[📤 업로드 요청 body] ${jsonEncode(body)}');

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return jsonDecode(response.body);
  }

  Future<void> uploadVisitDetail({
    required int reportId,
    required String detail,
  }) async {
    final url = Uri.parse('$baseUrl/db/uploadVisitDetail');

    final body = {
      'reportid': reportId,
      'detail': detail,
    };

    debugPrint('[특이사항 업로드 요청] ${jsonEncode(body)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('특이사항 업로드 실패: ${response.statusCode}');
    }
  }

  Future<void> uploadImages({
    required int reportId,
    required List<File> imageFiles,
  }) async {
    final uri = Uri.parse('$baseUrl/db/uploadImages');
    final request = http.MultipartRequest('POST', uri);

    request.fields['reportid'] = reportId.toString();

    for (var file in imageFiles) {
      final ext = path.extension(file.path).toLowerCase();
      final mimeType = ext == '.png' ? 'png' : 'jpeg';

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          file.path,
          contentType: MediaType('image', mimeType),
        ),
      );
    }

    final response = await http.Response.fromStream(await request.send());

    debugPrint('[이미지 업로드 응답] ${response.statusCode} - ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('이미지 업로드 실패: ${response.statusCode}');
    }
  }
}
