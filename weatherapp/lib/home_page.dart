import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
          Expanded(flex: 2, child: Container()),
        ]),
      ),
    );
  }
}
