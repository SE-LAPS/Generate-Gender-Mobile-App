import 'package:app/pages/gender_info.dart';
import 'package:dio/dio.dart';

class GenderAPIService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api.genderize.io/";

  Future<GenderInfo> getGenderInfo(String name) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {"name": name});
      return GenderInfo.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
