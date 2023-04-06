// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:home_services_app/Providers/Property_api.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class NearByList extends StatelessWidget {
  const NearByList({
    Key? key,
  }) : super(key: key);

  Future<void> _fetchProperties(BuildContext context) async {
    await Provider.of<PropertyApi>(context, listen: false)
        .getRecentProperties();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProperties(context),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            )
          : Consumer<PropertyApi>(
              builder: (context, propertyData, _) => SizedBox(
                height: 350,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: propertyData.items.isNotEmpty
                      ? ListView.builder(
                          itemCount: propertyData.items.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: SizedBox(
                                height: 150,
                                child: Card(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 0, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: double.infinity,
                                            child: Image.network(
                                                "https://media.istockphoto.com/id/473745680/photo/modern-architecture-design-93-for-house-bungalow.jpg?s=612x612&w=is&k=20&c=d7sNBltLc26h56D4ySbdx4pDoQ_Pt6JDHqO34oijQBY="),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                propertyData.items[index].type,
                                                style: const TextStyle(
                                                    color: Constants
                                                        .iconPrimaryColor),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                propertyData.items[index].title,
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                propertyData
                                                    .items[index].address,
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${propertyData.items[index].noOfBed}BHK",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[800]),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "₹${propertyData.items[index].price}",
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    "/OverviewScreen",
                                    arguments: propertyData.items[index].id);
                              },
                            );
                          })
                      : const Center(
                          child: Text(
                            "No Recent data available",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                ),
              ),
            ),
    );
  }
}
