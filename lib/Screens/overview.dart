// ignore_for_file: unused_import, must_be_immutable, avoid_print, unused_local_variable

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_services_app/Providers/Property_api.dart';
import 'package:home_services_app/Providers/property.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';

class OverviewScreen extends StatelessWidget {
  static const route = "/OverviewScreen";

  static const List<String> sampleImages = [
    "https://media.istockphoto.com/id/473745680/photo/modern-architecture-design-93-for-house-bungalow.jpg?s=612x612&w=is&k=20&c=d7sNBltLc26h56D4ySbdx4pDoQ_Pt6JDHqO34oijQBY=",
    "https://images.unsplash.com/photo-1669462277329-f32f928a4a79?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1542840410-3092f99611a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];

  var path = "";

  OverviewScreen({super.key});

  _onShareData(BuildContext context, String dateToShare) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      dateToShare,
      subject: dateToShare,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final propertyId = ModalRoute.of(context)!.settings.arguments;
    final propertyData = Provider.of<PropertyApi>(context, listen: false)
        .findById(propertyId as String);
    final title = propertyData.title.toString();
    final address = propertyData.address.toString();
    final bathCount = propertyData.noOfBath.toString();
    final bedCount = propertyData.noOfBed.toString();
    final price = propertyData.price.toString();
    final totalRooms = propertyData.totalRooms.toString();
    final totalSq = propertyData.totalSqFeet.toString();
    final type = propertyData.type.toString();
    final desc = propertyData.desc.toString();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Property Details"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_outline),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Constants.secondaryColor,
                height: 285,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FanCarouselImageSlider(
                      initalPageIndex: 0,
                      imagesLink: sampleImages,
                      isAssets: false,
                      autoPlay: false,
                      userCanDrag: true,
                      sliderHeight: 230,
                      sliderWidth: double.infinity,
                      imageRadius: 15,
                      slideViewportFraction: 1,
                      turns: 250,
                      sidesOpacity: 0,
                      imageFitMode: BoxFit.cover,
                      currentItemShadow: const [
                        BoxShadow(offset: Offset(0, 0))
                      ],
                      sliderDuration: const Duration(microseconds: 300),
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Constants.secondaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: Constants.iconPrimaryColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(address)
                              ],
                            ),
                            onTap: () {
                              print("Location tapped");
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Constants.secondaryColor,
                            child: const Icon(
                              Icons.share,
                              color: Constants.iconPrimaryColor,
                            ),
                          ),
                          onTap: () {
                            _onShareData(context, "$title,$address");
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Constants.secondaryColor,
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.locationDot,
                                color: Constants.iconPrimaryColor,
                              ),
                            ),
                          ),
                          onTap: () =>
                              Navigator.of(context).pushNamed("/MapScreen"),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Constants.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.bed,
                              color: Constants.primaryColor,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text("No of beds: $bedCount"),
                          ],
                        ),
                        const VerticalDivider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.bath,
                              color: Constants.primaryColor,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text("No of baths: $bathCount"),
                          ],
                        ),
                        const VerticalDivider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.meeting_room,
                              color: Constants.primaryColor,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text("Total: $totalRooms"),
                          ],
                        ),
                        const VerticalDivider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.chartArea,
                              color: Constants.primaryColor,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text("$totalSq Sq ft"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 150,
                width: double.infinity,
                color: Constants.secondaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      desc,
                      trimLines: 2,
                      colorClickableText: Constants.iconPrimaryColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read More',
                      style:const  TextStyle(fontSize: 13),
                      trimExpandedText: ' Hide',
                    ),
                  ],
                ),
              ),
              Container(
                color: Constants.secondaryColor,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹$price",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.star,
                                color: Color(0XffFFD700),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0XffFFD700),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0XffFFD700),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Constants.iconPrimaryColor)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Book Now",
                            style: TextStyle(color: Constants.secondaryColor, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
