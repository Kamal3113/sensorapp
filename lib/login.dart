import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sensorflow/auth.dart';


class LoginPage1 extends StatefulWidget {
  LoginPage1({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage1> {
  String _email;
  String _password;
  final formkey = new GlobalKey<FormState>();
  FormType _formtype = FormType.login;

  bool validateandsave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
 @override
  void initState() {
    super.initState();
   
    }
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("go to login"),
  );

 
  void validateandsubmit() async {
     
    if (validateandsave()) {
      try {
        if (_formtype == FormType.login) {
          String userId =
          
              await widget.auth.signInWithEmailAndPassword( _email  +'@sensorflow.com', _password);
          // FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
          print('sign in : $userId');
        } else {
          String userId = await widget.auth.createUserWithEmailAndPassword(_email  +'@sensorflow.com', _password);
    
          // FirebaseUser user= (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
          print('Registered user $userId');
        }
  
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void movetoRegister() {
    formkey.currentState.reset();
    setState(() {
      _formtype = FormType.register;
    });
  }

  void movetoLogin() {
    formkey.currentState.reset();
    setState(() {
      _formtype = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                //  #8c4fdb
                Colors.purple,
               Colors.purple
              ]),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 32),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 60.0,
      ),
      new SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: new Form(
            key: formkey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildsubmitButtons(),
            )),
      )
    ])));
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
            labelText: 'email',
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0))),
        // validator: (value) => value.isEmpty ? 'email cant be empty' : null,
        // onSaved: (value) => _email = value,
        validator: (value){
                     if (value.length == 0)
                       return "Please enter email";                     
                     else if ( !value.contains(''))
                       return "Please enter valid email";                     
                     else
                       return null; 
                   },
                   onSaved: (value)=>  _email  =value,
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        obscureText: true,
        decoration: new InputDecoration(
            labelText: 'password',
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0))),
                
        // validator: (value) => value.isEmpty ? 'password cant be empty' : null,
        // ,
        
        validator: (value){
          if(value.length==0){
            return "Please enter password";
          }else if(value.length <=5)
             return "Your password should be more then 6 char long";                     
                     else
                       return null; 
          
        },
        onSaved: (value) => _password = value
      ),

      SizedBox(
        height: 10,
      )
    ];
  }

  List<Widget> buildsubmitButtons() {
    if (_formtype == FormType.login) {
      return [
        new RaisedButton(
            color: Colors.purple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black)),
            child: new Text(
              'login',
              style: TextStyle(color: Colors.white),
            ),
            onPressed:(){
              validateandsubmit();
            
            
                
              
          
            }
            
            ),
        new FlatButton(
            onPressed: movetoRegister, child: new Text('Create an Account')),
      ];
    } else {
      return [
        new RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)),
          child: new Text('Register'),
          onPressed:(){
            validateandsubmit();
          
          }
           
        ),
        new FlatButton(
            onPressed: movetoLogin, child: new Text('Have an Account ? Login'))
      ];
    }
  }

}
