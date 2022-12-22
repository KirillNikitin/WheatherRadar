import 'package:flutter/material.dart';

import 'package:weather_radar/views/slot_view.dart';

import '../models/weather.dart';
import '../services/datetime_converter_service.dart';
import '../styling.dart';

class CityView extends StatelessWidget {
  final WeatherResponse? city;

  CityView({required this.city});

  DateTimeConverterService _dateTimeConverterService =
      DateTimeConverterService();

  @override
  Widget build(BuildContext context) {
    final temperature = city?.mainInfo?.temperature?.round();
    final humidity = city?.mainInfo?.humidity;
    final windSpeed = city?.windInfo?.speed;

    return Container(
        child: Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.bgWhite,
              border: Border.all(
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
            child: Padding(
                padding: EdgeInsets.fromLTRB(sPadding, 0, sPadding, sPadding),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: xxsPadding),
                              child: Text(
                                city!.cityName ?? '',
                                style: largeTextStyle,
                              ),
                            ),
                            Text(
                              city!.weatherInfo?.description?.capitalize() ??
                                  '',
                              style: mediumTextStyle,
                            )
                          ],
                        ),
                        Column(children: [
                          Row(children: [
                            Image.network(height: 85, width: 85, city!.iconUrl),
                            Text(
                              '$temperature$celciumDegSign',
                              style: xxlTextStyle,
                            ),
                          ])
                        ]),
                      ]),
                  SizedBox(
                    height: lPadding,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_dateTimeConverterService.todaysDay()}',
                                style: biggerTextStyle.apply(
                                    color: AppColors.fontDark)),
                            Text(
                              '${_dateTimeConverterService.timeRightNow()}',
                              style: mediumTextStyle,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$windStr: $windSpeed $metersPerSecondSign',
                              style: mediumTextStyle,
                            ),
                            Text(
                              '$humidityStr: $humidity $percentSign',
                              style: mediumTextStyle,
                            ),
                            Text(
                              '$precipitationStr $slotDeltaSign: ${city?.precipitation.round()} $precipitationSign',
                              style: mediumTextStyle,
                            )
                          ],
                        ),
                      ]),
                ]))),
        Container(
            margin: EdgeInsets.symmetric(vertical: sPadding),
            height: 200.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 9, // aprx. 24 hours forecast
                prototypeItem: SlotView(slot: city!.slots!.first),
                itemBuilder: (context, index) {
                  return SlotView(slot: city!.slots![index]);
                }))
      ],
    ));
  }
}

extension CapitalizeString on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
