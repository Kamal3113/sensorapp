// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sensorflow/auth.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({this.auth, this.onSignedOut, this.readings});
//   final List<String> readings;
//   final BaseAuth auth;
//   final VoidCallback onSignedOut;
//   void _signOut() async {
//     try {
//       await auth.signOut();
//       onSignedOut();
//     } catch (e) {
//       print(e);
//     }
//   }
//     @override
//   _HomePageState createState() =>
//       new _HomePageState(auth: auth, onSignedOut: onSignedOut);
// }
// class _HomePageState extends State<HomeScreen>{
//    final BaseAuth auth;
//   final VoidCallback onSignedOut;
//   void _signOut() async {
//     try {
//       await auth.signOut();
//       onSignedOut();
//     } catch (e) {
//       print(e);
//     }
//   }
//    void initState() {
//     super.initState();
//     user();
//    }
//   _HomePageState({this.auth, this.onSignedOut});
//  String userEmail;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   user() async {
//     FirebaseUser user = await _firebaseAuth.currentUser();
//     setState(() {
//       userEmail = user.email;
//       return userEmail;
//     });
//   }
//   var listMessage;
//   @override
//   Widget build(BuildContext context) {
//     return 
     
//         //  length: 2,
//           Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   onPressed: _signOut,
//                   icon: Icon(
//                     Icons.power_settings_new,
//                     color: Colors.red,
//                   ),
//                 ),
//                 flexibleSpace: Container(
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: <Color>[
//                         Color(0xFFf420587),
//                         Colors.purple[200],
                       
//                       ])),
//                 ),
               
//                 centerTitle: true,
//                 title: Text('Reading'),
               
//               ),
//               body: StreamBuilder<DocumentSnapshot>(
//                 stream: Firestore.instance
//                     .collection('Clients')
//                     .document(userEmail)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(
//                         child: CircularProgressIndicator(
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.black)));
//                   } else {
//                     listMessage = snapshot.data;
//                        var sensordata = snapshot.data;
//                    var section = sensordata['sensordata'];
//                        for(int i=0;i<=section.length;i++)
//                         {
//                          print(section);                          
//                         }  
//                     return ListView.builder(itemCount:section.length,
//                       itemBuilder:  (context, index){
//                         if(section['serial1'] > 40){
//                      return Container(
//                             height: 100,
//                             width: 200,
//                              margin: EdgeInsets.symmetric(
//                                   horizontal: 12.0, vertical: 10.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 border: Border.all(
//                                   width: 1.0,
//                                   color: Colors.grey[200],
//                                 ),
//                               ),
//                             child:   ListTile(
//                               contentPadding: EdgeInsets.only(left: 150),
//                             title: Text(section['serial1'].toString(),style:TextStyle(fontSize:40),),
//                             trailing: IconButton(icon: Icon(Icons.check_circle,color: Colors.red,), onPressed: null),
//                           )
//                           );
//                         }
//                         else{
//                             return Container(
//                             height: 100,
//                             width: 200,
//                              margin: EdgeInsets.symmetric(
//                                   horizontal: 12.0, vertical: 10.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 border: Border.all(
//                                   width: 1.0,
//                                   color: Colors.grey[200],
//                                 ),
//                               ),
//                             child:   ListTile(
//                               contentPadding: EdgeInsets.only(left: 150),
//                             title: Text(section['serial1'].toString()),
//                             trailing: IconButton(icon: Icon(Icons.check_circle,color: Colors.green,), onPressed: null),
//                           )
//                           );
//                         }
                         
//                     });



//                     //  GridView.count(
//                     //     crossAxisCount: 2,
//                     //     //  childAspectRatio: 1.0,
//                     //     //  mainAxisSpacing: 4.0,
//                     //     //  crossAxisSpacing: 4.0,
                        
//                     //     children: List.generate(section.length, (index) {
                       
//                     //       if(section['serial1'] > 10){
//                     //                return   Center(
//                     //         child: Container(
//                     //           height: 100,
//                     //           width: 200,
//                     //           margin: EdgeInsets.symmetric(
//                     //               horizontal: 12.0, vertical: 10.0),
//                     //           decoration: BoxDecoration(
//                     //             color: Colors.green,
//                     //             borderRadius: BorderRadius.circular(15.0),
//                     //             border: Border.all(
//                     //               width: 1.0,
//                     //               color: Colors.grey[200],
//                     //             ),
//                     //           ),
//                     //           child: Column(
//                     //             children: <Widget>[
//                     //               SizedBox(
//                     //                 height: 22,
//                     //               ),
//                     //               Text(
//                     //              //   snapshot.data[index]['serial1'].toString(),
//                     //              section['serial1'].toString(),
//                     //                 style: TextStyle(
//                     //                   fontSize: 17.0,
//                     //                   fontWeight: FontWeight.bold,
//                     //                 ),
//                     //               ),
//                     //               // Text(
//                     //               //   itemlist[index].price,
//                     //               //   style: TextStyle(
//                     //               //     fontSize: 15.0,
//                     //               //     fontWeight: FontWeight.bold,
//                     //               //   ),
//                     //               // )
//                     //             ],
//                     //           ),
//                     //         ),
//                     //       );
//                     //       }
//                     //       else {
//                     //          return   Center(
//                     //         child: Container(
//                     //           height: 100,
//                     //           width: 200,
//                     //           margin: EdgeInsets.symmetric(
//                     //               horizontal: 12.0, vertical: 10.0),
//                     //           decoration: BoxDecoration(
//                     //             color: Colors.red,
//                     //             borderRadius: BorderRadius.circular(15.0),
//                     //             border: Border.all(
//                     //               width: 1.0,
//                     //               color: Colors.grey[200],
//                     //             ),
//                     //           ),
//                     //           child: Column(
//                     //             children: <Widget>[
//                     //               SizedBox(
//                     //                 height: 22,
//                     //               ),
//                     //               Text(
//                     //              //   snapshot.data[index]['serial1'].toString(),
//                     //              section['serial1'].toString(),
//                     //                 style: TextStyle(
//                     //                   fontSize: 17.0,
//                     //                   fontWeight: FontWeight.bold,
//                     //                 ),
//                     //               ),
//                     //               // Text(
//                     //               //   itemlist[index].price,
//                     //               //   style: TextStyle(
//                     //               //     fontSize: 15.0,
//                     //               //     fontWeight: FontWeight.bold,
//                     //               //   ),
//                     //               // )
//                     //             ],
//                     //           ),
//                     //         ),
//                     //       );
//                     //       }
//                     //      ;
//                     //     }));
//                   }
//                 },
//               )

             
//               ,
//     );
//   }
// }

 
