import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:magic_slides/model/generate_slides/generate_slides_request.dart';
import 'package:magic_slides/model/generate_slides/generate_slides_response.dart';

class HttpService {
  static Future<void> postAPI({
    required GenerateSlidesRequest request,
    required void Function(GenerateSlidesResponse response) onSuccess,
    required void Function(String error) onError,
  }) async {
    List<ConnectivityResult> connectivity = await Connectivity().checkConnectivity();
    if (connectivity.any((element) => element == ConnectivityResult.none)) {
      onError('No internet connection');
      return;
    }
    print("response: ${request.toJson()}");
    final response = await http.post(
      Uri.parse('https://api.magicslides.app/public/api/ppt_from_topic'),
      body: jsonEncode(request.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Request successful: ${response.body}');
      GenerateSlidesResponse generateSlidesResponse = GenerateSlidesResponse.fromJson(jsonDecode(response.body));
      onSuccess(generateSlidesResponse);
    } else {
      onError(response.body);
      print('Request failed with status: ${response.body}');
    }
  }
}
