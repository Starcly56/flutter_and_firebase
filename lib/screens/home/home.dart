import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/quote.dart';
import 'package:flutter_and_firebase/screens/home/quote_list.dart';
import 'package:flutter_and_firebase/screens/home/settings_form.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:flutter_and_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettings(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(
          ),
        );
      });
    }
    return StreamProvider<List<Quote>>.value(
      value: DatabaseService(uid: '').flutterAndFirebase,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Quotes'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async{
                  await _auth.logout();
                }, icon: Icon(Icons.person),
                label: Text('Logout')
            ),
          FlatButton.icon(
              onPressed: ()=>showSettings(),
              icon: Icon(Icons.settings),
              label: Text('Settings')
          ),
          ],
        ),
          body: QuoteList(
        ),
      ),
    );
  }
}
