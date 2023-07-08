import 'dart:convert';
import 'dart:io';
import 'package:admin_app/modules/login%20screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../shared/component/SignoutMessage.dart';
import '../../shared/component/colors.dart';
import '../AboutUs Screen/AboutUs.dart';
import '../change password screen/change_password.dart';
import '../help screen/help_screen.dart';
import '../personal info screen/personal_info.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool status = false;
  PickedFile? _imageFile;
  String? image64;
  String? _imagepath;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadimage();
  }
  final User =FirebaseAuth.instance.currentUser!;

  Future<Object> getuserinfo1() async {
    final CollectionReference users = FirebaseFirestore.instance.collection('admin');
    final String uid = User.uid;
    final result = await  users.doc(uid).get();
    return result.data()??['uid'];

  }

  Future<void> savephoto(Path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", Path);
  }
  Future<String?> loadimage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath= saveimage.getString("imagepath");
    });
   // return saveimage.getString("imagepath");
  }

   Future<String?> loadimagedrawer() async {
     SharedPreferences saveimage = await SharedPreferences.getInstance();
    return saveimage.getString("imagepath");
   }
  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');
      setState(() {
        _imagepath = savedImage.path;
        print(_imagepath);
      });
      savephoto(_imagepath!); // حفظ الصورة المحددة
      final newImage = File(_imagepath!);
      final imageBytes = newImage.readAsBytesSync();
      final image64 = base64Encode(imageBytes);
      print(image64);
    }
  }
  void deletePhoto1() async {
    setState(() {
      _imagepath = null;
    });
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.remove("imagepath");
  }
  final ImagePicker picker = ImagePicker();
  Color purple = const Color.fromRGBO(38, 107, 128, 0.9490196078431372);
  Color lpurplet = const Color.fromRGBO(0, 102, 128, 0.9490196078431372);
  Color white = const Color.fromRGBO(254, 254, 254, 1.0);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: app_color(),
          leading:  Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                      Icons.menu
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },

                );
              }
          ),
          title: Text ('My account'),
        ),
        drawer:   SafeArea(
          child: Drawer(
            child: Column(
              children: [
                ListTile(
                  leading: FutureBuilder<String?>(
                    future: loadimagedrawer(),
                    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(snapshot.data!)),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person),
                          backgroundColor: Colors.white,
                        );
                      }
                    },
                  ),
                  title: FutureBuilder(
                    future: getuserinfo1(),
                    builder: (_ , AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Text(snapshot.data['name'].toString(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,

                        ),
                      );

                    },
                  ),
                  subtitle:  FutureBuilder(
                    future: getuserinfo1(),
                    builder: (_ , AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Text(snapshot.data['email'].toString(),

                      );

                    },
                  ),
                  onTap: () {

                  },
                ),

                const Padding(
                  padding: EdgeInsets.only(right: 24,top: 24, bottom: 16),
                  child: Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.perm_contact_cal_outlined),
                  title: const Text(' Profile Details ',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),

                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => PersonalInfo()
                        )
                    );
                  },
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: ListTile(
                //         leading: const Icon(Icons.notification_important),
                //         title: const Text('Notifications',
                //           style: TextStyle(
                //               fontSize: 17
                //           ),
                //
                //         ),
                //
                //         onTap: () {
                //           Navigator.pop(context);
                //         },
                //
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 40.0),
                //       child: Switch(onChanged: (bool value) {  }, value: true, activeColor: app_color(),),
                //     ),
                //   ],
                // ),

                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Change Password',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),

                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()
                        )
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.error),
                  title: const Text('About us',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen(),));
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help!',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),

                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => HelpPage()
                        )
                    );
                  },
                ),

                ListTile(
                  leading:  IconButton(
                    onPressed: (){},
                    icon:const Icon(Icons.logout),),
                  title: const Text('Log Out',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),

                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => SignOutMessage(),
                    );
                    //
                  },
                ),
              ],
            ),
            //hello

          ),
        ),
        body:  Column(
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  height: 260 ,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomCenter,

                    children:<Widget> [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child:CustomPaint(
                          painter: HeaderCurvedContainer(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,

                            child: const Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          clipBehavior: Clip.none,
                          children:<Widget>[

                            _imagepath != null?
                                CircleAvatar(backgroundImage: FileImage(File(_imagepath!)),radius: 80,)
                                :    GestureDetector(
                              onTap: () {
                                takePhoto(ImageSource.gallery);
                              },
                              child: CircleAvatar(
                                  radius: 64,
                                  backgroundImage: _imageFile == null ?
                                  AssetImage("assets/images/User3.jpg")
                                      : FileImage(File(_imageFile!.path)) as ImageProvider),
                            ),

                            CircleAvatar(
                              backgroundColor:  const Color(0xff4d6aaa),
                              radius: 19,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (context) => bottomSheet(),
                                    );
                                  });
                                },
                                child: Icon(Icons.camera_alt_outlined, color: white),
                              ),
                            ),
                          ]

                      ),
                    ],
                  ),
                ),

              ],

            ),





            Padding(
              padding: const EdgeInsets.only(top: 25, left: 15),
              child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child:FutureBuilder(
                future: getuserinfo1(),
                builder: (_, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  nameController.text = snapshot.data['name'].toString();
                  return TextFormField(

                    controller: nameController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1.0,
                        ),
                      ),
                      labelText: 'your name',
                    ),
                    readOnly: true,
                    style: TextStyle
                      (
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),

                  );
                },
              ),

            ),


                    Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: FutureBuilder(
                        future: getuserinfo1(),
                        builder: (_, AsyncSnapshot snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          emailController.text = snapshot.data['email'].toString();
                          return TextFormField(

                            controller: emailController,
                            enabled: false,
                            decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 2.0,
                      ),
                    ),
                    labelText: 'your email',
                  ),
                  readOnly: true,
                  style: TextStyle
                    (
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),

                );
              },
            ),

          ),
                  ]

              ),
            ),



          ],


    ));








  }

  Widget bottomSheet() {
    return Container(
      color: const Color(0xf2cad4f7),
      height: 100,
      // width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton.icon(

                  icon: const Icon(Icons.camera,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: const Text("Camera",
                    style: TextStyle(
                      color: Colors.black,

                    ),
                  ),
                ),
                OutlinedButton.icon(

                  icon: const Icon(Icons.image,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: const Text("Gallery",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),

                ),
                OutlinedButton.icon(

                  icon: const Icon(Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    deletePhoto1();
                  },
                  label: const Text("delete",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),

                ),
              ],
            ),
          )
        ],
      ),
    );
  }




}
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff4d6aaa);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}