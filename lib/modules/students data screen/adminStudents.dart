
import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';
import '../my account screen/My_account.dart';
class AdminStudentsData extends StatelessWidget{
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
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('name'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('ID'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
              keyboardType:TextInputType.number ,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('Gender'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('Account address'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
              keyboardType:TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('address'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('Tele-number'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
              keyboardType:TextInputType.number ,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
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
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
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
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.done,
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
                    onPressed: (){},
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
                    onPressed: (){},
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

    );
  }
}