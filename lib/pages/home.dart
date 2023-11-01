import 'dart:async';

//import 'dart:html';

import 'package:dictionary_project/db/dictionary.dart';
import 'package:dictionary_project/pages/history.dart';
import 'package:dictionary_project/db/searchworld.dart';
import 'package:dictionary_project/pages/malayalamsearch/malayalam.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  get selectedOption => null;

  get ctx => null;
  int _currentTabIndex = 0;
  late Future<List<MyData>> searchMeaning = Future.value([]);
  late List history = [];
  String searchWordFilter = 'Start';
  Color startcolor = Colors.blue;
  Color containcolor = Colors.grey;
  Color endcolor = Colors.grey;
  Color appbarcolor = Colors.blue;
  @override
  void initState() {
    super.initState();
    searchMeaning = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return DefaultTabController(
        length: 2,
        initialIndex: _currentTabIndex,
        child: Scaffold(
          drawer: drawerpage(),
          appBar: AppBar(
            backgroundColor: appbarcolor,
            bottom: TabBar(
              onTap: (index) {
                setState(() {
                  _currentTabIndex = index;
                  if (_currentTabIndex == 1) {
                    // Change app bar color for the second tab
                    appbarcolor =
                        Colors.black; // Change this to your desired color
                  } else {
                    // Change app bar color for the first tab or other tabs if needed
                    appbarcolor = Colors
                        .blue; // Set to the default color or any other color
                  }
                });
              },
              isScrollable: false,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.greenAccent),
              tabs: [
                Tab(text: 'ENGLISH->മലയാളം '),
                Tab(text: 'മലയാളം ->ENGLISH'),
              ],
            ),
            title: const Text('Dictionary'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: TabBarView(children: [
            Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // search world................................................
                      FutureBuilder<List<MyData>>(
                        future: searchMeaning,
                        builder: (BuildContext ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Center(child: Text('Search a word ')),
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
                                      title: Text(item.malayalam_definition),
                                      subtitle: Text(item.english_word),
                                      trailing: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.cyanAccent,
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10),
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
                                  },
                                ),
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
                      color: Colors.blue,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => popup(
                                              history: history,
                                            )));
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
                                      decoration: const InputDecoration(
                                          labelText: 'Search'),
                                      controller: searchController,
                                      onChanged: (text) {})),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: IconButton(
                                onPressed: () async {
                                  var searchEng = await searchWord(
                                      searchController.text, searchWordFilter);

                                  setState(() {
                                    searchMeaning = Future.value(searchEng);

                                    if (searchController.text.toString() !=
                                        "") {
                                      history.add(
                                          searchController.text.toString());
                                    }
                                  });
                                },
                                icon: const Icon(Icons.search)),
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

                                    startcolor = Colors.blue;
                                    containcolor = Colors.grey;
                                    endcolor = Colors.grey;
                                  });
                                },
                                child: Text(
                                  'Start With',
                                  style: TextStyle(color: startcolor),
                                ))
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
                                    containcolor = Colors.blue;
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
            malayalamsearch()
          ]),
        ));
  }
}


// Expanded(
                //   child: Column(
                //     children: [
                //       Tab(
                //         child: TextButton(
                //             onPressed: () {},
                //             style: const ButtonStyle(
                //                 // backgroundColor: Colors.black
                //                 ),
                //             child: const Text(
                //               'ENG->മലയാളം ',
                //               style: TextStyle(color: Colors.black),
                //             )),
                //       ),
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Column(
                //     children: [
                //       Tab(
                //         child: TextButton(
                //             onPressed: () {
                //               setState(() {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => malayalamsearch()));
                //               });
                //             },
                //             child: const Text(
                //               'മലയാളം -> ENG',
                //               style: TextStyle(color: Colors.black),
                //             )),
                //       ),
                //     ],
                //   ),
                // ),