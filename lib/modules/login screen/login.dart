import 'package:admin_app/modules/home%20screen/admin_Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../forgetPassword screens/forgetPassword1.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loginkey = GlobalKey<ScaffoldMessengerState>();
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool showpassword = true;
  //String? selectedItem;
  @override
  String? selectedItem = 'User';


  FirebaseAuth instance = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: loginkey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Image(
                    image: AssetImage('assets/images/bus.jpg'),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(),
                      labelText:'E-mail',
                      prefixIcon:Icon(
                          Icons.mail
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.top,
                    textInputAction: TextInputAction.next,
                    controller: emailcontroller,
                    validator: (value)
                    {
                      if (value!.isEmpty){
                        return 'E-mail address required';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        //contentPadding: EdgeInsetsDirectional.only(top: 10,start: 10,end: 10, bottom: 10 ),
                        border: OutlineInputBorder(),
                        labelText:'Password',
                        prefixIcon: Icon(
                          Icons.lock,
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
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: showpassword,
                    textAlignVertical: TextAlignVertical.top,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password required';
                      }
                    }
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsetsDirectional.only(end: 20),
                  height: 35,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>ForgetPassword1()
                          )
                      );
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                  child: MaterialButton(
                    onPressed: ()async{
                      if (formkey.currentState!.validate()) {
                        try{
                        UserCredential credential = await instance.signInWithEmailAndPassword
                          (email: emailcontroller.text, password: passwordcontroller.text);
                        // NotificationListener(child: AdminHome());
                        

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=>AdminHome()
                            )
                        );
                        }
                        on FirebaseAuthException catch(e){
                          if(e.code == "invalid-email"){
                            loginkey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text("Sorry! your email is invalid",style: TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.grey[600],

                              ),
                            );
                          }else if (e.code == "wrong-password"){
                            loginkey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text("Sorry! wrong password",style: TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.grey[600],

                              ),
                            );
                          }

                      }
                      }



                    },
                    child:Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,

                      ),

                    ),
                    color: Color(0xff014EB8),
                    shape:RoundedRectangleBorder (
                      borderRadius: BorderRadius.circular (10.0), ),


                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
