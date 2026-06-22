import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/device.dart';

class ApiService {
  static const String baseUrl = 'https://6a396b9364a2d8269223f1c1.mockapi.io/devices';

  Future<List<Device>> getDevices() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Device.fromJson(data)).toList();
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de conexión. Verifica tu internet.');
    }
  }

  Future<void> createDevice(Device device) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(device.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al guardar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de conexión al guardar el dispositivo.');
    }
  }
}
