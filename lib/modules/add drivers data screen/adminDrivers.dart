import 'package:admin_app/shared/component/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';
import '../../shared/component/components.dart';
import '../my account screen/My_account.dart';
class AdminDriversData extends StatefulWidget{
  AdminDriversData({
    this.name,
  });
  String? name;
  @override
  State<AdminDriversData> createState() => _AdminDriversDataState(name);
}
class _AdminDriversDataState extends State<AdminDriversData> {
  _AdminDriversDataState(this.name);
  String? name;

  @override
  void initState(){
    super.initState();
    if (name!=null) {
      getID();
    }
  }

  var id;
  List docData= [];

  getID() async {
    docData.clear();
    var collId = FirebaseFirestore.instance.collection('Drivers');
    await collId.where('name', isEqualTo: name).get()
        .then((value) {
      value.docs.forEach((element) {
        docData.add(element.data());
        id = element.id;
      });
      assignData();
    });
  }

  assignData(){
    namecontroller.text = docData[0]['name'];
    idcontroller.text = docData[0]['id'];
    emailcontroller.text= docData[0]['email'];
    tele_numcontroller.text= docData[0]['tele-num'];
    busNumSelectedItem= docData[0]['Bus_number'];
    setState(() {});
  }

  var namecontroller = TextEditingController();
  var idcontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var tele_numcontroller = TextEditingController();
  String? busNumSelectedItem;
  bool showpassword = true;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_color(),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back_rounded
          ),
        ),
        title: Text('Drivers'),
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
                height: 20,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                controller: namecontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Name'),
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
                controller: idcontroller,
                keyboardType:TextInputType.number ,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ID required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('ID'),
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
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Account address required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Account address'),
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
                keyboardType:TextInputType.visiblePassword,
                obscureText: showpassword,
                controller: passwordcontroller,
                validator: name==null?(value) {
                  if (value!.isEmpty) {
                    return 'Password required';
                  }
                }:null,
                decoration: InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        icon: showpassword? Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ) :
                        Icon(
                          Icons.visibility,
                        )
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
                controller: tele_numcontroller,
                keyboardType:TextInputType.number ,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tele-number required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Tele-number'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(
                height: 25,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Bus Number',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                items: busNum.map((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    busNumSelectedItem = value;
                  });
                },
                value: busNumSelectedItem,
                validator:(value) {
                  if (value!.isEmpty) {
                    return 'Bus Number required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appButton(
                    width: 150,
                    text: "Submit",
                    function:()async{
                      if (formkey.currentState!.validate()) {
                        if(name==null){
                          var driverAuth = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: emailcontroller.text,
                              password: passwordcontroller.text
                          );

                          CollectionReference driverRef =
                          FirebaseFirestore.instance.collection('Drivers');
                          driverRef.doc(driverAuth.user?.uid).set({
                            'name': namecontroller.text,
                            'id'  : idcontroller.text,
                            'email': emailcontroller.text,
                            'tele-num': tele_numcontroller.text,
                            'Bus_number': busNumSelectedItem,
                            'category': 'driver'
                          });

                        }else{
                          var studentRef = FirebaseFirestore.instance.collection('Drivers');
                          studentRef.doc(id).update({
                            'name': namecontroller.text,
                            'id'  : idcontroller.text,
                            'email': emailcontroller.text,
                            'tele-num': tele_numcontroller.text,
                            'Bus_number': busNumSelectedItem,
                          });
                        }
                        Navigator.pop(context);
                      }
                      },
                  ),
                  // Container(
                  //   height: 40,
                  //   width: 120,
                  //   child: MaterialButton(
                  //     onPressed: ()async{
                  //       if (formkey.currentState!.validate()) {
                  //         if(name==null){
                  //           var driverAuth = await FirebaseAuth.instance
                  //               .createUserWithEmailAndPassword(
                  //               email: emailcontroller.text,
                  //               password: passwordcontroller.text
                  //           );
                  //
                  //           CollectionReference driverRef =
                  //           FirebaseFirestore.instance.collection('Drivers');
                  //           driverRef.doc(driverAuth.user?.uid).set({
                  //             'name': namecontroller.text,
                  //             'id'  : idcontroller.text,
                  //             'email': emailcontroller.text,
                  //             'tele-num': tele_numcontroller.text,
                  //             'Bus id': bus_idcontroller.text,
                  //           });
                  //
                  //         }else{
                  //           var studentRef = FirebaseFirestore.instance.collection('Drivers');
                  //           studentRef.doc(id).update({
                  //             'name': namecontroller.text,
                  //             'id'  : idcontroller.text,
                  //             'email': emailcontroller.text,
                  //             'tele-num': tele_numcontroller.text,
                  //             'Bus id': bus_idcontroller.text,
                  //           });
                  //         }
                  //         Navigator.pop(context);
                  //       }
                  //     },
                  //     child:Text(
                  //       'Submit',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 17,
                  //
                  //       ),
                  //
                  //     ),
                  //     color: Color(0xff014EB8),
                  //     shape:RoundedRectangleBorder (
                  //       borderRadius: BorderRadius.circular (10.0), ),
                  //
                  //
                  //   ),
                  // ),
                  SizedBox(
                    width: 50,
                  ),
                  appButton(
                      width: 150,
                      text: "Cancel",
                      buttonColor: Color(0xff828D9A),
                      function: (){
                        Navigator.pop(context);
                      })
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}