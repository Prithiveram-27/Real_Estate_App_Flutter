// ignore_for_file: file_names, avoid_print

import 'package:flutter/foundation.dart';
import 'package:home_services_app/Providers/property.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertyApi with ChangeNotifier {
  List<Property> _propertyItems = [];

  List<Property> get items {
    return [..._propertyItems];
  }

  Property findById(String id) {
    return _propertyItems.firstWhere((property) => property.id == id);
  }

  Future<void> addProperty(Property propertyDetails) async {
    final url = Uri.parse(
        'https://home-services-app-e0c46-default-rtdb.firebaseio.com/Properties.json');
    final dateTime = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': propertyDetails.title,
          'description': propertyDetails.desc,
          'price': propertyDetails.price,
          'imageUrl': propertyDetails.imgUrl,
          'address': propertyDetails.address,
          'totalSqFeet': propertyDetails.totalSqFeet,
          'noOfBed': propertyDetails.noOfBed,
          'noOfBath': propertyDetails.noOfBath,
          'type': propertyDetails.type,
          'totalRooms': propertyDetails.totalRooms,
          'createdDate': dateTime.toIso8601String(),
        }),
      );

      final newProperty = Property(
          id: json.decode(response.body)['name'],
          title: propertyDetails.title,
          type: propertyDetails.type,
          imgUrl: propertyDetails.imgUrl,
          price: propertyDetails.price,
          address: propertyDetails.address,
          totalSqFeet: propertyDetails.totalSqFeet,
          noOfBed: propertyDetails.noOfBed,
          noOfBath: propertyDetails.noOfBath,
          desc: propertyDetails.desc,
          totalRooms: 0,
          imgFiles: []);
      _propertyItems.add(newProperty);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getProperties([bool filterByUser = false]) async {
    const filerValue = "";
    final url = Uri.parse(
        'https://home-services-app-e0c46-default-rtdb.firebaseio.com/Properties.json?$filerValue');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Property> loadedProperties = [];
      if (extractedData.isEmpty) {
        return;
      }
      extractedData.forEach((propertyId, propertyValue) {
        loadedProperties.add(
          Property(
            id: "",
            title: propertyValue['title'],
            desc: propertyValue['description'],
            price: propertyValue['price'],
            imgUrl: propertyValue['imageUrl'],
            address: propertyValue['address'],
            totalSqFeet: propertyValue['totalSqFeet'],
            noOfBed: propertyValue['noOfBed'],
            noOfBath: propertyValue['noOfBath'],
            type: propertyValue['type'],
            totalRooms: propertyValue['totalRooms'],
            imgFiles: [],
          ),
        );
      });
      _propertyItems = loadedProperties;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getRecentProperties() async {
    const filerValue = "";
    var currentDate = DateTime.now();
    var currentDate_1m =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);

    final url = Uri.parse(
        'https://home-services-app-e0c46-default-rtdb.firebaseio.com/Properties.json?$filerValue');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Property> loadedProperties = [];
      if (extractedData.isEmpty) {
        return;
      }
      extractedData.forEach((propertyId, propertyValue) {
        if (DateTime.parse(propertyValue['createdDate'])
            .isAfter(currentDate_1m)) {
          loadedProperties.add(
            Property(
              id: propertyId,
              title: propertyValue['title'],
              desc: propertyValue['description'],
              price: propertyValue['price'],
              imgUrl: propertyValue['imageUrl'],
              address: propertyValue['address'],
              totalSqFeet: propertyValue['totalSqFeet'],
              noOfBed: propertyValue['noOfBed'],
              noOfBath: propertyValue['noOfBath'],
              type: propertyValue['type'],
              totalRooms: propertyValue['totalRooms'],
              imgFiles: [],
            ),
          );
        }
      });
      _propertyItems = loadedProperties;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getFilteredProperties(String filtlerKey) async {
    var filerValue = "Plot";
    var currentDate = DateTime.now();
    var currentDate_1m =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);

    final url = Uri.parse(
        'https://home-services-app-e0c46-default-rtdb.firebaseio.com/Properties.json?orderBy="createdDate"&equalTo="$filerValue"');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Property> loadedProperties = [];
      if (extractedData.isEmpty) {
        return;
      }
      extractedData.forEach((propertyId, propertyValue) {
        if (DateTime.parse(propertyValue['createdDate'])
            .isAfter(currentDate_1m)) {
          loadedProperties.add(
            Property(
              id: "",
              title: propertyValue['title'],
              desc: propertyValue['description'],
              price: propertyValue['price'],
              imgUrl: propertyValue['imageUrl'],
              address: propertyValue['address'],
              totalSqFeet: propertyValue['totalSqFeet'],
              noOfBed: propertyValue['noOfBed'],
              noOfBath: propertyValue['noOfBath'],
              type: propertyValue['type'],
              totalRooms: propertyValue['totalRooms'],
              imgFiles: [],
            ),
          );
        }
      });
      _propertyItems = loadedProperties;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Property>> getSearchFilterProperties() async {
    final url = Uri.parse(
        'https://home-services-app-e0c46-default-rtdb.firebaseio.com/Properties.json');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Property> loadedProperties = [];
      if (extractedData.isEmpty) {
        return loadedProperties;
      }
      extractedData.forEach((propertyId, propertyValue) {
        loadedProperties.add(
          Property(
            id: "",
            title: propertyValue['title'],
            desc: propertyValue['description'],
            price: propertyValue['price'],
            imgUrl: propertyValue['imageUrl'],
            address: propertyValue['address'],
            totalSqFeet: propertyValue['totalSqFeet'],
            noOfBed: propertyValue['noOfBed'],
            noOfBath: propertyValue['noOfBath'],
            type: propertyValue['type'],
            totalRooms: propertyValue['totalRooms'],
            imgFiles: [],
          ),
        );
      });
      _propertyItems = loadedProperties;
      notifyListeners();
      return _propertyItems;
    } catch (error) {
      rethrow;
    }
  }
}
