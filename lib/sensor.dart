import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sensorflow/auth.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.auth, this.onSignedOut, this.readings});
  final List<String> readings;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  _HomePageState createState() =>
      new _HomePageState(auth: auth, onSignedOut: onSignedOut);
}

class _HomePageState extends State<HomeScreen> {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    user();
  }

  _HomePageState({this.auth, this.onSignedOut});
  String userEmail;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  user() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    setState(() {
      userEmail = user.email;
      return userEmail;
    });
  }

  var listMessage;
  @override
  Widget build(BuildContext context) {
    return 
    StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('Clients')
            .document(userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black)));
          } else {
            try {
                 listMessage = snapshot.data;
            var sensordata = snapshot.data;
            var section = sensordata['sensormapping'];
            var sdata = sensordata['sensordata'];
            for (int i = 0; i <= section.length; i++) {
              print(section);
            }
            return
             Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _signOut,
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFFf420587),
                Colors.purple[200],
              ])),
        ),
        centerTitle: true,
        title: Text('Reading'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15,right: 16),
         child: Text(
          DateFormat('kk:mm')
              .format(DateTime.now(),),
            style: TextStyle(color: Colors.white, fontSize: 19.0, fontStyle: FontStyle.normal),
            ),
         margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
      )
        ],
      ),
      body: 
             ListView.builder(
                itemCount: section.values.length,
                itemBuilder: (context, index) {
                  if (section[section.keys.elementAt(index)]['min'] >=
                          sdata[sdata.keys.elementAt(index)] ||
                      section[section.keys.elementAt(index)]['max'] <=
                          sdata[sdata.keys.elementAt(index)]) {
                    return
                     Container(
                        height: 100,
                        width: 200,
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            width: 7.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                 EdgeInsets.only(top: 10, left: 20),
                              title: Text(
                                section[section.keys.elementAt(index)]
                                        ['title'] +
                                    "       " +
                                    sdata[sdata.keys.elementAt(index)]
                                        .toString() +
                                    "\u00B0 ",
                                style: TextStyle(
                                  // GoogleFonts.oswald(textStyle: display1),
                                  fontSize: 32,
                                  fontStyle: FontStyle.normal,
                                  //  fontFamily: 'RobotoMono'
                                ),
                              ),
                              trailing: new InkWell(
                                child: new Container(
                                  padding: EdgeInsets.only(
                                    right: 100,
                                  ),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: new Text('',
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 35.0)),
                                ),
                              ),
                            ),
     
                          ],
                        ),
                        
                        );
                  } else {
                    return Container(
                        height: 100,
                        width: 200,
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            width: 7.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 20),
                              title: Text(
                                section[section.keys.elementAt(index)]
                                        ['title'] +
                                    "        " +
                                    sdata[sdata.keys.elementAt(index)]
                                        .toString() +
                                    "\u00B0 ",
                                style: TextStyle(
                                  // GoogleFonts.oswald(textStyle: display1),
                                  fontSize: 32,
                                  fontStyle: FontStyle.normal,
                                  //  fontFamily: 'RobotoMono'
                                ),
                              ),
                              trailing: new InkWell(
                                child: new Container(
                                  padding: EdgeInsets.only(
                                    right: 100,
                                  ),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: new Text('',
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 35.0)),
                                ),
                              ),
                            ),
                          ],
                        ));
                  }
                })
             );
            } catch (e) {
               return Scaffold(
                appBar: AppBar(
                  title: Text('Information Page'),
                  actions: [
                    IconButton(icon: Icon(
            Icons.power_settings_new,
            color: Colors.white,
          ), onPressed: _signOut)
                  ],
                  backgroundColor: Colors.purple ,
                ),
                body: Center(
                  
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    width:  400,
                     child: 
       Text(

              "Sorry! there is no data . Kindly, reopen your app or contact with your admin.",style: TextStyle(fontSize: 18),
       
       ),
                  )
      
     ),
              );
            }
         
          }
        });
      
  }
}
  
