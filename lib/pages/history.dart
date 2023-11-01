import 'package:flutter/material.dart';

class popup extends StatelessWidget {
  List history;
  popup({required this.history});

  @override
  Widget build(BuildContext context) {
    print(history);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Card(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (history != null) {
                return ListTile(
                  title: Text(history[index]),
                );
              } else {
                return Text('No Data');
              }
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 15,
                ),
            itemCount: history.length),
      ),
    );
  }
}
