import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class AuthProvider with ChangeNotifier{
  User? _user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthProvider(){

   _auth.authStateChanges().listen((User? user) {
     if (user == null) {
       print("${errorMessage}");
     }else{
       _user = user;
     }
     notifyListeners();
   });

  }


  User? get user => _user;
  String errorMessage = "";


  Future signIn(String email,String password)async{
    try {
      UserCredential userCredential =await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,);
      notifyListeners();
      return userCredential;


    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage='invalid-email';
      }
      else if (e.code == 'wrong-password') {
        errorMessage='wrong-password';
      }

    }catch (e) {

      return(e.toString());
    }
  }

  signOut()async{
    await _auth.signOut();
    notifyListeners();

  }
}