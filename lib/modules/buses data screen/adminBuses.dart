import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';
import '../my account screen/My_account.dart';
class AdminBusesData extends StatelessWidget{
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
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text('bus ID'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.next,
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
            TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                label: Text('Driver ID'),
                border: OutlineInputBorder(),
                floatingLabelStyle: TextStyle(
                  fontSize: 18
                )
              ),
              keyboardType: TextInputType.number,
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