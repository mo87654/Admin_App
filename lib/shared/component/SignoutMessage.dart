import 'package:admin_app/modules/login%20screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class SignOutMessage extends StatelessWidget {
  // final VoidCallback onSignOut;
  //
  // SignOutMessage({required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async{
            await auth.signOut();
           Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(builder: (context) => Login(),), (route) => false);

    },
          child: Text('Sign Out'),
        ),
      ],
    );
  }
}
//hello