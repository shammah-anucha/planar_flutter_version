import 'package:flutter/material.dart';
import '../providers/event.dart';
import 'package:provider/provider.dart';

class HomeItem extends StatefulWidget {
  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            Card(
                child: Image.network(
              event.imageUrl,
              height: 150,
            )),
            Text(
              event.title,
              style: TextStyle(color: Theme.of(context).accentColor),
            )
          ],
        ),
      ),
    ]);
  }
}
