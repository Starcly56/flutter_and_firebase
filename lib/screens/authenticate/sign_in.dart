import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:flutter_and_firebase/shared/constants.dart';
import 'package:flutter_and_firebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;
  const SignIn({Key? key,required this.toogleView}) : super(key: key);


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Application'),
        actions:[
          FlatButton.icon(onPressed: (){
            widget.toogleView();
          }, 
          icon: Icon(Icons.person),
           label: Text('Register'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) =>
                val!.length < 6 ? 'Enter a password of 6 plus chars' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.pink[400],
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signIn(email, password);
                    if(result==null){
                      setState(()=> {
                        error = 'Could not sign in with those credentials.',
                        loading = false
                      });
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12,),
              Text(
                error, style: TextStyle(color: Colors.red,fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
