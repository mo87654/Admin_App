
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';
import '../../shared/component/buttons.dart';
import '../my account screen/My_account.dart';
class AdminStudentsData extends StatefulWidget{
  AdminStudentsData({
     this.name,
});
  String? name;
  @override
  State<AdminStudentsData> createState() => _AdminStudentsDataState(name);
}
class _AdminStudentsDataState extends State<AdminStudentsData> {

  _AdminStudentsDataState(this.name);
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
     var collId = FirebaseFirestore.instance.collection('Students');
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
    selectedItem= docData[0]['gender'];
    emailcontroller.text= docData[0]['email'];
    addresscontroller.text= docData[0]['address'];
    tele_numcontroller.text= docData[0]['tele-num'];
    gradcontroller.text= docData[0]['grad'];
    mac_addcontroller.text= docData[0]['MAC-address'];
    bus_idcontroller.text= docData[0]['Bus id'];
    print(selectedItem);
  }


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

  String? selectedItem;
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
                validator: name==null? (value) {
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
                height: 10,
              ),
              Container(
                child: name==null? null:
                TextButton(
                    onPressed: ()async{
                      await FirebaseAuth
                          .instance
                          .sendPasswordResetEmail(email: emailcontroller.text);
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 19,
                      ),
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
                  appButton(
                    width: 150,
                    text: "Submit",
                    function:() async {
                      if (formkey.currentState!.validate()) {
                        if(name==null){
                          var studentAuth = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                          );

                          CollectionReference studentRef =
                          FirebaseFirestore.instance.collection('Students');
                          studentRef.doc(studentAuth.user?.uid).set({
                            'name'       : namecontroller.text,
                            'id'         : idcontroller.text,
                            'gender'     : selectedItem,
                            'email'      : emailcontroller.text,
                            'address'    : addresscontroller.text,
                            'tele-num'   : tele_numcontroller.text,
                            'grad'       : gradcontroller.text,
                            'MAC-address': mac_addcontroller.text,
                            'Bus id'     : bus_idcontroller.text,
                            'category'   : 'user',
                            'state'      : 0
                          });
                          Navigator.pop(context);
                        }else
                        {var studentRef = FirebaseFirestore.instance.collection('Students');
                          studentRef.doc(id).update({
                            'name'       : namecontroller.text,
                            'id'         : idcontroller.text,
                            'gender'     : selectedItem,
                            'email'      : emailcontroller.text,
                            'address'    : addresscontroller.text,
                            'tele-num'   : tele_numcontroller.text,
                            'grad'       : gradcontroller.text,
                            'MAC-address': mac_addcontroller.text,
                            'Bus id'     : bus_idcontroller.text,
                          });
                          Navigator.pop(context);
                          print(mac_addcontroller.text);
                        }
                      }
                      },
                      ),
                  // Container(
                  //   height: 40,
                  //   width: 120,
                  //
                  //   child: MaterialButton(
                  //     onPressed:() async {
                  //       if (formkey.currentState!.validate()) {
                  //         if(name==null){
                  //           var studentAuth = await FirebaseAuth.instance
                  //               .createUserWithEmailAndPassword(
                  //               email: emailcontroller.text,
                  //               password: passwordcontroller.text,
                  //           );
                  //
                  //           CollectionReference studentRef =
                  //           FirebaseFirestore.instance.collection('Students');
                  //           studentRef.doc(studentAuth.user?.uid).set({
                  //             'name'       : namecontroller.text,
                  //             'id'         : idcontroller.text,
                  //             'gender'     : selectedItem,
                  //             'email'      : emailcontroller.text,
                  //             'address'    : addresscontroller.text,
                  //             'tele-num'   : tele_numcontroller.text,
                  //             'grad'       : gradcontroller.text,
                  //             'MAC-address': mac_addcontroller.text,
                  //             'Bus id'     : bus_idcontroller.text,
                  //           });
                  //           Navigator.pop(context);
                  //         }else{
                  //           var studentRef = FirebaseFirestore.instance.collection('Students');
                  //           studentRef.doc(id).update({
                  //             'name'       : namecontroller.text,
                  //             'id'         : idcontroller.text,
                  //             'gender'     : selectedItem,
                  //             'email'      : emailcontroller.text,
                  //             'address'    : addresscontroller.text,
                  //             'tele-num'   : tele_numcontroller.text,
                  //             'grad'       : gradcontroller.text,
                  //             'MAC-address': mac_addcontroller.text,
                  //             'Bus id'     : bus_idcontroller.text,
                  //           });
                  //           Navigator.pop(context);
                  //           print(mac_addcontroller.text);
                  //         }
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
                    width: 120,
                  ),
                  appButton(

                      width: 150,
                      text: "Cancel",
                      buttonColor: Color(0xff828D9A),
                      function: (){
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}