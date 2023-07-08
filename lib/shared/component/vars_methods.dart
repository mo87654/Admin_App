import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List <String> busNum =[];

/*
Future deleteUserAccount(id) async {
  try {
    await for (var user in FirebaseAuth.instance.userChanges()) {
      if (user?.uid == id) {
        await user?.delete();
        print('User account deleted successfully.');
        break;
      }
    }
    print('User with UID $id not found.');
  } catch (e) {
    print('Error deleting user account: $e');
  }
  return null;
}
*/
Future<void> deleteUserAccount(String id) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.uid == id) {
      await currentUser.delete();
      print('User account deleted successfully.');
    } else {
      print('User with UID $id not found.');
    }
  } catch (e) {
    print('Error deleting user account: $e');
  }
}
deleteUserDoc({
  required collection,
  required id,
}){
  try {
    FirebaseFirestore
        .instance
        .collection(collection)
        .doc(id)
        .delete();
  }catch(e) {
    print('Error deleting document: $e');
  }
}

confirmationMessage({
  required String task,
  required collection,
  required context,
  required id,
  // required int position,
}){
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            title: Text(
              'Confirmation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  task,
                  style: TextStyle(
                      fontSize: 23
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 50,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        deleteUserAccount(id).then((value){
                          deleteUserDoc(collection: collection, id: id);
                        });
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    MaterialButton(
                      height: 50,
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
  );
}