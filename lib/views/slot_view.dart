import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../services/datetime_converter_service.dart';
import '../styling.dart';

class SlotView extends StatelessWidget {
  final Object slot;

  SlotView({required this.slot});

  DateTimeConverterService _dateTimeConverterService =
      DateTimeConverterService();

  @override
  Widget build(BuildContext context) {
    final precipitation =
        (slot as Map).containsKey('pop') ? (slot as Map)['pop'] : null;

    final Object main =
        (slot as Map).containsKey('main') ? (slot as Map)['main'] : null;
    final dynamic temperature =
        (main as Map).containsKey('temp') ? main['temp'] : null;
    final dynamic humidity =
        main.containsKey('humidity') ? main['humidity'] : null;

    final List weather =
        (slot as Map).containsKey('weather') ? (slot as Map)['weather'] : null;
    final String iconUrl =
        'https://openweathermap.org/img/wn/${weather[0]['icon']}.png';

    final Object wind =
        (slot as Map).containsKey('wind') ? (slot as Map)['wind'] : null;
    final dynamic windSpeed =
        (wind as Map).containsKey('speed') ? wind['speed'] : null;

    return Container(
        width: (MediaQuery.of(context).size.width - 20) / 5 -
            MediaQuery.of(context).size.width / 40,
        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                border: Border.all(
                  color: AppColors.borderColor,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.only(top: xsPadding),
                    child: Text(
                      '${_dateTimeConverterService.convertStringToDateTime((slot as Map)['dt_txt'])}',
                      style: mediumTextStyle,
                    )),
                Image.network(iconUrl),
                Text(
                  '${temperature.round()}$celciumDegSign',
                  style: biggerTextStyle,
                ),
              ]),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.bgLightBlue,
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: xsPadding),
                child: Column(
                  children: [
                    Text(
                      '$windSpeed $metersPerSecondSign',
                      style: smallTextStyle,
                    ),
                    Text(
                      '$humidity $percentSign',
                      style: smallTextStyle,
                    ),
                    Text(
                      '${precipitation.round()} $precipitationSign',
                      style: smallTextStyle,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
