// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlineSearchBar(
        borderColor: Colors.black,
        borderWidth: 3.0,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        searchButtonIconColor: Colors.grey[800],
        hintText: "Search",
        enableSuggestions: true,
      ),
    );
  }
}
