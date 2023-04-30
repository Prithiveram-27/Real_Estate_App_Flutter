// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/cupertino.dart';

import '../models/enums.dart';

class Property with ChangeNotifier {
  final String id;
  final String title;
  final String type;
  final String imgUrl;
  final String price;
  final String address;
  final double totalSqFeet;
  final int totalRooms;
  final int noOfBed;
  final int noOfBath;
  final String desc;
  final List<String> imgFiles;

  Property({
    required this.id,
    required this.title,
    required this.type,
    required this.imgUrl,
    required this.price,
    required this.address,
    required this.totalSqFeet,
    required this.totalRooms,
    required this.noOfBed,
    required this.noOfBath,
    required this.desc,
    required this.imgFiles,
  });
}

class PropertyTypes with ChangeNotifier {
  List<Property> get items {
    return [..._propertyTypes];
  }

  List<Property> _propertyTypes = [
    Property(
      id: 'p1',
      title: 'Plots',
      type: EnumPropertyTypes.plot.toString(),
      imgUrl: 'lib/assets/location.png',
      price: '45000',
      address: '1,abc,zxy,asd,asd,',
      totalSqFeet: 500.67,
      noOfBed: 2,
      noOfBath: 2,
      desc: "",
      totalRooms: 2,
      imgFiles: [],
    ),
    Property(
      id: 'p2',
      title: 'home',
      type: EnumPropertyTypes.house.toString(),
      imgUrl: 'lib/assets/house.png',
      price: '45000',
      address: '1,abc,zxy,asd,asd,',
      totalSqFeet: 500.67,
      noOfBed: 2,
      totalRooms: 2,
      noOfBath: 2,
      desc: "",
      imgFiles: [],
    ),
    Property(
      id: 'p3',
      title: 'Appartments',
      type: EnumPropertyTypes.apparments.toString(),
      imgUrl: 'lib/assets/apartment.png',
      price: '45000',
      address: '1,abc,zxy,asd,asd,',
      totalSqFeet: 500.67,
      noOfBed: 2,
      totalRooms: 2,
      noOfBath: 2,
      desc: "",
      imgFiles: [],
    ),
    Property(
      id: 'p4',
      title: 'Buildings',
      type: EnumPropertyTypes.buildings.toString(),
      imgUrl: 'lib/assets/bungalow.png',
      price: '45000',
      address: '1,abc,zxy,asd,asd,',
      totalSqFeet: 500.67,
      noOfBed: 2,
      totalRooms: 2,
      noOfBath: 2,
      desc: "",
      imgFiles: [],
    )
  ];
}
