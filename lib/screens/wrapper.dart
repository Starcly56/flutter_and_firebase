import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:flutter_and_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter_and_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<GetUser?>(context);
    if(user==null){
      return const Authenticate();
    }
    else{
      return Home();
    }
  }
}
