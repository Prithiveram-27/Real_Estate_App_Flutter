// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, file_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_services_app/Providers/Property_api.dart';
import 'package:home_services_app/Providers/property.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:image_picker/image_picker.dart';
import '../common.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});
  static const route = "/AddPropertyScreen";

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();

  final _priceController = TextEditingController();
  final _priceFocusNode = FocusNode();

  final _sqFeetController = TextEditingController();
  final _sqFeetFocusNode = FocusNode();

  final _addressController = TextEditingController();
  final _addressFocusNode = FocusNode();

  final _descController = TextEditingController();
  final _descFocusNode = FocusNode();

  String typedropdownValue = 'Home';
  String roomdropdownValue = '1';
  String beddropdownValue = '1';
  String bathdropdownValue = '1';
  var addImgBtnName = "Add images";

  var editedPropertyDetails = Property(
    id: '',
    title: "",
    type: "",
    imgUrl: "",
    price: "",
    address: "",
    totalSqFeet: 0,
    noOfBed: 1,
    noOfBath: 1,
    desc: "",
    totalRooms: 0,
    imgFiles: [],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _priceController.dispose();
    _priceFocusNode.dispose();
    _sqFeetController.dispose();
    _sqFeetFocusNode.dispose();
    _addressController.dispose();
    _addressFocusNode.dispose();
    _descController.dispose();
    _descFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final validate = _formKey.currentState?.validate();
    if (validate == false) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {});
    if (editedPropertyDetails.id != "") {
      try {
        // await Provider.of<Property>(context, listen: false)
        //     .updateProduct(editedPropertyDetails.id, editedPropertyDetails);
      } catch (error) {
        await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("An error occurred"),
                  content: const Text("Something went wrong"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"))
                  ],
                ));
      }
    } else {
      try {
        // Common.convertImageTobase64();
        await Provider.of<PropertyApi>(context, listen: false)
            .addProperty(editedPropertyDetails);
      } catch (error) {
        await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("An error occurred"),
                  content: const Text("Something went wrong"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"))
                  ],
                ));
      }
    }
    setState(() {});
    Navigator.of(context).pushNamed("/MyPropertiesList",arguments: "My Properties | add");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Property Details")),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // Second column
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          cursorColor: Constants.primaryColor,
                          decoration: const InputDecoration(
                            labelText: "Name of the Property",
                            labelStyle:
                                TextStyle(color: Constants.primaryColor),
                            focusColor: Constants.primaryColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          onSaved: (value) => {
                            editedPropertyDetails = Property(
                              id: editedPropertyDetails.id,
                              title: value.toString(),
                              type: editedPropertyDetails.type,
                              imgUrl: editedPropertyDetails.imgUrl,
                              price: editedPropertyDetails.price,
                              address: editedPropertyDetails.address,
                              totalSqFeet: editedPropertyDetails.totalSqFeet,
                              totalRooms: editedPropertyDetails.totalRooms,
                              noOfBed: editedPropertyDetails.noOfBed,
                              noOfBath: editedPropertyDetails.noOfBath,
                              desc: editedPropertyDetails.desc,
                              imgFiles: [],
                            )
                          },
                        ),
                        TextFormField(
                          controller: _priceController,
                          focusNode: _priceFocusNode,
                          cursorColor: Constants.primaryColor,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Price",
                            labelStyle:
                                TextStyle(color: Constants.primaryColor),
                            focusColor: Constants.primaryColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_addressFocusNode);
                          },
                          onSaved: (value) => {
                            editedPropertyDetails = Property(
                              id: editedPropertyDetails.id,
                              title: editedPropertyDetails.title,
                              type: editedPropertyDetails.type,
                              imgUrl: editedPropertyDetails.imgUrl,
                              price: value.toString(),
                              address: editedPropertyDetails.address,
                              totalSqFeet: editedPropertyDetails.totalSqFeet,
                              totalRooms: editedPropertyDetails.totalRooms,
                              noOfBed: editedPropertyDetails.noOfBed,
                              noOfBath: editedPropertyDetails.noOfBath,
                              desc: editedPropertyDetails.desc,
                              imgFiles: [],
                            )
                          },
                        ),
                        TextFormField(
                          controller: _addressController,
                          focusNode: _addressFocusNode,
                          cursorColor: Constants.primaryColor,
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                            labelText: "Address",
                            labelStyle:
                                TextStyle(color: Constants.primaryColor),
                            focusColor: Constants.primaryColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_sqFeetFocusNode);
                          },
                          onSaved: (value) => {
                            editedPropertyDetails = Property(
                              id: editedPropertyDetails.id,
                              title: editedPropertyDetails.title,
                              type: editedPropertyDetails.type,
                              imgUrl: editedPropertyDetails.imgUrl,
                              price: editedPropertyDetails.price,
                              address: value.toString(),
                              totalSqFeet: editedPropertyDetails.totalSqFeet,
                              totalRooms: editedPropertyDetails.totalRooms,
                              noOfBed: editedPropertyDetails.noOfBed,
                              noOfBath: editedPropertyDetails.noOfBath,
                              desc: editedPropertyDetails.desc,
                              imgFiles: [],
                            )
                          },
                        ),
                        TextFormField(
                          controller: _sqFeetController,
                          focusNode: _sqFeetFocusNode,
                          cursorColor: Constants.primaryColor,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: "Total Square Feet",
                            labelStyle:
                                TextStyle(color: Constants.primaryColor),
                            focusColor: Constants.primaryColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_descFocusNode);
                          },
                          onSaved: (value) => {
                            editedPropertyDetails = Property(
                              id: editedPropertyDetails.id,
                              title: editedPropertyDetails.title,
                              type: editedPropertyDetails.type,
                              imgUrl: editedPropertyDetails.imgUrl,
                              price: editedPropertyDetails.price,
                              address: editedPropertyDetails.address,
                              totalSqFeet: double.parse(value.toString()),
                              totalRooms: editedPropertyDetails.totalRooms,
                              noOfBed: editedPropertyDetails.noOfBed,
                              noOfBath: editedPropertyDetails.noOfBath,
                              desc: editedPropertyDetails.desc,
                              imgFiles: [],
                            )
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Type",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 70,
                              child: DropdownButtonFormField(
                                itemHeight: 50,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primaryColor,
                                        width: 1),
                                  ),
                                ),
                                dropdownColor: Constants.secondaryColor,
                                value: typedropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    typedropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Home',
                                  'Plot',
                                  'Apartments',
                                  'Buildings',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                                }).toList(),
                                onSaved: (value) => {
                                  editedPropertyDetails = Property(
                                    id: editedPropertyDetails.id,
                                    title: editedPropertyDetails.title,
                                    type: value.toString(),
                                    imgUrl: editedPropertyDetails.imgUrl,
                                    price: editedPropertyDetails.price,
                                    address: editedPropertyDetails.address,
                                    totalSqFeet:
                                        editedPropertyDetails.totalSqFeet,
                                    totalRooms:
                                        editedPropertyDetails.totalRooms,
                                    noOfBed: editedPropertyDetails.noOfBed,
                                    noOfBath: editedPropertyDetails.noOfBath,
                                    desc: editedPropertyDetails.desc,
                                    imgFiles: [],
                                  )
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.meeting_room,
                                        color: Constants.primaryColor,
                                      ),
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                            width: 1),
                                      ),
                                    ),
                                    dropdownColor: Constants.secondaryColor,
                                    value: roomdropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        roomdropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6',
                                      '7',
                                      '8',
                                      '9',
                                      '10'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      );
                                    }).toList(),
                                    onSaved: (value) => {
                                      editedPropertyDetails = Property(
                                        id: editedPropertyDetails.id,
                                        title: editedPropertyDetails.title,
                                        type: editedPropertyDetails.type,
                                        imgUrl: editedPropertyDetails.imgUrl,
                                        price: editedPropertyDetails.price,
                                        address: editedPropertyDetails.address,
                                        totalSqFeet:
                                            editedPropertyDetails.totalSqFeet,
                                        totalRooms: int.parse(value.toString()),
                                        noOfBed: editedPropertyDetails.noOfBed,
                                        noOfBath:
                                            editedPropertyDetails.noOfBath,
                                        desc: editedPropertyDetails.desc,
                                        imgFiles: [],
                                      )
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.bed,
                                      color: Constants.primaryColor,
                                    ),
                                    Text(
                                      " Bed ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 100,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                            width: 1),
                                      ),
                                    ),
                                    dropdownColor: Constants.secondaryColor,
                                    value: beddropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        beddropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      '1',
                                      '2',
                                      '3',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      );
                                    }).toList(),
                                    onSaved: (value) => {
                                      editedPropertyDetails = Property(
                                        id: editedPropertyDetails.id,
                                        title: editedPropertyDetails.title,
                                        type: editedPropertyDetails.type,
                                        imgUrl: editedPropertyDetails.imgUrl,
                                        price: editedPropertyDetails.price,
                                        address: editedPropertyDetails.address,
                                        totalSqFeet:
                                            editedPropertyDetails.totalSqFeet,
                                        totalRooms:
                                            editedPropertyDetails.totalRooms,
                                        noOfBed: int.parse(value.toString()),
                                        noOfBath:
                                            editedPropertyDetails.noOfBath,
                                        desc: editedPropertyDetails.desc,
                                        imgFiles: [],
                                      )
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.bath,
                                      color: Constants.primaryColor,
                                    ),
                                    Text(
                                      " Bath ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 100,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Constants.primaryColor,
                                            width: 1),
                                      ),
                                    ),
                                    dropdownColor: Constants.secondaryColor,
                                    value: bathdropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        bathdropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      '1',
                                      '2',
                                      '3',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      );
                                    }).toList(),
                                    onSaved: (value) => {
                                      editedPropertyDetails = Property(
                                        id: editedPropertyDetails.id,
                                        title: editedPropertyDetails.title,
                                        type: editedPropertyDetails.type,
                                        imgUrl: editedPropertyDetails.imgUrl,
                                        price: editedPropertyDetails.price,
                                        address: editedPropertyDetails.address,
                                        totalSqFeet:
                                            editedPropertyDetails.totalSqFeet,
                                        totalRooms:
                                            editedPropertyDetails.totalRooms,
                                        noOfBed: editedPropertyDetails.noOfBed,
                                        noOfBath: int.parse(value.toString()),
                                        desc: editedPropertyDetails.desc,
                                        imgFiles: [],
                                      )
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _descController,
                          focusNode: _descFocusNode,
                          autofocus: true,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 8,
                          cursorColor: Constants.primaryColor,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.primaryColor, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.primaryColor, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Constants.primaryColor),
                            ),
                            labelStyle:
                                TextStyle(color: Constants.primaryColor),
                            label: Text("Description"),
                            focusColor: Constants.primaryColor,
                          ),
                          onSaved: (value) => {
                            editedPropertyDetails = Property(
                              id: editedPropertyDetails.id,
                              title: editedPropertyDetails.title,
                              type: editedPropertyDetails.type,
                              imgUrl: editedPropertyDetails.imgUrl,
                              price: editedPropertyDetails.price,
                              address: editedPropertyDetails.address,
                              totalSqFeet: editedPropertyDetails.totalSqFeet,
                              totalRooms: editedPropertyDetails.totalRooms,
                              noOfBed: editedPropertyDetails.noOfBed,
                              noOfBath: editedPropertyDetails.noOfBath,
                              desc: value.toString(),
                              imgFiles: [],
                            )
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // const ImageInput(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                color: Constants.primaryColor,
                                // width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  child: Text(
                                    addImgBtnName,
                                    style: const TextStyle(
                                        color: Constants.secondaryColor),
                                  ),
                                  onPressed: () async {
                                    if (editedPropertyDetails
                                        .imgFiles.isNotEmpty) {
                                      ShowBottomSheetForImages(context, null,
                                          editedPropertyDetails.imgFiles, true);
                                    } else {
                                      final picker = ImagePicker();
                                      List<XFile> images =
                                          await picker.pickMultiImage();
                                      ShowBottomSheetForImages(
                                          context, images, null, false);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Constants.primaryColor,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Constants.secondaryColor),
                  ),
                  onPressed: () {
                    _saveForm();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowBottomSheetForImages(
      BuildContext context,
      List<XFile>? imagesArray,
      List<String>? imgbase64Array,
      bool isFilesSelected) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Selected Images",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: isFilesSelected
                      ? GridView.builder(
                          itemCount: imgbase64Array?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return Image.memory(base64Decode(imgbase64Array![index]));
                          })
                      : GridView.builder(
                          itemCount: imagesArray?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return Image.file(File(imagesArray![index].path));
                          }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Constants.primaryColor,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextButton(
                        child: const Text(
                          'Add More',
                          style: TextStyle(color: Constants.secondaryColor),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      color: Constants.primaryColor,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextButton(
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Constants.secondaryColor),
                        ),
                        onPressed: () async {
                          List<String> baseStringArray = [];
                          for (int i = 0; i < imagesArray!.length; i++) {
                            baseStringArray.add(
                                await Common.convertImageTobase64(
                                    imagesArray[i].path));
                          }
                          print(baseStringArray);
                          editedPropertyDetails = Property(
                            id: editedPropertyDetails.id,
                            title: editedPropertyDetails.title,
                            type: editedPropertyDetails.type,
                            imgUrl: editedPropertyDetails.imgUrl,
                            price: editedPropertyDetails.price,
                            address: editedPropertyDetails.address,
                            totalSqFeet: editedPropertyDetails.totalSqFeet,
                            totalRooms: editedPropertyDetails.totalRooms,
                            noOfBed: editedPropertyDetails.noOfBed,
                            noOfBath: editedPropertyDetails.noOfBath,
                            desc: editedPropertyDetails.desc,
                            imgFiles: baseStringArray,
                          );
                          print(editedPropertyDetails);
                          setState(() {
                            addImgBtnName = "View Images";
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ));
  }
}
