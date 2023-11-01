import 'dart:async';

//import 'dart:html';

import 'package:dictionary_project/db/dictionary.dart';
import 'package:dictionary_project/pages/drawer.dart';
import 'package:dictionary_project/pages/history.dart';
import 'package:dictionary_project/pages/malayalamsearch/malayalamhistory.dart';
import 'package:dictionary_project/pages/malayalamsearch/searchfunction.dart';
import 'package:flutter/material.dart';

class malayalamsearch extends StatefulWidget {
  const malayalamsearch({super.key});

  @override
  State<malayalamsearch> createState() => _malayalamsearchState();
}

class _malayalamsearchState extends State<malayalamsearch> {
  get selectedOption => null;

  get ctx => null;

  late Future<List<MyData>> searchMeaning = Future.value([]);
  late List historyMalayalam = [];
  String searchWordFilter = 'Start';
  Color startcolor = Colors.black;
  Color containcolor = Colors.grey;
  Color endcolor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // search world................................................
                FutureBuilder<List<MyData>>(
                  future: searchMeaning,
                  builder: (BuildContext ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Center(child: Text('തിരയുക ')),
                      );
                    } else {
                      // Display your data here
                      return Expanded(
                        child: Card(
                          child: ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.data![index];
                                return ListTile(
                                  title: Text(item.english_word),
                                  subtitle: Text(item.malayalam_definition),
                                  trailing: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.part_of_speech.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Card(
                                  child: Divider(
                                    height: 3,
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    color: Colors.red,
                  ),
                )
              ]),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => popupMalayalam(
                                      historyMalayalam: historyMalayalam)));
                        });
                      },
                      icon: const Icon(
                        Icons.history,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        //height: 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: 200,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'തിരയുക '),
                                controller: searchController,
                                onChanged: (text) {})),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                          onPressed: () async {
                            var searchEng = await searchWordMalayalam(
                                searchController.text, searchWordFilter);

                            setState(() {
                              searchMeaning = Future.value(searchEng);

                              if (searchController.text.toString() != "") {
                                historyMalayalam
                                    .add(searchController.text.toString());
                              }
                            });
                          },
                          icon: const Icon(Icons.search, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            searchWordFilter = 'start';

                            startcolor = Colors.black;
                            containcolor = Colors.grey;
                            endcolor = Colors.grey;
                          });
                        },
                        child: Text('Start With',
                            style: TextStyle(color: startcolor)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              searchWordFilter = 'contains';

                              startcolor = Colors.grey;
                              containcolor = Colors.black;
                              endcolor = Colors.grey;
                            });
                          },
                          child: Text('Contain',
                              style: TextStyle(color: containcolor)))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              searchWordFilter = 'end';

                              startcolor = Colors.grey;
                              containcolor = Colors.grey;
                              endcolor = Colors.blue;
                            });
                          },
                          child: Text('End With',
                              style: TextStyle(color: endcolor)))
                    ],
                  ),
                )
              ],
            )
          ]),
        ],
      ),
    );
  }
}



    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     drawer: drawerpage(),
    //     appBar: AppBar(
    //       backgroundColor: Colors.black,
    //       //   bottom: TabBar(
    //     isScrollable: true,
    //     indicator: BoxDecoration(
    //         borderRadius: BorderRadius.circular(50),
    //         color: Colors.greenAccent),
    //     tabs: [
    //       Expanded(
    //         child: Column(
    //           children: [
    //             Tab(
    //               child: TextButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       Navigator.pop(context);
    //                     });
    //                   },
    //                   style: const ButtonStyle(
    //                       // backgroundColor: Colors.black
    //                       ),
    //                   child: const Text(
    //                     'ENG->മലയാളം ',
    //                     style: TextStyle(color: Colors.white),
    //                   )),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Column(
    //           children: [
    //             Tab(
    //               child: TextButton(
    //                   onPressed: () {},
    //                   child: const Text(
    //                     'മലയാളം -> ENG',
    //                     style: TextStyle(color: Colors.white),
    //                   )),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    //   title: const Text('Dictionary'),
    //   centerTitle: true,
    //   actions: <Widget>[
    //     IconButton(
    //       icon: const Icon(
    //         Icons.share,
    //         color: Colors.white,
    //       ),
    //       onPressed: () {},
    //     ),
    //   ],
    // ),
    //),