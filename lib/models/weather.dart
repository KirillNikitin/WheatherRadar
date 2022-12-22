/* list item:
{
  "dt":1671192000,
  "main": 
    {
      "temp":-8.67,
      "feels_like":-13.18,
      "temp_min":-9.77,
      "temp_max":-8.67,
      "pressure":1013,
      "sea_level":1013,
      "grnd_level":993,
      "humidity":95,
      "temp_kf":1.1
    },
  "weather":
    [
      {
        "id":801,
        "main":"Clouds",
        "description":"few clouds",
        "icon":"02d"
      }
    ],
  "clouds":
    {
      "all":20
    },
  "wind":
    {
      "speed":2.42,
      "deg":230,
      "gust":9.07
    },
  "visibility":10000,
  "pop":0,
  "sys":
    {
      "pod":"d"
    },
  "dt_txt":"2022-12-16 12:00:00"
}

  total 40 items 
*/

class WeatherResponse {
  final String? cityName;
  final MainInfo? mainInfo;
  final WeatherInfo? weatherInfo;
  final WindInfo? windInfo;
  final dynamic precipitation; // can be int or doupble
  final List? slots;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo?.icon}@2x.png';
  }

  WeatherResponse(
      {this.cityName,
      this.mainInfo,
      this.weatherInfo,
      this.windInfo,
      this.precipitation,
      this.slots});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final String cityName = json['city']['name'];
    final slots = json['list'];

    final mainInfoJson = json['list'][0]['main'];
    final mainInfo = MainInfo.fromJson(mainInfoJson);

    final weatherInfoJson = json['list'][0]['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final windInfoJson = json['list'][0]['wind'];
    final windInfo = WindInfo.fromJson(windInfoJson);

    final precipitation = json['list'][0]['pop'];

    return WeatherResponse(
        cityName: cityName,
        mainInfo: mainInfo,
        weatherInfo: weatherInfo,
        windInfo: windInfo,
        precipitation: precipitation,
        slots: slots);
  }
}

class MainInfo {
  final double? temperature;
  final int? humidity;

  MainInfo({this.temperature, this.humidity});

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final humidity = json['humidity'];
    return MainInfo(temperature: temperature, humidity: humidity);
  }
}

class HumidityInfo {
  final int? humidity;

  HumidityInfo({this.humidity});

  factory HumidityInfo.fromJson(Map<String, dynamic> json) {
    final humidity = json['humidity'];
    return HumidityInfo(humidity: humidity);
  }
}

class WeatherInfo {
  final String? description;
  final String? icon;

  WeatherInfo({this.description, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];

    return WeatherInfo(description: description, icon: icon);
  }
}

class WindInfo {
  final dynamic speed;

  WindInfo({this.speed});

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'];

    return WindInfo(speed: speed);
  }
}
