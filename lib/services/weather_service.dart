import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String _apiKey = '84a5e3a9b43480bb675ad26b39c972bd';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';


  Future<Map<String, dynamic>> fetchWeatherByCoordinates(double latitude, double longitude) async {
    final url = '$_baseUrl?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        return json.decode(response.body);
      } else {

        throw Exception('Error fetching weather: ${response.statusCode}');
      }
    } catch (e) {

      throw Exception('Error fetching weather: $e');
    }
  }
}
