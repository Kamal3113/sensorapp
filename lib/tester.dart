import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensorflow/auth.dart';

class HoeScreen extends StatefulWidget {
  
    @override
  _Hoestate createState() =>
      new _Hoestate();
}
class _Hoestate extends State<HoeScreen>{
 
   void initState() {
    super.initState();
    user();
   }

  // _HomePageState({this.auth, this.onSignedOut});
 String userEmail;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  user() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    setState(() {
      userEmail = user.email;
      return userEmail;
    });
  }
//   Future<List<DocumentSnapshot>> getData() async {
//     var firestore = Firestore.instance;
//     QuerySnapshot qn = await firestore
//         .collection("Clients").document(userEmail).
//        // .where("clientid", isEqualTo: userEmail)
//         .getDocuments();
//     return qn.documents;
// }
  var listMessage;
  @override
  Widget build(BuildContext context) {
    return 
     
        //  length: 2,
          Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
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
               
              ),
              body: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('Clients')
                    .document(userEmail)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black)));
                  } else {
                    listMessage = snapshot.data;
                       var sensordata = snapshot.data;
                   var section = sensordata['sensormapping'];
                   var  sdata= sensordata['sensordata'];
                       for(int i=0;i<=section.length;i++)
                        {
                         print(section);                          
                        }  
                    return ListView.builder(itemCount:section.values.length,
                      itemBuilder:  (context, index){
                      //if(section[section.keys.elementAt(index)]['min']['max'] >)
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
                                  color: Colors.grey[200],
                                ),
                              ),
                            child:
                            Column(
                              children: [
                             ListTile(
                              contentPadding: EdgeInsets.only(top: 20),
                            title:
                           Text(section[section.keys.elementAt(index)]['title'] + "        " + sdata[sdata.keys.elementAt(index)].toString() +"\u00B0 ",
                           style:
                           TextStyle(
                            // GoogleFonts.oswald(textStyle: display1),
                             fontSize:40,
                           fontStyle: FontStyle.normal,
                        //  fontFamily: 'RobotoMono'
                          ),),
                        
                         trailing:  new InkWell(
                             child: new Container(
                            padding: const EdgeInsets.all(21.0),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: new Text('', style: new TextStyle(color: Colors.white, fontSize: 50.0)),
                              
                              ),
                            ),
                          ),
                                      Padding(padding: EdgeInsets.only(right: 20)),
                      
                                                        ],
                            )  
                          );
                        
                     
                         
                    });



                   
                  }
                },
              )

             
              ,
    );
  }
}

 
