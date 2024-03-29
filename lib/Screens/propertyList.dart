import 'package:flutter/material.dart';
import 'package:home_services_app/Providers/Property_api.dart';
import 'package:home_services_app/Screens/home.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:provider/provider.dart';
import '../Widgets/myPropertyListItem.dart';
import '../constants.dart';

class PropertiesList extends StatefulWidget {
  const PropertiesList({super.key});
  static const route = "/MyPropertiesList";

  @override
  State<PropertiesList> createState() => _PropertiesListState();
}

class _PropertiesListState extends State<PropertiesList> {
  var typedropdownValue = "Home";
  var searchBarController = TextEditingController();
  var searchText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _fetchProperties(BuildContext context) async {
    await Provider.of<PropertyApi>(context, listen: false)
        .getSearchFilterProperties();
  }

  @override
  Widget build(BuildContext context) {
    final titleStr = ModalRoute.of(context)?.settings.arguments;
    final List<String> backTap = titleStr.toString().split("|");
    return WillPopScope(
      onWillPop: () async {
        if (backTap.toString().toLowerCase().contains("add") == true) {
          Navigator.of(context).pushNamed(Home.route);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(backTap[0].toString()),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlineSearchBar(
                    autoCorrect: true,
                    ignoreSpecialChar: true,
                    borderColor: Constants.primaryColor,
                    borderWidth: 3.0,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    searchButtonIconColor: Colors.grey[800],
                    hintText: "Search",
                    enableSuggestions: true,
                    cursorColor: Constants.primaryColor,
                    clearButtonColor: Constants.primaryColor,
                    textEditingController: searchBarController,
                    onSearchButtonPressed: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    onClearButtonPressed: (value) {
                      setState(() {
                        searchText = "";
                      });
                    },
                  ),
                ),
                SizedBox(
                  // color: Colors.red,
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: _fetchProperties(context),
                    builder: (context, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Constants.primaryColor,
                          ))
                        : Center(
                            child: RefreshIndicator(
                            onRefresh: () => _fetchProperties(context),
                            child: Consumer<PropertyApi>(
                              builder: (context, propertydata, _) => Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: propertydata.items.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: propertydata.items.length,
                                          itemBuilder: (_, index) => Column(
                                            children: [
                                              (propertydata.items[index].title)
                                                          .toLowerCase()
                                                          .contains(searchText
                                                              .toLowerCase()) ||
                                                      ((propertydata
                                                              .items[index]
                                                              .address)
                                                          .toLowerCase()
                                                          .contains(searchText
                                                              .toLowerCase()))
                                                  ? MyPropertyListItem(
                                                    propertydata.items[index].id,
                                                      propertydata
                                                          .items[index].imgUrl,
                                                      propertydata
                                                          .items[index].type,
                                                      propertydata
                                                          .items[index].title,
                                                      propertydata
                                                          .items[index].address,
                                                      propertydata
                                                          .items[index].noOfBed,
                                                      double.parse(propertydata
                                                          .items[index].price),
                                                    )
                                                  : const SizedBox(
                                                      width: 1,
                                                    )
                                            ],
                                          ),
                                        )
                                      : const Center(
                                          child: Text("No data available"),
                                        )),
                            ),
                          )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
