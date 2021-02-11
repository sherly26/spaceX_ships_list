import 'package:ji_mobile_app/models/ship.dart';

import '../services/api_service.dart';

class ApiProvider {
  List<String> shipsNameList = [];
  final ApiService _service;
  ApiProvider(this._service);

  Future<List<Ship>> getApiData() async {
    final result = await _service.getApiData();
    final shipList = result.map((ship) => Ship.fromJson(ship)).toList();
    return shipList;
  }
}
