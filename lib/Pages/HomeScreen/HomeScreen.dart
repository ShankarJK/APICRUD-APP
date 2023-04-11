// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:apiintegration/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:apiintegration/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:apiintegration/Pages/HomeScreen/HomeScreenVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../Helpers/Mixins/PopupMixin.dart';
import '../../Helpers/Mixins/TextfieldMixin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.extraData}) : super(key: key);
  final Object extraData;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   // Create a instance of HomeScreenVM
  final HomeScreenVM _homeScreenVM = HomeScreenVM();

   // Create a instance inputvalue for TextEditingController for create text field
  TextEditingController inputvalue = TextEditingController();

  // Create a instance inputvalue for TextEditingController for edit text field

  TextEditingController editfield = TextEditingController();

  /* Create a method showavengerdialog() to show popup for create action */
  void showavengerdialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Title(
                color: Colors.black, child: const Text("Create New Record")),
            contentPadding: const EdgeInsets.all(30),
            content: TextFormField(
              controller: inputvalue,
            ),
            actions: [
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    // Consume the createAvengers and pass the paramter as instance of text editing contoller
                    _homeScreenVM.createAvengers(name: inputvalue.text);
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: _homeScreenVM.closepopups,
                  child: const Text("Close",
                      style: TextStyle(color: Colors.white))),
            ],
          );
        });
  }

  /* Create a method editavengerdialog() to show popup for edit action */
  void editavengerdialog({required int index}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Title(
                color: Colors.black,
                child: const Text("Edit Exisiting Record")),
            contentPadding: const EdgeInsets.all(30),
            content: TextFormField(
              controller: editfield,
              onChanged: (text) => _homeScreenVM.textsend(value: text),
            ),
            actions: [
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    _homeScreenVM.textvalue = editfield.text;
                    _homeScreenVM.editAvenger(
                        index: index, values: _homeScreenVM.textvalue);
                  },
                  child: const Text("Edit",
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: _homeScreenVM.closepopups,
                  child: const Text("Close",
                      style: TextStyle(color: Colors.white))),
            ],
          );
        });
  }

   /* Invoke the initState() */
  @override
  void initState() {
     // Invoke super.initState()
    super.initState();

    // Create a listener for popupcontroller to listen the pop actions
    _homeScreenVM.popupcontroller.stream.listen((event) {
      if (event is Popup) {
        switch (event.data[1]) {
          case "showavengerdialog":
            {
              showavengerdialog();
              if (inputvalue.text != "") {
                inputvalue.text = "";
              }
              break;
            }
          case "editavengerdialog":
            {
              editavengerdialog(index: event.data[0]);
              // _homeScreenVM.textvalue = _homeScreenVM.allAvengers[event.data[0]].name.toString();
              editfield.text =
                  _homeScreenVM.allAvengers[event.data[0]].name.toString();
            }
        }
      }
    });

    //Using navigationstream and create a lister event
    _homeScreenVM.navigationStream.stream.listen((event) {
      // Checks for the condition event is NavigatorPush
      if (event is NavigatorPop) {
        // Using context.Push() pass the pageconfig and data
        context.pop(data: event.data, checkMounted: event.checkMounted);
      }
    });

    // Create a stream listener for textfield form
    _homeScreenVM.usertextcontroller.stream.listen((event) {
      if (event is Textfield) {
        editfield.text = event.data;
        editfield.selection =
            TextSelection.collapsed(offset: _homeScreenVM.textvalue.length);
      }
    });

    // invoke the fetchAllAvengers to get all the values from api
    _homeScreenVM.fetchAllAvengers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Project"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: MaterialButton(
              onPressed: () {
                _homeScreenVM.fetchAllAvengers();
              },
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Observer(
            builder: (context) {
              return Center(
                child: Visibility(
                  visible: _homeScreenVM.isAvengersLoading,
                  child: const CircularProgressIndicator(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Observer(builder: (context) {
              return Visibility(
                visible: !_homeScreenVM.isAvengersLoading,
                child: ListView.builder(
                  itemCount: _homeScreenVM.allAvengers.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading:
                          Text(_homeScreenVM.allAvengers[index].id.toString()),
                      title: Text(_homeScreenVM.allAvengers[index].name ?? ""),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  Colors.blue,
                                )),
                                onPressed: () {
                                  _homeScreenVM.editpopdisplay(indexs: index);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                            
                            IconButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  Colors.red,
                                )),
                                onPressed: () {
                                  _homeScreenVM.deleteAvenger(indexx: index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _homeScreenVM.popdisplayCreate();
          // _homeScreenVM.createAvengers(name: "newaveners");
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  /* Invoke the dispose() */
  @override
  void dispose() {
    // Using navigationStream.Close() close the stream
    _homeScreenVM.navigationStream.close();

    // Invoke closepopup()
    _homeScreenVM.closepopup();

    // Invoke super.dispose()
    super.dispose();
  }
}
