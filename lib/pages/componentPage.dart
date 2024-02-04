import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather/const/color.dart';
import 'package:weather/model/weather_model.dart';

// ignore: must_be_immutable
class HomeComponent extends StatelessWidget {
  WeatherModel weatherModel;
  HomeComponent({super.key, required this.weatherModel});

  WeatherType getWeatherType(Condition condition) {
    if (condition.text!.contains('Sunny')) {
      return WeatherType.sunny; 
    }
    else if (condition.text!.contains('Partly Cloudy')) {
      return WeatherType.cloudy;
    } 
    else if (condition.text!.contains('OverCast')) {
      return WeatherType.overcast;
    } 
    else if (condition.text!.contains('Cloudy')) {
      return WeatherType.cloudy;
    } 
    else if (condition.text!.contains('Mist')) {
      return WeatherType.lightSnow;
    } 
    else if (condition.text!.contains('thunder')) {
      return WeatherType.thunder;
    } 
    else if (condition.text!.contains('rain')) {
      return WeatherType.heavyRainy; 
    } 
    else if (condition.text!.contains('Showers')) {
      return WeatherType.middleSnow;
    }else{
          return WeatherType.thunder;
    }

   
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: getWeatherType(weatherModel.current!.condition!),
          width: MediaQuery.sizeOf(context).width,
          height: 300,
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, left: 10, top: 5, bottom: 5),
                    child: Column(
                      children: [
                        AllText.text(weatherModel.location!.name!, 24,
                            FontWeight.bold, AllColor.whiteColor),
                        AllText.text(
                            DateFormat.yMMMMEEEEd().format(DateTime.parse(
                                weatherModel.current!.lastUpdated.toString())),
                            18,
                            FontWeight.bold,
                            AllColor.whiteColor),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    Image.network(
                      'https:${weatherModel.current?.condition?.icon ?? ""}',
                      height: 60,
                      width: 60,
                    ),
                    Column(
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AllText.text(
                                    weatherModel.current!.tempC!
                                        .round()
                                        .toStringAsPrecision(2),
                                    40,
                                    FontWeight.w600,
                                    Colors.red.shade600),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 50)),
                                AllText.text('o', 20, FontWeight.w600,
                                    Colors.red.shade600),
                              ],
                            ),
                          ),
                        ),
                        AllText.text(weatherModel.current!.condition!.text!, 22,
                            FontWeight.w500, AllColor.deepBlackColor),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                AllText.text('Feels Like', 18, FontWeight.w600,
                                    AllColor.whiteColor),
                                AllText.text(
                                    weatherModel.current!.feelslikeC!
                                        .round().toString(),
                                    16,
                                    FontWeight.w600,
                                    AllColor.whiteColor),
                              ],
                            ),
                            Column(
                              children: [
                                AllText.text('Wind', 18, FontWeight.w600,
                                    AllColor.whiteColor),
                                AllText.text(
                                    '${weatherModel.current!.windKph!.round().toString()}kph',
                                    16,
                                    FontWeight.w600,
                                    AllColor.whiteColor),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          indent: 70,
                          endIndent: 70,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                AllText.text('Humidity', 18, FontWeight.w600,
                                    AllColor.whiteColor),
                                AllText.text(
                                    '${weatherModel.current!.humidity!.round().toString()}',
                                    16,
                                    FontWeight.w600,
                                    AllColor.whiteColor),
                              ],
                            ),
                            Column(
                              children: [
                                AllText.text('Visibality', 18, FontWeight.w600,
                                    AllColor.whiteColor),
                                AllText.text(
                                    '${weatherModel.current!.visKm!.round().toString()}km',
                                    16,
                                    FontWeight.w600,
                                    AllColor.whiteColor),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
