import 'package:dio/dio.dart';

class ApiService {
  Future<List<dynamic>> getApiData() async {
    Response response = await Dio().get("https://api.spacexdata.com/v3/ships");
    final data = response.data as List<dynamic>;
    print(response.data);
    return data;
  }
}
