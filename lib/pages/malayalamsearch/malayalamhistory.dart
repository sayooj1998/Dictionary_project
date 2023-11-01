import 'package:flutter/material.dart';

class popupMalayalam extends StatelessWidget {
  List historyMalayalam;
  popupMalayalam({required this.historyMalayalam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Malayalam History'),
      ),
      body: Card(
        child: Container(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                if (historyMalayalam != null) {
                  return ListTile(
                    title: Text(historyMalayalam[index]),
                  );
                } else {
                  return Text('No Data');
                }
              },
              separatorBuilder: (context, index) => const Divider(
                    height: 15,
                  ),
              itemCount: historyMalayalam.length),
        ),
      ),
    );
  }
}
