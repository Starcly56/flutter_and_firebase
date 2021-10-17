import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:flutter_and_firebase/services/database.dart';
import 'package:flutter_and_firebase/shared/constants.dart';
import 'package:flutter_and_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> importances = ['0', '1', '2', '3', '4', '5'];

  //form values
  String? _currentName;
  String? _currentQuote;
  String? _currentImportance;
  int? _currentReputation;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GetUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your quote.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.quote,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a quote' : null,
                    onChanged: (val) => setState(() => _currentQuote = val),
                  ),
                  DropdownButtonFormField(
                    value: _currentImportance ?? userData.importance,
                    decoration: textInputDecoration,
                    items: importances.map((importance) {
                      return DropdownMenuItem(
                        value: importance,
                        child: Text('$importance'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentImportance = val.toString()),
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    activeColor:
                        Colors.brown[_currentReputation ?? userData.reputation],
                    inactiveColor:
                        Colors.brown[_currentReputation ?? userData.reputation],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (double value) {
                      setState(() {
                        _currentReputation = value.round();
                      });
                    },
                    value:
                        (_currentReputation ?? userData.reputation).toDouble(),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentQuote ?? userData.quote,
                              _currentImportance ?? userData.importance,
                              _currentName ?? userData.name,
                              _currentReputation ?? userData.reputation);
                        }
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
