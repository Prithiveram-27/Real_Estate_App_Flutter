// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_services_app/Providers/Property_api.dart';
import 'package:home_services_app/Providers/property.dart';
import 'package:home_services_app/Screens/addProperty.dart';
import 'package:home_services_app/Screens/mapView.dart';
import 'package:home_services_app/Screens/propertyList.dart';
import 'package:home_services_app/Screens/overview.dart';
import 'package:provider/provider.dart';
import 'Screens/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeData themeData() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(128, 128, 128, .1),
      100: Color.fromRGBO(128, 128, 128, .2),
      200: Color.fromRGBO(128, 128, 128, .3),
      300: Color.fromRGBO(128, 128, 128, .4),
      400: Color.fromRGBO(128, 128, 128, .5),
      500: Color.fromRGBO(128, 128, 128, .6),
      600: Color.fromRGBO(128, 128, 128, .7),
      700: Color.fromRGBO(128, 128, 128, .8),
      800: Color.fromRGBO(128, 128, 128, .9),
      900: Color.fromRGBO(128, 128, 128, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PropertyTypes>(
          create: (context) => PropertyTypes(),
        ),
        ChangeNotifierProvider<PropertyApi>(
          create: (context) => PropertyApi(),
        ),
        ChangeNotifierProvider<Property>(
          create: (context) => Property(
            id: '',
            address: '',
            desc: '',
            imgUrl: '',
            noOfBath: 0,
            noOfBed: 0,
            price: '',
            title: '',
            totalRooms: 0,
            totalSqFeet: 0,
            type: '',
          ),
        ),
      ],
      child: Consumer<PropertyTypes>(
        builder: (context, value, _) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: colorCustom,
            inputDecorationTheme: InputDecorationTheme(
                // border: const OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.green)),
                // focusedBorder: const OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.green)),
                // enabledBorder: const OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.green)),
                // errorBorder: const OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.green)),
                // focusedErrorBorder: const OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.green)),
                ),
          ),
          home: Home(),
          routes: {
            OverviewScreen.route: (context) => OverviewScreen(),
            AddPropertyScreen.route: (context) => AddPropertyScreen(),
            PropertiesList.route: (context) => PropertiesList(),
            MapViewController.route: (context) => MapViewController(),
          }, // SplashScreen(title: "Test"),
        ),
      ),
    );
  }
}
