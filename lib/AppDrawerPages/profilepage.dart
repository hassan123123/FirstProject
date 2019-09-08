import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:restaurent_app/Pages/AppDrawer.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 File _image;
  createAlertDailog(BuildContext context){
    TextEditingController customController= new TextEditingController();
    return showDialog(
      context: context,
    barrierDismissible: false,
    builder: (context){
      return AlertDialog(
        
        title: Text("Username",style: TextStyle(color: Colors.orange),),
        content: TextField(

         controller: customController, 
        ),
      
       backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
            child: Text("Submit",style: TextStyle(color: Colors.orange),),
          ),
        ],
      );
    });
  }
   createAlertDailog1(BuildContext context){
    TextEditingController customController= new TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
      return AlertDialog(
        title: Text("Birthday",style: TextStyle(color: Colors.orange),),
        content: TextField(
         controller: customController, 
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
            child: Text("Submit",style: TextStyle(color: Colors.orange)),
          ),
        ],
      );
    });
  }
    createAlertDailog2(BuildContext context){
    TextEditingController customController= new TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
      return AlertDialog(
        title: Text("Location",style: TextStyle(color: Colors.orange)),
        content: TextField(
         controller: customController, 
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
            child: Text("Submit",style: TextStyle(color: Colors.orange)),
          ),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }

    /*Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
       StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }*/
    Future<bool> addDailog(BuildContext context){
      //TextEditingController textcontroller = new TextEditingController();
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(  
              title: Text("Change Profile Details"
              ,style: TextStyle(color: Colors.orange),
              ),
              content:Container(
                height: 250.0,
                width: 100.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                      new Form(
                        child: Theme(
                          data: ThemeData(
                              inputDecorationTheme:
                                             new InputDecorationTheme(
                                           labelStyle: new TextStyle(
                                               color: Color(0xFFFeb324),
                                               fontSize: 17.0),
                                         ),
                          ), 
                          child:  Column(
                            children: <Widget>[
                              TextFormField(
                         decoration: new InputDecoration(
                               labelText: "Username:",
                        ),
                        keyboardType: TextInputType.phone,
                     //  onChanged: (val) => phone = val,
                     ),
                     SizedBox(height: 20.0,),
                          TextFormField(
                         decoration: new InputDecoration(
                               labelText: "Birthday:",
                        ),
                        keyboardType: TextInputType.phone,
                     //  onChanged: (val) => phone = val,
                     ),
                     SizedBox(height: 20.0,),
                          TextFormField(
                         decoration: new InputDecoration(
                               labelText: "Location:",
                        ),
                        keyboardType: TextInputType.phone,
                     //  onChanged: (val) => phone = val,
                     ),
                            ],
                          ),
                                                                    
                        ),
                      )
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit",style: TextStyle(color: Colors.orange)),
                ),
              ],
            );
          
        }
      );
    }

    return Scaffold(
      drawer: AppDrawer(),
        appBar: AppBar(
          elevation: 0.0, 
          backgroundColor: Colors.transparent,
          
        ),
        body: Builder(
        builder: (context) =>  Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
             border: Border.all(
               color: Colors.orange,
               style: BorderStyle.solid,
               width: 2.0
             ),
             borderRadius: BorderRadius.circular(40.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.orange,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 140.0,
                            height: 140.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 25.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Username',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Sameer',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: IconButton(
                            color: Colors.orange,
                            onPressed: (){
                              createAlertDailog(context).then((onValue){
                                SnackBar mySnacBar = SnackBar(
                                  content: Text("Username $onValue is updated"),
                                  duration: Duration(milliseconds: 1000),
                                  );
                                Scaffold.of(context).showSnackBar(mySnacBar);
                              });
                            },
                            icon: Icon(FontAwesomeIcons.pen),
                            )
                        ),
                      ),
                    
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Birthday',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('26 Jan, 1998',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: IconButton(
                          onPressed: (){
                                 createAlertDailog1(context).then((onValue){
                                SnackBar mySnacBar = SnackBar(
                                  content: Text("Birthday $onValue is updated"),
                                  duration: Duration(milliseconds: 1000),
                                  );
                                Scaffold.of(context).showSnackBar(mySnacBar);
                              });
                          },
                          color: Colors.orange,
                          icon: Icon(FontAwesomeIcons.pen),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Location',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Dhamankar Naka',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: IconButton(
                          onPressed: (){
                                 createAlertDailog2(context).then((onValue){
                                SnackBar mySnacBar = SnackBar(
                                  content: Text("Location $onValue is updated"),
                                  duration: Duration(milliseconds: 1000),
                                  );
                                Scaffold.of(context).showSnackBar(mySnacBar);
                              });
                          },
                          icon: Icon(FontAwesomeIcons.pen),
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Email',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                      SizedBox(width: 20.0),
                      Text('gsms.sam@bakchod.com',
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
               Container(
                 height: 40.0,
                 width: 220.0,
                 decoration: BoxDecoration(
                   color: Colors.orange,
                   borderRadius: BorderRadius.circular(40.0),
                 ),
                 child: FlatButton(
                  
                   onPressed: (){
                     //uploadPic(context);
                     addDailog(context);
                   },
                   child: Text("Update Profile Details",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 17.0,
                     fontWeight: FontWeight.w500,
                     fontStyle: FontStyle.italic
                   ),
                   ),
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