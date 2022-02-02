// ignore_for_file: avoid_print, avoid_unnecessary_containers, unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, unrelated_type_equality_checks, file_names

import 'dart:convert';
import 'package:climastate/resultScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as htttp;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool clicked = false;
  final cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.red,
        leading: clicked
            ? IconButton(
                onPressed: () {
                  setState(() {
                    clicked = false;
                    cityController.clear();
                  });
                },
                icon: const Icon(Icons.cancel_rounded),
              )
            : const Icon(Icons.pin_drop),
        title: clicked
            ? Container(
                //margin: EdgeInsets.all(25),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: "Enter City Name",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  controller: cityController,
                ),
              )
            : const Text('Weather Map'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (clicked == true) {
                  clicked = false;
                } else {
                  clicked = true;
                }
              });
            },
            icon: clicked
                ? IconButton(
                    onPressed: () async {
                      getWether(city: cityController.text);
                    },
                    icon: const Icon(Icons.search),
                  )
                : const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
      ),
    );
  }

  getWether({required String city}) async {
    htttp.Response response = await htttp.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=9670239c9fb8fa66b04fc56b9f64eef9"),
    );
    String data = response.body;
    var decodeData = jsonDecode(data);

    var condition = decodeData['weather'][0]['main'];
    var temp = decodeData['main']['temp'];
    var cityname = decodeData['name'];
    var det = decodeData['weather'][0]['description'];
    var log = decodeData["coord"]['lon'];
    var lat = decodeData["coord"]['lat'];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
            status: condition,
            city: cityname,
            details: det,
            latitude: lat,
            logitude: log,
            temp: temp),
      ),
    );
  }
}
