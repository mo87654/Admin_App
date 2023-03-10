
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';
import '../my account screen/My_account.dart';
class AdminStudentsData extends StatefulWidget{
  @override
  State<AdminStudentsData> createState() => _AdminStudentsDataState();
}

class _AdminStudentsDataState extends State<AdminStudentsData> {
  var namecontroller = TextEditingController();
  var idcontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var tele_numcontroller = TextEditingController();
  var gradcontroller = TextEditingController();
  var mac_addcontroller = TextEditingController();
  var bus_idcontroller = TextEditingController();
  bool showpassword = true;
  var formkey = GlobalKey<FormState>();

  @override
  String? selectedItem;
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
        title: Text('Students'),
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
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          top: 10,
          bottom: 20,
        ),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              SizedBox(
                height: 10,
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
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                keyboardType:TextInputType.number ,
                controller: idcontroller,
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
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                items: <String>['Male', 'Female'].map((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                value: selectedItem,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Account address required';
                  }
                },
                keyboardType:TextInputType.emailAddress,
                controller: emailcontroller,
                decoration: InputDecoration(
                  label: Text('Account address'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                keyboardType:TextInputType.visiblePassword,
                obscureText: showpassword,
                controller: passwordcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password required';
                  }
                },
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
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                controller: addresscontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Address required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Address'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                keyboardType:TextInputType.number ,
                controller: tele_numcontroller,
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
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                controller: gradcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Grad required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('Grad'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.next,
                controller: mac_addcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'MAC-address required';
                  }
                },
                decoration: InputDecoration(
                  label: Text('MAC-address'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                textInputAction: TextInputAction.done,
                controller: bus_idcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'bus ID required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('bus ID'),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(
                    fontSize: 18
                  )
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    child: MaterialButton(
                      onPressed:() async {
                        if (formkey.currentState!.validate()) {
                          var studentAuth = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: emailcontroller.text,
                              password: passwordcontroller.text
                          );

                          CollectionReference studentRef =
                          FirebaseFirestore.instance.collection('Students');
                          studentRef.doc(idcontroller.text).set({
                            'name': namecontroller.text,
                            'gender': selectedItem,
                            'email': emailcontroller.text,
                            'tele-num': tele_numcontroller.text,
                            'grad': gradcontroller.text,
                            'MAC-address': mac_addcontroller.text,
                            'Bus id': bus_idcontroller.text,
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