// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:home_services_app/Screens/propertyList.dart';
import '../Providers/property.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key? key,
    required this.propertyItemsList,
  }) : super(key: key);

  final List<Property> propertyItemsList;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void navigateToPropertyType(String propType) {
    Navigator.of(context)
        .pushNamed(PropertiesList.route, arguments: propType.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      height: 80,
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 0, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Container(
              child: InkWell(
                child: Column(
                  children: [
                    SizedBox(
                        width: 250,
                        child: CircleAvatar(
                          child: Image.asset(
                              widget.propertyItemsList[index].imgUrl),
                        )),
                    SizedBox(
                      height: 1,
                    ),
                    Text(widget.propertyItemsList[index].title)
                  ],
                ),
                onTap: () {
                  navigateToPropertyType(widget.propertyItemsList[index].title);
                },
              ),
            );
          }),
    );
  }
}
