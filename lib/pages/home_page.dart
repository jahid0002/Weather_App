// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/const/color.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/pages/componentPage.dart';

import 'package:weather/service/weather_api.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HamePageState();
}

class _HamePageState extends State<HomePage> {
  GlobalKey _key = GlobalKey();
  String cityName = 'Dinajpur';
  WeatherData weatherData = WeatherData();

  /// showDialog//////
  TextEditingController textClt = TextEditingController();

  Future<void> dialogShow(
    BuildContext context,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AllColor.deepBlackColor,
            title: AllText.text(
                'Search City', 22, FontWeight.w600, AllColor.whiteColor),
            content: Form(
                key: _key,
                child: Card(
                  child: TextFormField(
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty Field';
                      }
                    },
                    controller: textClt,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.edit,
                          color: AllColor.deepBlueColor, size: 18),
                      focusColor: AllColor.deepBlueColor,
                      hintText: 'Enter City',
                      hintStyle: TextStyle(color: AllColor.deepBlueColor),
                    ),
                  ),
                )),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Card(
                  color: Colors.black12,
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AllText.text(
                        'Cancel', 20, FontWeight.w500, AllColor.whiteColor),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (textClt.text.isEmpty) {
                    Navigator.pop(context);
                    return;
                  } else {
                    cityName = textClt.text;
                    setState(() {});
                  }
                  textClt.clear();
                  Navigator.pop(context);
                },
                child: Card(
                  color: Colors.black12,
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AllText.text(
                        'Ok', 20, FontWeight.w500, AllColor.whiteColor),
                  ),
                ),
              ),
            ],
          );
        });

    /// end dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColor.deepBlackColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: BoxedIcon(
            WeatherIcons.day_lightning,
            size: 30,
            color: AllColor.whiteColor,
          ),
        ),
        toolbarHeight: 60,
        // centerTitle: true,
        backgroundColor: AllColor.deepBlueColor,
        title: const Text(
          'Weather',
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                dialogShow(context);
              },
              icon: Icon(
                Icons.search,
                color: AllColor.whiteColor,
                size: 25,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  cityName = 'auto:ip';
                  setState(() {});
                },
                icon: Icon(
                  Icons.location_on,
                  color: AllColor.whiteColor,
                  size: 25,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: weatherData.getWeather(cityName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(children: [
                          HomeComponent(
                            weatherModel: weatherModel!,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AllText.text('Weather By Hours', 24, FontWeight.w600,
                              AllColor.whiteColor),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  //  physics: NeverScrollableScrollPhysics() ,
                                  shrinkWrap: true,
                                  itemCount: weatherModel
                                      .forecast!.forecastday![0].hour!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    return Card(
                                      color: Colors.black12,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white10,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 15),
                                                  AllText.text(
                                                      weatherModel
                                                          .forecast!
                                                          .forecastday![0]
                                                          .hour![index]
                                                          .tempC!
                                                          .round()
                                                          .toStringAsPrecision(
                                                              2),
                                                      25,
                                                      FontWeight.w600,
                                                      AllColor.whiteColor),
                                                  AllText.text(
                                                      'o',
                                                      20,
                                                      FontWeight.w600,
                                                      Colors.red.shade600),
                                                ],
                                              ), 
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              CircleAvatar(
                                                  radius: 25, 
                                                  backgroundColor: Colors.white10,
                                                  backgroundImage: NetworkImage(
                                                      'https:${weatherModel.forecast!.forecastday![0].hour![index].condition!.icon!}')), 
                                                      const SizedBox(
                                                height: 5,
                                              ),
                                              AllText.text(
                                                  DateFormat.j().format(
                                                      DateTime.parse(
                                                          weatherModel
                                                              .forecast!
                                                              .forecastday![0]
                                                              .hour![index]
                                                              .time
                                                              .toString())),
                                                  17,
                                                  FontWeight.bold,
                                                  AllColor.whiteColor)
                                            ]),
                                      ),
                                    );
                                  })),
                            ),
                          ),
                          const SizedBox(height: 5),
                          AllText.text('Lust 7 Days Weather', 22,
                              FontWeight.w500, AllColor.whiteColor),
                          const SizedBox(height: 5),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8),
                              child: ListView.builder(
                                  itemCount: weatherModel
                                      .forecast!.forecastday!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Colors.black12,
                                      child: Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0, left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.network(
                                                      'https:${weatherModel.forecast!.forecastday![index].day!.condition!.icon}'),
                                                  AllText.text(
                                                      DateFormat.MMMEd().format(
                                                          DateTime.parse(
                                                              weatherModel
                                                                  .forecast!
                                                                  .forecastday![
                                                                      index]
                                                                  .date
                                                                  .toString())),
                                                      16,
                                                      FontWeight.bold,
                                                      AllColor.whiteColor),
                                                ],
                                              ),
                                              AllText.text(
                                                  weatherModel
                                                      .forecast!
                                                      .forecastday![index]
                                                      .day!
                                                      .condition!
                                                      .text
                                                      .toString(),
                                                  18,
                                                  FontWeight.bold,
                                                  AllColor.whiteColor),
                                              AllText.text(
                                                  '${weatherModel.forecast!.forecastday![index].day!.maxtempC!.round().toString()} / ${weatherModel.forecast!.forecastday![index].day!.mintempC!.round()}',
                                                  16,
                                                  FontWeight.bold,
                                                  AllColor.whiteColor)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ])),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Connection error'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
