import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/quote.dart';

class QuoteTile extends StatelessWidget {
  final Quote quote;

  const QuoteTile({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue[quote.reputation],
          ),
          title: Text(quote.quote),
          subtitle: Text(quote.name+" "+quote.importance),
        ),
      ),
    );
  }
}
