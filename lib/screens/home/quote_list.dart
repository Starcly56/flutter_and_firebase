import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/quote.dart';
import 'package:flutter_and_firebase/screens/home/quote_tile.dart';
import 'package:provider/provider.dart';

class QuoteList extends StatefulWidget {
  const QuoteList({Key? key}) : super(key: key);

  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  @override
  Widget build(BuildContext context) {

    final quotes = Provider.of<List<Quote>>(context);
    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: ( context, index) {
        print(quotes[index].quote);
        return QuoteTile(quote:quotes[index]);
      },
    );
  }
}
