import 'package:flutter/material.dart';
import 'services/weather_service.dart'; // Import the WeatherService class

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  // List of predefined cities
  final List<Map<String, dynamic>> _popularCities = [
    {"city": "New York", "latitude": 40.7128, "longitude": -74.0060},
    {"city": "Los Angeles", "latitude": 34.0522, "longitude": -118.2437},
    {"city": "London", "latitude": 51.5074, "longitude": -0.1278},
    {"city": "Mumbai", "latitude": 19.0760, "longitude": 72.8777},
    {"city": "Delhi", "latitude": 28.6139, "longitude": 77.2090},
    {"city": "Bangalore", "latitude": 12.9716, "longitude": 77.5946},
    {"city": "Kolkata", "latitude": 22.5726, "longitude": 88.3639},
    {"city": "Chennai", "latitude": 13.0827, "longitude": 80.2707},
    {"city": "Hyderabad", "latitude": 17.3850, "longitude": 78.4867},
  ];

  // Search results for user input
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = [..._popularCities]; // Initialize with popular cities
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [..._popularCities]; // Show popular cities if query is empty
      } else {
        _searchResults = _popularCities.where((city) {
          return city['city'].toLowerCase().contains(query.toLowerCase());
        }).toList();

        // Add lat/long search support
        if (_searchResults.isEmpty) {
          try {
            final parts = query.split(',').map((e) => double.tryParse(e.trim())).toList();
            if (parts.length == 2 && parts[0] != null && parts[1] != null) {
              _searchResults = [
                {"city": "Custom Location", "latitude": parts[0], "longitude": parts[1]}
              ];
            }
          } catch (_) {
            // Invalid lat/long format; ignore
          }
        }
      }
    });
  }

  Future<void> _fetchWeather(double latitude, double longitude) async {
    try {
      final weatherData = await _weatherService.fetchWeatherByCoordinates(latitude, longitude);

      // Show weather data in a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Weather Info'),
          content: Text(
            'City: ${weatherData['name']}\n'
                'Temperature: ${weatherData['main']['temp']}°C\n'
                'Weather: ${weatherData['weather'][0]['description']}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search city or lat,long',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged, // Trigger search on text change
          onSubmitted: (query) {
            // Handle submission (e.g., lat/long input)
            try {
              final parts = query.split(',').map((e) => double.tryParse(e.trim())).toList();
              if (parts.length == 2 && parts[0] != null && parts[1] != null) {
                _fetchWeather(parts[0]!, parts[1]!);
              }
            } catch (_) {
              // Invalid input format
            }
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final result = _searchResults[index];
            return ListTile(
              title: Text(
                "${result['city']} (${result['latitude']}, ${result['longitude']})",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Latitude: ${result['latitude']}, Longitude: ${result['longitude']}",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Fetch weather data for selected city
                _fetchWeather(result['latitude'], result['longitude']);
              },
            );
          },
        ),
      ),
    );
  }
}
