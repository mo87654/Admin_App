
import 'package:admin_app/modules/home%20screen/search_delegate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../shared/component/colors.dart';
import '../../shared/component/vars_methods.dart';

import '../_buses data screen/adminBuses.dart';
import '../_drivers data screen/adminDrivers.dart';
import '../_students data screen/adminStudents.dart';
import '../login screen/login.dart';
import '../my account screen/My_account.dart';

class AdminHome extends StatefulWidget {

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  FirebaseAuth instance = FirebaseAuth.instance;
  List names=[];
  List busIDs = [];
  List busDriver = [];
  Future getNames(String collection)async{
    names.clear();
    var dataref = FirebaseFirestore.instance.collection(collection);
    var response = await dataref.get();
    response.docs.forEach((element) {
      setState(() {
        names.add(element.data()['name']);
      });
    });
    return null;
  }
  getBusId()async{
    busIDs.clear();
    busDriver.clear();
    var dataRef = FirebaseFirestore.instance.collection('Buses');
    var response = await dataRef.get();
    response.docs.forEach((element) {
      setState(() {
        busIDs.add(element.id);
        busDriver.add(element.data()['Driver_name']);
      });
    });
    print(busIDs);
    print(busDriver);
  }


  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: app_color(),
        leading:  Text(' '),
        title: Text ('Home'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>MyAccount()
                )
            );
          },
              icon: Icon(
                Icons.account_circle,
                size: 40,
              )
          ),
          Text('    ')
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 130,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20 , left: 40 , right: 40),
              //color: Colors.indigo,
              //padding: EdgeInsets.fromLTRB(0, 20, 140, 20),
              decoration: BoxDecoration(
                  color: containerColor() ,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(10) ,topLeft:Radius.circular(10) )

              ),

              //margin: EdgeInsets.all(50),
              // margin: EdgeInsets.all(20),
              child: Text (

                  textAlign: TextAlign.center ,
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle:FontStyle.normal ,
                      color: Colors.white
                  ),

                  'Students'
              ),

            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      // width: 159,
                      decoration: BoxDecoration(
                          color: buttonsColor(),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10) )
                      ),

                      //alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 2, left: 40,right: 1 ),

                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

                      //color: Colors.indigo,
                      child:  MaterialButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_box,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "ADD",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                )
                            ),
                          ],
                        ),
                        onPressed: () {
                          getBusNum();
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => AdminStudentsData()
                              )
                          );
                        },
                      )
                  ),
                ),

                Expanded(
                  child: Container(
                      // width: 159,
                      decoration: BoxDecoration(
                          color: buttonsColor(),
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(10) )
                      ),
                      //alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 2,  right: 40,left: 1),
                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.indigo,
                      child:  MaterialButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mode,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("MODIFY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                        onPressed: () {
                          getNames('Students').then((value){
                            showSearch(
                                context: context,
                                delegate: Search(
                                    mainData: names,
                                    pageNum: 0
                                )
                            );
                            getBusNum();
                          });
                        },
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 130,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20 , left: 40 , right: 40),
              //color: Colors.indigo,
              //padding: EdgeInsets.fromLTRB(0, 20, 140, 20),
              decoration: BoxDecoration(
                  color: containerColor(),
                  borderRadius: BorderRadius.only(topRight:Radius.circular(10) ,topLeft:Radius.circular(10) )
              ),
              //margin: EdgeInsets.all(50),
              // margin: EdgeInsets.all(20),
              child: Text (
                  textAlign: TextAlign.center ,
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle:FontStyle.normal ,
                      color: Colors.white
                  ),
                  'Drivers'
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      // width: 159,
                      decoration: BoxDecoration(
                          color: buttonsColor(),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10) )
                      ),
                      //alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 2, left: 40,right: 1 ),
                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.indigo,
                      child:  MaterialButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_box
                              ,color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "ADD",style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            )
                            ),
                          ],
                        ),
                        onPressed: () {
                          getBusNum();
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDriversData()
                              )
                          );
                        },
                      )
                  ),
                ),

                Expanded(
                  child: Container(
                      // width: 159,
                      decoration: BoxDecoration(
                          color: buttonsColor(),
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(10) )
                      ),
                      //alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 2,  right: 40,left: 1),
                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.indigo,
                      child:  MaterialButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mode,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("MODIFY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onPressed: () {
                          getNames('Drivers').then((value){
                            showSearch(
                                context: context,
                                delegate: Search(
                                    mainData: names,
                                    pageNum: 1
                                )
                            );
                            getBusNum();
                          });
                        },
                      )
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 130,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20 , left: 40 , right: 40),
              //color: Colors.indigo,
              //padding: EdgeInsets.fromLTRB(0, 20, 140, 20),
              decoration: BoxDecoration(
                  color: containerColor(),
                  borderRadius: BorderRadius.only(topRight:Radius.circular(10) ,topLeft:Radius.circular(10) )
              ),
              //margin: EdgeInsets.all(50),
              // margin: EdgeInsets.all(20),
              child: Text (
                  textAlign: TextAlign.center ,
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle:FontStyle.normal ,
                      color: Colors.white
                  ),
                  'Buses'
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      // width: 159,
                      decoration: BoxDecoration(
                          color: buttonsColor(),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10) )
                      ),
                      //alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 2, left: 40,right: 1 ),
                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.indigo,
                      child:  MaterialButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_box,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "ADD",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                            )
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => AdminBusesData()
                              )
                          );
                        },
                      )
                  ),
                ),

                Expanded(
                  child: Container(
                      // width: 159,
                      decoration: BoxDecoration(
                          color: buttonsColor(),
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(10) )
                      ),
                      //alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 2,  right: 40,left: 1),
                      //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.indigo,
                      child:  MaterialButton(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mode,
                              color: Colors.white,
                              size: 28,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("MODIFY",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        onPressed: () {
                          getBusId();
                          showSearch(
                              context: context,
                              delegate: Search(
                              mainData: busIDs,
                              subData: busDriver,
                              pageNum: 2
                          )
                          );
                        },
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  getBusNum() async {
    busNum.clear();
    await FirebaseFirestore.
    instance.
    collection('Buses').
    get().then((value) {
      value.docs.forEach((element) {
        busNum.add(element.data()['Bus_number']);
      });
    });
    print(busNum);
  }
}
