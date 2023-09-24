// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields, use_key_in_widget_constructors, unused_field, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../Providers/property.dart';
import '../Widgets/categories.dart';
import '../Widgets/headingText.dart';
import '../Widgets/nearbyList.dart';
import '../Widgets/searchbarTemplate.dart';

class Home extends StatefulWidget {
  static const route = "/Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;

  double _headerHeight = 250;
  String? _currentAddress;
  Position? _currentPosition;
  String _currentLocation = "Enable GPS";

  Future<Position> position =
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  // Future<List<Placemark>> placemarks =
  //     placemarkFromCoordinates(52.2165157, 6.9437819);

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
        _currentLocation = "${place.locality}";
        print(_currentAddress);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void navigateToSelectedIndex(String i) {
    switch (i) {
      case "0":
        {
          print("Excellent");
        }
        break;

      case "1":
        {
          print("Good");
        }
        break;

      case "2":
        {
          Navigator.of(context).pushNamed("/AddPropertyScreen");
        }
        break;

      case "3":
        {
          Navigator.of(context)
              .pushNamed("/MyPropertiesList", arguments: "My Properties");
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final propertyItemsList = Provider.of<PropertyTypes>(context).items;

    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        height: 50,
        top: -20,
        backgroundColor: Colors.grey[900],
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.bookmark, title: 'Saved'),
          TabItem(icon: Icons.add_circle, title: ''),
          TabItem(icon: Icons.view_list, title: 'Properties'),
          TabItem(icon: Icons.account_box, title: 'Profile'),
        ],
        onTap: (int i) => navigateToSelectedIndex(i.toString()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your location",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _currentLocation,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        child: Icon(Icons.notifications),
                      )
                    ],
                  ),
                ),
              ),
              Searchbar(),
              HeadingText("Categories"),
              Categories(propertyItemsList: propertyItemsList),
              HeadingText("Recents"),
              NearByList(),
            ],
          ),
        ),
      ),
    );
  }
}
