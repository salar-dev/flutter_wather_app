import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:google_fonts_arabic/google_fonts_arabic.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool isComplete = false;
bool isComplete2 = false;

class _MyHomePageState extends State<MyHomePage> {

   getAllWeather() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude} :: ${position.longitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&appid=c31a89815396b65ea79bc715dd8ad79a&units=metric&lang=ar');

    var results = await jsonDecode(response.body);
          allWeather = await results;
        setState(() {
          isComplete = true;
        });

    city = first.subAdminArea;
    country = first.countryName;

    http.Response response2 = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=73ac3c3a79061693bbfd63e67c36bc19&units=metric&lang=ar');
    var results2 = jsonDecode(response2.body);

    nowTemp = await results2;

    setState(() {
      isComplete2 = true;
    });

  }

  var city = '';
  var country = '';
  var nowWeather;
  var allWeather;
  var nowTemp;

  String day1 = '';
  String day2 = '';
  String day3 = '';
  String day4 = '';
  String day5 = '';
  String day6 = '';
  String day7 = '';

  var currDt = DateFormat('EEEE').format(DateTime.now());

  @override
  void initState() {
    super.initState();

    // getCurrentTemp();
    // getCurrentWeather();
    getAllWeather();
    setState(() {
      if(currDt == 'Thursday'){
        day1 = 'الخميس';
        day2 = 'الجمعة';
        day3 = 'السبت';
        day4 = 'الاحد';
        day5 = 'الاثنين';
        day6 = 'الثلاثاء';
        day7 = 'الاربعاء';
      }else if(currDt == 'Friday'){
        day1 = 'الجمعة';
        day2 = 'السبت';
        day3 = 'الاحد';
        day4 = 'الاثنين';
        day5 = 'الثلاثاء';
        day6 = 'الاربعاء';
        day7 = 'الخميس';
      }else if(currDt == 'Saturday'){
        day1 = 'السبت';
        day2 = 'الاحد';
        day3 = 'الاثنين';
        day4 = 'الثلاثاء';
        day5 = 'الاربعاء';
        day6 = 'الخميس';
        day7 = 'الجمعة';
      }else if(currDt == 'Sunday'){
        day1 = 'الاحد';
        day2 = 'الاثنين';
        day3 = 'الثلاثاء';
        day4 = 'الاربعاء';
        day5 = 'الخميس';
        day6 = 'الجمعة';
        day7 = 'السبت';
      }else if(currDt == 'Monday'){
        day1 = 'الاثنين';
        day2 = 'الثلاثاء';
        day3 = 'الاربعاء';
        day4 = 'الخميس';
        day5 = 'الجمعة';
        day6 = 'السبت';
        day7 = 'الاحد';
      }else if(currDt == 'Tuesday'){
        day1 = 'الثلاثاء';
        day2 = 'الاربعاء';
        day3 = 'الخميس';
        day4 = 'الجمعة';
        day5 = 'السبت';
        day6 = 'الاحد';
        day7 = 'الاثنين';
      }else if(currDt == 'Wednesday'){
        day1 = 'الاربعاء';
        day2 = 'الخميس';
        day3 = 'الجمعة';
        day4 = 'السبت';
        day5 = 'الاحد';
        day6 = 'الاثنين';
        day7 = 'الثلاثاء';
      }
    });
  }


   //URL Launcher

   _launchURLWeatherPage() async {
     const url = 'https://openweathermap.org/';
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   instaUrl() async {
     const url = 'https://www.instagram.com/salar.dev/';
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   ////////


   String _nowWeather = '';
   String _todayMax = '';
   String _todayMin = '';
   String _nowIcon;
   String _mains = '';
   String _clouds = '';
   String _wind = '';

   String allDayMax2 = '', allDayMin2 = '', allDayMax3 = '', allDayMin3 = '',allDayMax4 = '',
       allDayMin4 = '',allDayMax5 = '', allDayMin5 = '', allDayMax6 = '', allDayMin6 = '',
       allDayMax7, allDayMin7 = '';

  String allDayMain2 = '', allDayMain3 = '',allDayMain4 = '',allDayMain5 = '',allDayMain6 = '',allDayMain7 = '';

      String iconName = '';

   String day2Icon;
   String day3Icon;
   String day4Icon;
   String day5Icon;
   String day6Icon;
   String day7Icon;

   String day2IconN = 'assets/sun.png';
   String day3IconN = 'assets/sun.png';
   String day4IconN = 'assets/sun.png';
   String day5IconN = 'assets/sun.png';
   String day6IconN = 'assets/sun.png';
   String day7IconN = 'assets/sun.png';


   RefreshFunc(){
     if(isComplete && isComplete2){
       _clouds = nowTemp['clouds']['all'].toString();
       _wind = nowTemp['wind']['speed'].toString().substring(0, nowTemp['wind']['speed'].toString().indexOf(".")).toString();
       _nowIcon = nowTemp['weather'][0]['icon'];
       _mains = nowTemp['weather'][0]['description'];
       _nowWeather = nowTemp['main']['temp'].toString().substring(0, nowTemp['main']['temp'].toString().indexOf(".")).toString();
       _todayMax = allWeather['daily'][0]['temp']['max'].toString().substring(0, allWeather['daily'][0]['temp']['max'].toString().indexOf(".")).toString();
       _todayMin = allWeather['daily'][0]['temp']['min'].toString().substring(0, allWeather['daily'][0]['temp']['min'].toString().indexOf(".")).toString();
       day2Icon = allWeather['daily'][1]['weather'][0]['icon'];
       day3Icon = allWeather['daily'][2]['weather'][0]['icon'];
       day4Icon = allWeather['daily'][3]['weather'][0]['icon'];
       day5Icon = allWeather['daily'][4]['weather'][0]['icon'];
       day6Icon = allWeather['daily'][5]['weather'][0]['icon'];
       day7Icon = allWeather['daily'][6]['weather'][0]['icon'];

       allDayMax2 = allWeather['daily'][1]['temp']['max'].toString().substring(0, allWeather['daily'][1]['temp']['max'].toString().indexOf(".")).toString();
       allDayMin2 = allWeather['daily'][1]['temp']['min'].toString().substring(0, allWeather['daily'][1]['temp']['min'].toString().indexOf(".")).toString();

       allDayMax3 = allWeather['daily'][2]['temp']['max'].toString().substring(0, allWeather['daily'][2]['temp']['max'].toString().indexOf(".")).toString();
       allDayMin3 = allWeather['daily'][2]['temp']['min'].toString().substring(0, allWeather['daily'][2]['temp']['min'].toString().indexOf(".")).toString();

       allDayMax4 = allWeather['daily'][3]['temp']['max'].toString().substring(0, allWeather['daily'][3]['temp']['max'].toString().indexOf(".")).toString();
       allDayMin4 = allWeather['daily'][3]['temp']['min'].toString().substring(0, allWeather['daily'][3]['temp']['min'].toString().indexOf(".")).toString();
       //
       allDayMax5 = allWeather['daily'][4]['temp']['max'].toString();
       allDayMin5 = allWeather['daily'][4]['temp']['min'].toString().substring(0, allWeather['daily'][4]['temp']['min'].toString().indexOf(".")).toString();

       allDayMax6 = allWeather['daily'][5]['temp']['max'].toString().substring(0, allWeather['daily'][5]['temp']['max'].toString().indexOf(".")).toString();
       allDayMin6 = allWeather['daily'][5]['temp']['min'].toString().substring(0, allWeather['daily'][5]['temp']['min'].toString().indexOf(".")).toString();

       allDayMax7 = allWeather['daily'][6]['temp']['max'].toString().substring(0, allWeather['daily'][6]['temp']['max'].toString().indexOf(".")).toString();
       allDayMin7 = allWeather['daily'][6]['temp']['min'].toString().substring(0, allWeather['daily'][6]['temp']['min'].toString().indexOf(".")).toString();

       allDayMain2 = allWeather['daily'][1]['weather'][0]['description'];
       allDayMain3 = allWeather['daily'][2]['weather'][0]['description'];
       allDayMain4 = allWeather['daily'][3]['weather'][0]['description'];
       allDayMain5 = allWeather['daily'][4]['weather'][0]['description'];
       allDayMain6 = allWeather['daily'][5]['weather'][0]['description'];
       allDayMain7 = allWeather['daily'][6]['weather'][0]['description'];

       print(day3Icon);
     }
   }



  @override
  Widget build(BuildContext context) {

    RefreshFunc();

    setState(() {
      if(_nowIcon == '01d'){
        iconName = 'assets/sun.png';
      }else if(_nowIcon == '01n') {
        iconName = 'assets/new-moon.png';
      }else if(_nowIcon == '02d'){
        iconName = 'assets/partly-cloudy-day.png';
      }else if(_nowIcon == '02n'){
        iconName = 'assets/night.png';
      }else if(_nowIcon == '03d'){
        iconName = 'assets/cloud.png';
      }else if(_nowIcon == '03n'){
        iconName = 'assets/cloud.png';
      }else if(_nowIcon == '04d'){
        iconName = 'assets/clouds.png';
      }else if(_nowIcon == '04n'){
        iconName = 'assets/clouds.png';
      }else if(_nowIcon == '09d'){
        iconName = 'assets/light-rain.png';
      }else if(_nowIcon == '09n'){
        iconName = 'assets/light-rain.png';
      }else if(_nowIcon == '10d'){
        iconName = 'assets/rain-cloud.png';
      }else if(_nowIcon == '10n'){
        iconName = 'assets/rainy-night.png';
      }else if(_nowIcon == '11d'){
        iconName = 'assets/storm.png';
      }else if(_nowIcon == '11n'){
        iconName = 'assets/stormy-night.png';
      }else if(_nowIcon == '13d'){
        iconName = 'assets/winter.png';
      }else if(_nowIcon == '13n'){
        iconName = 'assets/winter.png';
      }else if(_nowIcon == '50d'){
        iconName = 'assets/dust.png';
      }else if(_nowIcon == '50n'){
        iconName = 'assets/dust.png';
      }
      //////
      /////
      if(day2Icon == '01d'){
        day2IconN = 'assets/sun.png';
      }else if(day2Icon == '01n') {
        day2IconN = 'assets/new-moon.png';
      }else if(day2Icon == '02d'){
        day2IconN = 'assets/partly-cloudy-day.png';
      }else if(day2Icon == '02n'){
        day2IconN = 'assets/night.png';
      }else if(day2Icon == '03d'){
        day2IconN = 'assets/cloud.png';
      }else if(day2Icon == '03n'){
        day2IconN = 'assets/cloud.png';
      }else if(day2Icon == '04d'){
        day2IconN = 'assets/clouds.png';
      }else if(day2Icon == '04n'){
        day2IconN = 'assets/clouds.png';
      }else if(day2Icon == '09d'){
        day2IconN = 'assets/light-rain.png';
      }else if(day2Icon == '09n'){
        day2IconN = 'assets/light-rain.png';
      }else if(day2Icon == '10d'){
        day2IconN = 'assets/rain-cloud.png';
      }else if(day2Icon == '10n'){
        day2IconN = 'assets/rainy-night.png';
      }else if(day2Icon == '11d'){
        day2IconN = 'assets/storm.png';
      }else if(day2Icon == '11n'){
        day2IconN = 'assets/stormy-night.png';
      }else if(day2Icon == '13d'){
        day2IconN = 'assets/winter.png';
      }else if(day2Icon == '13n'){
        day2IconN = 'assets/winter.png';
      }else if(day2Icon == '50d'){
        day2IconN = 'assets/dust.png';
      }else if(day2Icon == '50n'){
        day2IconN = 'assets/dust.png';
      }
      //////
      /////
      if(day3Icon == '01d'){
        day3IconN = 'assets/sun.png';
      }else if(day3Icon == '01n') {
        day3IconN = 'assets/new-moon.png';
      }else if(day3Icon == '02d'){
        day3IconN = 'assets/partly-cloudy-day.png';
      }else if(day3Icon == '02n'){
        day3IconN = 'assets/night.png';
      }else if(day3Icon == '03d'){
        day3IconN = 'assets/cloud.png';
      }else if(day3Icon == '03n'){
        day3IconN = 'assets/cloud.png';
      }else if(day3Icon == '04d'){
        day3IconN = 'assets/clouds.png';
      }else if(day3Icon == '04n'){
        day3IconN = 'assets/clouds.png';
      }else if(day3Icon == '09d'){
        day3IconN = 'assets/light-rain.png';
      }else if(day3Icon == '09n'){
        day3IconN = 'assets/light-rain.png';
      }else if(day3Icon == '10d'){
        day3IconN = 'assets/rain-cloud.png';
      }else if(day3Icon == '10n'){
        day3IconN = 'assets/rainy-night.png';
      }else if(day3Icon == '11d'){
        day3IconN = 'assets/storm.png';
      }else if(day3Icon == '11n'){
        day3IconN = 'assets/stormy-night.png';
      }else if(day3Icon == '13d'){
        day3IconN = 'assets/winter.png';
      }else if(day3Icon == '13n'){
        day3IconN = 'assets/winter.png';
      }else if(day3Icon == '50d'){
        day3IconN = 'assets/dust.png';
      }else if(day3Icon == '50n'){
        day3IconN = 'assets/dust.png';
      }
      //////
      /////
      if(day4Icon == '01d'){
        day4IconN = 'assets/sun.png';
      }else if(day4Icon == '01n') {
        day4IconN = 'assets/new-moon.png';
      }else if(day4Icon == '02d'){
        day4IconN = 'assets/partly-cloudy-day.png';
      }else if(day4Icon == '02n'){
        day4IconN = 'assets/night.png';
      }else if(day4Icon == '03d'){
        day4IconN = 'assets/cloud.png';
      }else if(day4Icon == '03n'){
        day4IconN = 'assets/cloud.png';
      }else if(day4Icon == '04d'){
        day4IconN = 'assets/clouds.png';
      }else if(day4Icon == '04n'){
        day4IconN = 'assets/clouds.png';
      }else if(day4Icon == '09d'){
        day4IconN = 'assets/light-rain.png';
      }else if(day4Icon == '09n'){
        day4IconN = 'assets/light-rain.png';
      }else if(day4Icon == '10d'){
        day4IconN = 'assets/rain-cloud.png';
      }else if(day4Icon == '10n'){
        day4IconN = 'assets/rainy-night.png';
      }else if(day4Icon == '11d'){
        day4IconN = 'assets/storm.png';
      }else if(day4Icon == '11n'){
        day4IconN = 'assets/stormy-night.png';
      }else if(day4Icon == '13d'){
        day4IconN = 'assets/winter.png';
      }else if(day4Icon == '13n'){
        day4IconN = 'assets/winter.png';
      }else if(day4Icon == '50d'){
        day4IconN = 'assets/dust.png';
      }else if(day4Icon == '50n'){
        day4IconN = 'assets/dust.png';
      }
      //////
      /////
      if(day5Icon == '01d'){
        day5IconN = 'assets/sun.png';
      }else if(day5Icon == '01n') {
        day5IconN = 'assets/new-moon.png';
      }else if(day5Icon == '02d'){
        day5IconN = 'assets/partly-cloudy-day.png';
      }else if(day5Icon == '02n'){
        day5IconN = 'assets/night.png';
      }else if(day5Icon == '03d'){
        day5IconN = 'assets/cloud.png';
      }else if(day5Icon == '03n'){
        day5IconN = 'assets/cloud.png';
      }else if(day5Icon == '04d'){
        day5IconN = 'assets/clouds.png';
      }else if(day5Icon == '04n'){
        day5IconN = 'assets/clouds.png';
      }else if(day5Icon == '09d'){
        day5IconN = 'assets/light-rain.png';
      }else if(day5Icon == '09n'){
        day5IconN = 'assets/light-rain.png';
      }else if(day5Icon == '10d'){
        day5IconN = 'assets/rain-cloud.png';
      }else if(day5Icon == '10n'){
        day5IconN = 'assets/rainy-night.png';
      }else if(day5Icon == '11d'){
        day5IconN = 'assets/storm.png';
      }else if(day5Icon == '11n'){
        day5IconN = 'assets/stormy-night.png';
      }else if(day5Icon == '13d'){
        day5IconN = 'assets/winter.png';
      }else if(day5Icon == '13n'){
        day5IconN = 'assets/winter.png';
      }else if(day5Icon == '50d'){
        day5IconN = 'assets/dust.png';
      }else if(day5Icon == '50n'){
        day5IconN = 'assets/dust.png';
      }
      //////
      /////
      if(day6Icon == '01d'){
        day6IconN = 'assets/sun.png';
      }else if(day6Icon == '01n') {
        day6IconN = 'assets/new-moon.png';
      }else if(day6Icon == '02d'){
        day6IconN = 'assets/partly-cloudy-day.png';
      }else if(day6Icon == '02n'){
        day6IconN = 'assets/night.png';
      }else if(day6Icon == '03d'){
        day6IconN = 'assets/cloud.png';
      }else if(day6Icon == '03n'){
        day6IconN = 'assets/cloud.png';
      }else if(day6Icon == '04d'){
        day6IconN = 'assets/clouds.png';
      }else if(day6Icon == '04n'){
        day6IconN = 'assets/clouds.png';
      }else if(day6Icon == '09d'){
        day6IconN = 'assets/light-rain.png';
      }else if(day6Icon == '09n'){
        day6IconN = 'assets/light-rain.png';
      }else if(day6Icon == '10d'){
        day6IconN = 'assets/rain-cloud.png';
      }else if(day6Icon == '10n'){
        day6IconN = 'assets/rainy-night.png';
      }else if(day6Icon == '11d'){
        day6IconN = 'assets/storm.png';
      }else if(day6Icon == '11n'){
        day6IconN = 'assets/stormy-night.png';
      }else if(day6Icon == '13d'){
        day6IconN = 'assets/winter.png';
      }else if(day6Icon == '13n'){
        day6IconN = 'assets/winter.png';
      }else if(day6Icon == '50d'){
        day6IconN = 'assets/dust.png';
      }else if(day6Icon == '50n'){
        day6IconN = 'assets/dust.png';
      }
      //////
      /////
      if(day7Icon == '01d'){
        day7IconN = 'assets/sun.png';
      }else if(day7Icon == '01n') {
        day7IconN = 'assets/new-moon.png';
      }else if(day7Icon == '02d'){
        day7IconN = 'assets/partly-cloudy-day.png';
      }else if(day7Icon == '02n'){
        day7IconN = 'assets/night.png';
      }else if(day7Icon == '03d'){
        day7IconN = 'assets/cloud.png';
      }else if(day7Icon == '03n'){
        day7IconN = 'assets/cloud.png';
      }else if(day7Icon == '04d'){
        day7IconN = 'assets/clouds.png';
      }else if(day7Icon == '04n'){
        day7IconN = 'assets/clouds.png';
      }else if(day7Icon == '09d'){
        day7IconN = 'assets/light-rain.png';
      }else if(day7Icon == '09n'){
        day7IconN = 'assets/light-rain.png';
      }else if(day7Icon == '10d'){
        day7IconN = 'assets/rain-cloud.png';
      }else if(day7Icon == '10n'){
        day7IconN = 'assets/rainy-night.png';
      }else if(day7Icon == '11d'){
        day7IconN = 'assets/storm.png';
      }else if(day7Icon == '11n'){
        day7IconN = 'assets/stormy-night.png';
      }else if(day7Icon == '13d'){
        day7IconN = 'assets/winter.png';
      }else if(day7Icon == '13n'){
        day7IconN = 'assets/winter.png';
      }else if(day7Icon == '50d'){
        day7IconN = 'assets/dust.png';
      }else if(day7Icon == '50n'){
        day7IconN = 'assets/dust.png';
      }


      // print('$_nowIcon >> $iconName');
    });

    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return isComplete ? Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.info_outline,
                    color: Colors.blueAccent,
                      size: _width * 0.065,
                    ),
                    onPressed: (){
                      showDialog(context: context,
                      builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        content: Container(
                          width: _width * 0.16,
                          height: _height * 0.46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff00257A),
                                Color(0xff0034AE),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('تطبيق الطقس',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: _height * 0.040,
                                ),
                                ),
                                SizedBox(width: 3),
                                Text('تنبؤات الطقس لـ ستة ايام قادمة',
                                  textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: _height * 0.025,
                                ),
                                ),
                                SizedBox(width: 3),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('يتم جلب معلومات الطقس من',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: _height * 0.025,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    GestureDetector(
                                      onTap: (){
                                        _launchURLWeatherPage();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.link,
                                            color: Colors.white.withOpacity(0.8),
                                            size: _height * 0.033,
                                          ),
                                          SizedBox(width: 3),
                                          Text('Open Weather Map',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: _height * 0.030,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: _height * 0.030,),
                                    GestureDetector(
                                      onTap: (){
                                        instaUrl();
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/salardev.png',
                                          width: _height * 0.14,
                                            height: _height * 0.14,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: _height * 0.008,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Salar Dev',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.green.shade800,
                                                  fontSize: _height * 0.022,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(' برمجة وتطوير',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.6),
                                                  fontSize: _height * 0.022,
                                                ),
                                              ),
                                            ],
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
                      ),
                      );
                    }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: _height * 0.07,),
                    Text('$city / $country',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: _width * 0.060,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                    ),
                    SizedBox(width: _width * 0.020,),
                    Icon(Icons.location_pin,
                    color: Colors.blueAccent,
                      size: _width * 0.055,
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.refresh,
                      color: Colors.blueAccent,
                      size: _width * 0.065,
                    ),
                    onPressed: (){
                      getAllWeather();
                      RefreshFunc();
                    }
                ),
              ],
            ),
            SizedBox(height: _height * 0.020,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
              child: GestureDetector(
                onTap: (){
                  var currHh = DateFormat('jm').format(DateTime.now()).replaceAll('PM', 'م').replaceAll('AM', 'ص');
                  setState(() {
                    currHh = DateFormat('jm').format(DateTime.now()).replaceAll('PM', 'م').replaceAll('AM', 'ص');
                  });
                  showDialog(context: context,
                    builder: (_) => AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      elevation: 20,
                      backgroundColor: Colors.transparent,
                      content: Container(
                        width: _width * 0.18,
                        height: _height * 0.46,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(25)),
                         gradient: LinearGradient(
                           begin: Alignment.bottomLeft,
                           end: Alignment.topRight,
                           colors: [
                             Color(0xff00257A),
                             Color(0xff0034AE),
                           ],
                         ),
                       ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(currHh,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.033,
                                    ),
                                  ),
                                  Text(' $day1 ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.033,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$_nowWeather°',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.08,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text('درجة الحرارة الان',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.023,
                                    ),
                                  ),
                                  Icon(Icons.thermostat_outlined,
                                    color: Colors.white.withOpacity(0.7),
                                    size: _height * 0.031,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$_todayMin°',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.020,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text('والصفرى ',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.018,
                                    ),
                                  ),
                                  Text(' $_todayMax°',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.020,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(' درجة الحرارة الكبرى لهذا اليوم ',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: _height * 0.016,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: _height * 0.027),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: _width * 0.25,
                                        height: _height * 0.040,
                                        color: Colors.white.withOpacity(0.7),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('الرياح',
                                                style: TextStyle(
                                                  color: Color(0xff0034AE),
                                                  fontSize: _height * 0.028,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: _width * 0.005,),
                                              Image.asset('assets/air.png',
                                              width: _height * 0.030,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.25,
                                        height: _height * 0.080,
                                        color: Colors.white.withOpacity(0.5),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('$_wind',
                                                style: TextStyle(
                                                  color: Color(0xff0034AE),
                                                  fontSize: _height * 0.045,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text('km/h',
                                                style: TextStyle(
                                                  color: Color(0xff0034AE),
                                                  fontSize: _height * 0.028,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  /////
                                  /////
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: _width * 0.25,
                                        height: _height * 0.040,
                                        color: Colors.white.withOpacity(0.7),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('الغيوم',
                                              style: TextStyle(
                                                color: Color(0xff0034AE),
                                                fontSize: _height * 0.028,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              ),
                                              SizedBox(width: _width * 0.005,),
                                              Icon(Icons.cloud,
                                                color: Color(0xff0034AE),
                                                size: _width * 0.060,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.25,
                                        height: _height * 0.080,
                                        color: Colors.white.withOpacity(0.5),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('$_clouds',
                                              style: TextStyle(
                                                color: Color(0xff0034AE),
                                                fontSize: _height * 0.045,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              ),
                                              Text('%',
                                                style: TextStyle(
                                                  color: Color(0xff0034AE),
                                                  fontSize: _height * 0.028,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: _height * 0.030),
                              GestureDetector(
                                onTap: (){
                                  _launchURLWeatherPage();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('openweathermap.org',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: _height * 0.018,
                                      ),
                                    ),
                                    Text('مصدر البيانات من ',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: _height * 0.020,
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(iconName,
                      height: _width * 0.30,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        Text('$_nowWeather°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _width * 0.15,
                          ),
                        ),
                        Text('$_todayMax° / $_todayMin°',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: _width * 0.050,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('$day1',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: _width * 0.060,
                        ),
                        ),
                        Text('$_mains',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _width * 0.045,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.020,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DaysWeather(
                  theDay: day3,
                  dayIcon: day3IconN,
                  dayMax: allDayMax3,
                  dayMin: allDayMin3,
                  main: allDayMain3,
                ),
                DaysWeather(
                  theDay: day2,
                  dayIcon: day2IconN,
                  dayMax: allDayMax2,
                  dayMin: allDayMin2,
                  main: allDayMain2,
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.012,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DaysWeather(
                  theDay: day5,
                  dayIcon: day5IconN,
                  dayMax: allDayMax5,
                  dayMin: allDayMin5,
                  main: allDayMain5,
                ),
                DaysWeather(
                  theDay: day4,
                  dayIcon: day4IconN,
                  dayMax: allDayMax4,
                  dayMin: allDayMin4,
                  main: allDayMain4,
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.012,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DaysWeather(
                  theDay: day7,
                  dayIcon: day7IconN,
                  dayMax: allDayMax7,
                  dayMin: allDayMin7,
                  main: allDayMain7,
                ),
                DaysWeather(
                  theDay: day6,
                  dayIcon: day6IconN,
                  dayMax: allDayMax6,
                  dayMin: allDayMin6,
                  main: allDayMain6,
                ),
              ],
            ),
          ],
        ),
      ),
    ): SplashScreen();
  }
}

class DaysWeather extends StatelessWidget {
  final String theDay;
  final String dayIcon;
  final String dayMax;
  final String dayMin;
  final String main;

  const DaysWeather({Key key,
    this.theDay = '',
    this.dayIcon,
    this.dayMax = '',
    this.dayMin = '',
    this.main = '',
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;


    return Container(
      width: _width * 0.44,
      height: _height * 0.21,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xff00257A),
            Color(0xff0034AE),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('$theDay',
              style: TextStyle(
                color: Colors.white,
                fontSize: _height * 0.028,
              ),
            ),
            Image.asset('$dayIcon',
              height: _height * 0.09,
            ),
            Text('$dayMax° / $dayMin°',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: _height * 0.018,
              ),
            ),
            Text('$main',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: _height * 0.021,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff161616),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/intro2.gif',
              width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 1),
              Text(' ...جاري الاتصال',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
