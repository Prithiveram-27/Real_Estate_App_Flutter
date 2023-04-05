// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyPropertyListItem extends StatelessWidget {
  final String imgUrl;
  final String propType;
  final String title;
  final String address;
  final int noOfBed;
  final double price;

  const MyPropertyListItem(this.imgUrl, this.propType, this.title, this.address,
      this.noOfBed, this.price,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 150,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        propType,
                        style: const TextStyle(color: Colors.pink),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        address,
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$noOfBed BHK",
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                          const Spacer(),
                          Text(
                            '₹$price',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600),
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
        Navigator.of(context).pushNamed("/OverviewScreen");
      },
    );
  }
}
