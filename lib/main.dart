import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_radar/styling.dart';
import 'package:weather_radar/views/city_view.dart';

import 'models/weather.dart';
import 'services/datafetch_service.dart';

void main() {
  runApp(WeatherRadarApp());
}

class WeatherRadarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$titleTextENG',
      theme: ThemeData(
        fontFamily: 'Arial',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherRadar(title: '$titleTextFIN'),
    );
  }
}

class WeatherRadar extends StatefulWidget {
  WeatherRadar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WeatherRadarState createState() => _WeatherRadarState();
}

class _WeatherRadarState extends State<WeatherRadar> {
  final _datafetchService = DatafetchService();

  WeatherResponse? _response;
  String currentId = '';
  CitiesEnum currentValue = CitiesEnum.ALL;
  bool allToDisplay = true;
  List<WeatherResponse> responses = [];

  // Info for all the cities is being called just once on app's start.
  // To avoid making several requests every time we choose 'All cities' (Kaikki kaupungit)
  Future<dynamic> fetchFullInfo() async {
    for (var value in CitiesEnum.values) {
      if (value.id.isNotEmpty) {
        final response = await _datafetchService.getWeather(value.id);
        responses.add(response);
      }
    }
    setState(() {
      responses;
    });
  }

  @override
  initState() {
    super.initState();
    fetchFullInfo();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.bgGray,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.bgBlue,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: Text(
            widget.title,
            style: xlTextStyle,
          ),
          centerTitle: true,
          backgroundColor: AppColors.bgWhite,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.borderColor,
              height: 1.0,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(sPadding, sPadding, sPadding, 0),
          child: ListView(
            children: <Widget>[
              Container(
                width: 200,
                margin: EdgeInsets.only(bottom: sPadding),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.bgWhite,
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: xsPadding, right: sPadding),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<CitiesEnum>(
                              value: currentValue, //CitiesEnum.ALL,
                              items: CitiesEnum.values
                                  .map((CitiesEnum citiesEnum) {
                                return DropdownMenuItem<CitiesEnum>(
                                    value: citiesEnum,
                                    child: Text(
                                      citiesEnum.value,
                                      style: mediumTextStyle.apply(
                                          color: AppColors.fontDark),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                if (currentId != value?.id) {
                                  currentId = value!.id;
                                  currentValue = value;
                                  setState(() {
                                    allToDisplay =
                                        value.id.isEmpty ? true : false;
                                  });
                                  if (value.id.isNotEmpty) {
                                    _getWeatherByCityId(value.id);
                                  }
                                }
                              })),
                    ),
                  ),
                ),
              ),
              if (_response != null && !allToDisplay) CityView(city: _response),
              if (allToDisplay && responses.isNotEmpty)
                Container(
                    height: MediaQuery.of(context).size.height - 3 * xlPadding,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: responses.length,
                        prototypeItem: CityView(city: responses.first),
                        itemBuilder: (context, index) {
                          return CityView(city: responses[index]);
                        })),
            ],
          ),
        ),
      );

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: mediumTextStyle.apply(color: AppColors.fontDark),
      ));

  _getWeatherByCityId(String? id) async {
    final response = await _datafetchService.getWeather(id ?? '');
    setState(() => _response = response);
  }
}

// Enum can be places in separate file f.e. 'Consts.dart' with some another constants.
enum CitiesEnum {
  ALL(value: 'Kaikki kaupungit', id: ''),
  HELSINKI(value: 'Helsinki', id: '658225'),
  JYVASKYLA(value: 'Jyväskylä', id: '655195'),
  KUOPIO(value: 'Kuopio', id: '650225'),
  TAMPERE(value: 'Tampere', id: '634964');

  const CitiesEnum({required this.value, required this.id});

  final String value;
  final String id;
}
