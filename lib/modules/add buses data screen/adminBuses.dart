import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';
import '../my account screen/My_account.dart';
class AdminBusesData extends StatefulWidget{
  @override
  State<AdminBusesData> createState() => _AdminBusesDataState();
}

class _AdminBusesDataState extends State<AdminBusesData> {
  var busID_controller = TextEditingController();
  var driverName_controller = TextEditingController();
  var driverID_controller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color(),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
                Icons.arrow_back_rounded
            ),
        ),
        title: Text('Buses'),
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
      body:
      Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 10,
          bottom: 20,
        ),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: busID_controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bus ID required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Bus ID'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                controller: driverName_controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Driver name required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Driver name'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.done,
                controller: driverID_controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Driver ID required';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Driver ID'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18
                  )
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    child: MaterialButton(
                      onPressed: () {
                        if (formkey.currentState!.validate())
                        {
                          CollectionReference busRef =
                          FirebaseFirestore.instance.collection('Buses');
                          busRef.doc(busID_controller.text).set({
                            'Driver_name': driverName_controller.text,
                            'Driver_ID': driverID_controller.text,
                          });
                          Navigator.pop(context);
                        }
                      },
                      child:Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,

                        ),

                      ),
                      color: Color(0xff014EB8),
                      shape:RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular (10.0), ),


                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child:Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,

                        ),

                      ),
                      color: Color(0xff828D9A),
                      shape:RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular (10.0), ),


                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),


    );
  }
}