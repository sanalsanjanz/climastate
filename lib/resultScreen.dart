// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unnecessary_const, file_names
import 'dart:async';

import 'package:climastate/const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen(
      {Key? key,
      required this.status,
      required this.city,
      required this.details,
      required this.latitude,
      required this.logitude,
      required this.temp})
      : super(key: key);
  final status;
  final city;
  final temp;
  final details;
  final latitude;
  final logitude;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String timeString;
  late var temp;
  late var citty;
  late var dett;
  late var statuss;
  late var lats;
  late var long;
  @override
  void initState() {
    super.initState();
    final abc = widget.temp;
    final city = widget.city;
    final det = widget.details;
    final status = widget.status;
    final lat = widget.latitude, lon = widget.logitude;
    setState(() {
      print("avc");
      temp = abc;
      citty = city;
      dett = det;
      statuss = status;
      lats = lat;
      long = lon;
    });
    timeString = formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
  }

  bool latitude = true;
  bool longitude = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 250,
                      // temp: temp,
                      child: LottieBuilder.asset(
                        dett == "clear sky"
                            ? 'assets/sunny.json'
                            : dett == 'broken clouds'
                                ? 'assets/cloudy.json'
                                : dett == 'fog'
                                    ? "assets/broken.json"
                                    : dett == 'haze'
                                        ? 'assets/thunderstrome.json'
                                        : dett == 'few clouds' ||
                                                dett == "FEW CLOUDS"
                                            ? "assets/sky.json"
                                            : 'assets/2.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            citty.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: kTextStyle,
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Text(temp.toString() + " \u2103",
                              textAlign: TextAlign.center, style: kHeadStyle),
                          Divider(
                            color: Colors.grey[400],
                          ),
                          Text(
                            dett.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 100,
                //duration: Duration(seconds: 2),
                child: Center(
                  child: Text(
                    statuss.toUpperCase(),
                    style: kTextStyle,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(
                  child: const Text(
                    'Geographical Location',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (latitude == true) {
                          latitude = false;
                        } else {
                          latitude = true;
                        }
                      });
                    },
                    child: SizedBox(
                        child: Center(
                          child: Text(
                            latitude ? "LATITUDE" : '$lats',
                            style: kTextStyle,
                          ),
                        ),
                        height: 100),
                  ),
                ),
                Container(
                  height: 80,
                  color: Colors.grey,
                  width: 1,
                ),
                Expanded(
                  child: InkWell(
                    onDoubleTap: () {},
                    onTap: () {
                      setState(() {
                        if (longitude == true) {
                          longitude = false;
                        } else {
                          longitude = true;
                        }
                      });
                    },
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          longitude ? "LONGITUDE" : '$long',
                          style: kTextStyle,
                        ),
                      ),
                      height: 100,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                child: Center(
                  child: Text(
                    timeString,
                    style: kTextStyle,
                  ),
                ),
                height: 150,
              ),
              Container(
                  color: Colors.red,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'RECHECK',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  height: 80),
            ],
          ),
        ),
      ),
    );
  }

  void getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);
    setState(() {
      timeString = formattedDateTime;
    });
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }
}
