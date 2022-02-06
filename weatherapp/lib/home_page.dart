import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/Forecastmodel.dart';
import 'package:weatherapp/data_service.dart';
import 'package:weatherapp/models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherInfo? _response;
  ForecastWeather? _result;
  List<String> tempForecastList = [];
  List<String> tempDescriptionList = [];
  List<String> windGustList = [];
  List<String> hoursToShow = [];

  List<int> maxTemperatureForecast = List.filled(7, 0);

  @override
  void dispose() {
    tempForecastList.clear();
    tempDescriptionList.clear();
    windGustList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size? screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Expanded(
            flex: 1,
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clear_sky.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _cityTextController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final response = await _dataService
                                    .getWeather(_cityTextController.text);
                                setState(() => _response = response);
                                final result =
                                    await _dataService.getWeatherForecast(
                                        lat: '18.5196', lon: '73.8553');
                                setState(() => _result = result);
                                print("Forecast dataaaaaa is:  + ${_result} ");
                                var timeNow = DateTime.now().hour;

                                for (int days = 1; days < 12; days++) {
                                  timeNow = timeNow % 24;
                                  timeNow == 0
                                      ? timeNow = 24
                                      : timeNow = timeNow;
                                  hoursToShow.add(timeNow.toString());
                                  timeNow++;
                                }

                                if (_result != null) {
                                  try {
                                    for (var i in result!.hourly) {
                                      print("i is+ ${i.temp}");
                                      var temp =
                                          (((i.temp - 32) / 1.800).round());

                                      tempForecastList.add(temp.toString());
                                      for (var j in i.weather) {
                                        String desc;
                                        desc = j.description
                                            .toString()
                                            .replaceAll("Description.", "");
                                        desc = desc.replaceAll("_", " ");
                                        tempDescriptionList.add(
                                            j.description != null ? desc : "");
                                      }
                                    }
                                    print("temp is : + ${tempForecastList}");
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            hintStyle: const TextStyle(color: Colors.black),
                            hintText: 'Search'.toUpperCase(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_response != null)
                      Align(
                        alignment: Alignment(0.0, 1.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: OverflowBox(
                            minWidth: 0.0,
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 0.0,
                            maxHeight: (MediaQuery.of(context).size.height / 4),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Card(
                                    color: Colors.black87,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 20, right: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  (_response != null)
                                                      ? '${_response!.name}'
                                                      : '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 50),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    (_response != null)
                                                        ? '${_response!.weather.elementAt(0).description}'
                                                        : '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                          color: Colors.white54,
                                                          fontSize: 22,
                                                        ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    (_response != null)
                                                        ? '${((_response!.main.temp - 32) / 1.800).round().toString()}\u2103'
                                                        : '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                          color: Colors.white54,
                                                        ),
                                                  ),
                                                  Text(
                                                    (_response != null)
                                                        ? 'min: ${((_response!.main.tempMin - 32) / 1.800).round().toString()}\u2103 / max: ${((_response!.main.tempMax - 32) / 1.800).round().toString()}\u2103'
                                                        : '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                          color: Colors.white54,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    child: Image.network(
                                                        'https://openweathermap.org/img/wn/${_response!.weather.elementAt(0).icon}.png'),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      (_response != null)
                                                          ? ' wind ${_response!.wind.speed} m/s'
                                                          : '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            color:
                                                                Colors.white54,
                                                            fontSize: 17,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                )),
          ),
          SizedBox(
            height: screenSize.height * 0.1,
          ),
          _result != null
              ? Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    child: Container(
                      color: Colors.black87,
                      height: screenSize.height * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                            child: Text(
                              "HOURLY FORECAST",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  for (var i = 0; i < 10; i++)
                                    forecastElement(
                                        context,
                                        7,
                                        tempForecastList[i],
                                        tempDescriptionList[i],
                                        i == 0 ? "Now" : hoursToShow[i]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(flex: 2, child: Container())
        ]),
      ),
    );
  }

  Widget forecastElement(
      context, daysFromNow, windSpeed, tempDescription, hoursToShow) {
    // List<String> hoursToShow = [];
    var now = new DateTime.now();
    var oneDayFromNow = now.add(new Duration(days: daysFromNow));

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Text(
              //   'High: ' + maxTemperature.toString() + ' °C',
              //   style: const TextStyle(color: Colors.white, fontSize: 20.0),
              // ),
              Text(
                hoursToShow.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Text(
                windSpeed.toString() + '\u2103',
                style: const TextStyle(color: Colors.white, fontSize: 20.0),
              ),

              Flexible(
                child: Text(
                  tempDescription.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
