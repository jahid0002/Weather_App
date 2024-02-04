import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:weather/const/color.dart';
import 'package:weather/pages/home_page.dart';

class SpalashPage extends StatefulWidget {
  const SpalashPage({super.key});

  @override
  State<SpalashPage> createState() => _SpalashPageState();
}

class _SpalashPageState extends State<SpalashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WeatherBg(
            weatherType: WeatherType.thunder,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Positioned(
            bottom: 100,
            right: 60,
            child: Card( 
              color: Colors.black12,
              child: Container(  
                alignment: Alignment.center,
                height: 80,  
                width: 300,  
                decoration: BoxDecoration(  
                  borderRadius: BorderRadius.circular(30), 
                  
                ),
                child: AllText.text(
                    'WAETHER APP', 25, FontWeight.w900, AllColor.whiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
