import 'package:flutter/material.dart';
import 'package:restaurent_app/Pages/AppDrawer.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        key: _scaffoldKey,
        drawer: AppDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40.0,left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 30.0,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 65.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
