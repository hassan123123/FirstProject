import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_app/bloc/cartListBloc.dart';
import 'package:restaurent_app/login/LoginAuth.dart';
import 'package:restaurent_app/model/foodItem.dart';
import 'AppDrawerPages/profilepage.dart';
import 'bloc/cartListBloc.dart';
import 'login/RootPage.dart';
import 'model/cart.dart';
import 'package:restaurent_app/login/auth.dart';
import 'package:restaurent_app/AppDrawerPages/About.dart';
import 'package:restaurent_app/AppDrawerPages/contactus.dart';
import 'package:restaurent_app/AppDrawerPages/MyOrders.dart';
import 'package:restaurent_app/Pages/oval-right-clipper.dart';
import 'package:restaurent_app/AppDrawerPages/notifications.dart';

class Home extends StatelessWidget {
  Home({this.onSignedOut, this.auth, this.root,this.loginAuth});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final Root root;
  final LoginAuth loginAuth;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(scaffoldKey: scaffoldKey),
              SizedBox(
                height: 25.0,
              ),
              tabs(),
            ],
          ),
        ),
      ),
      drawer: CustomAppDrawer(auth: Auth(), onSignedOut: onSignedOut, loginAuth: LoginAuth(),),
    );
  }

  Widget tabs() {
    return Container(
      height: 2100,
      width: double.infinity,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(175.0),
                child: Container(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        TabBar(
                        
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: new BubbleTabIndicator(
                              indicatorColor: Colors.yellow[800],
                              tabBarIndicatorSize: TabBarIndicatorSize.tab,
                              indicatorHeight: 191,indicatorRadius: 350.0,
                              insets: const EdgeInsets.only(top:00.0,bottom: 18.0,left: 9.0,right: 19.0)
                               ),
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          labelPadding: EdgeInsets.only(bottom: 15.0, left: 10),

                          //        labelStyle: TextStyle(
                          //           fontSize: 25.0, fontWeight: FontWeight.w800),
                          //   unselectedLabelColor: Colors.black26,
                          //     unselectedLabelStyle: TextStyle(
                          //          fontSize: 25.0, fontWeight: FontWeight.w200),
                          tabs: <Widget>[
                            CategoryListItem(
                              categoryIcon: Icons.restaurant_menu,
                              categoryName: "Pizza",
                              availability: 12,
                            ),
                            CategoryListItem(
                              categoryIcon: Icons.restaurant_menu,
                              categoryName: "Pizza",
                              availability: 12,
                            ),
                            CategoryListItem(
                              categoryIcon: Icons.restaurant_menu,
                              categoryName: "Rolls",
                              availability: 12,
                            ),
                            CategoryListItem(
                              categoryIcon: Icons.restaurant_menu,
                              categoryName: "Stick",
                              availability: 12,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
      
          body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                controller: ScrollController(initialScrollOffset: 0.0),
                child: Column(
                  children: <Widget>[
                    for (var foodItem in fooditemListBurger.foodItems)
                      ItemContainer(foodItem: foodItem),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(initialScrollOffset: 0.0),
                child: Column(
                  children: <Widget>[
                    for (var foodItem in fooditemListPizza.foodItems)
                      ItemContainer(foodItem: foodItem),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(initialScrollOffset: 0.0),
                child: Column(
                  children: <Widget>[
                    for (var foodItem in fooditemListRolls.foodItems)
                      ItemContainer(foodItem: foodItem),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(initialScrollOffset: 0.0),
                child: Column(
                  children: <Widget>[
                    for (var foodItem in fooditemListStick.foodItems)
                      ItemContainer(foodItem: foodItem),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CustomAppDrawer extends StatefulWidget {
  CustomAppDrawer({this.home, this.auth, this.onSignedOut,this.loginAuth});
  final VoidCallback onSignedOut;
  final Home home;
  final Auth auth;
  final LoginAuth loginAuth;

  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  final Color primary = Colors.white;

  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;

@override
  void initState() {
    super.initState();
    getUser();
  }

  void signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print("error is $e");
    }
  }

FirebaseUser currentUser;

void getUser() async{
FirebaseAuth.instance.currentUser().then((FirebaseUser user){
  setState((){
    this.currentUser=user;
  });
});
}

String email(){
  return currentUser.email;
}

  @override
  Widget build(BuildContext context) {
    final String image = "assets/logo.png";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: signOut,
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange])),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(image),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Chandu Vemula",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                email(),
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                  child: _buildRow(Icons.home, "Home"),
                ),
                _buildDivider(),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    child: _buildRow(Icons.person_pin, "My profile")),
                _buildDivider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrders(),
                        ));
                  },
                  child: _buildRow(Icons.fastfood, "My Orders"),
                ),
                _buildDivider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Notifications(),
                        ));
                  },
                  child: _buildRow(Icons.notifications, "Notifications"),
                ),
                _buildDivider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsPage(),
                        ));
                  },
                  child: _buildRow(Icons.email, "Contact Us"),
                ),
                _buildDivider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => About(),
                        ));
                  },
                  child: _buildRow(Icons.info_outline, "About"),
                ),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;
  ItemContainer({@required this.foodItem});
  final CartListBLoc bloc = BlocProvider.getBloc<CartListBLoc>();

  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);
        final snackbar = SnackBar(
          content: Text("${foodItem.title} added to the cart"),
          duration: Duration(milliseconds: 1000),
        );

        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: foodItem.id % 2 == 0 ? true : false,
      ),
    );
  }
}

class Items extends StatelessWidget {
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel,
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final String hotel;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(imgUrl, fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          itemName,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      Text(
                        "\$$itemPrice",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ]),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                        children: [
                          TextSpan(
                              text: " by ",
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          TextSpan(
                              text: hotel,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic))
                        ],
                      )),
                    ),
                    SizedBox(height: containerPadding),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class FirstHalf extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  FirstHalf({this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(scaffoldKey: scaffoldKey),
          SizedBox(
            height: 30.0,
          ),
          title(),
      
       
        ],
      ),
    );
  }

  /* Widget categories() {
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryIcon: Icons.restaurant_menu,
            categoryName: "Burgers",
            availability: 12,
            selected: true,
          ),
          CategoryListItem(
            categoryIcon: Icons.restaurant_menu,
            categoryName: "Pizza",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.restaurant_menu,
            categoryName: "Rolls",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.restaurant_menu,
            categoryName: "Stick",
            availability: 12,
            selected: false,
          ),
        ],
      ),
    );
  }*/

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 45.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Food",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30.0,
              ),
            ),
            Text(
              "Delivery",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30.0),
            )
          ],
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final CartListBLoc bloc = BlocProvider.getBloc<CartListBLoc>();
  final GlobalKey<ScaffoldState> scaffoldKey;
  CustomAppBar({this.auth, this.onSignedOut, this.scaffoldKey});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  Widget build(BuildContext context) {
    var container = Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                this.scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
            initialData: <FoodItem>[],
          ),
        ],
      ),
    );
    return container;
  }
}

GestureDetector buildGestureDetector(
    int length, BuildContext context, List<FoodItem> foodItems) {
  return GestureDetector(
    onTap: () {
      if (length > 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
    },
    child: Container(
      margin: EdgeInsets.only(right: 30.0),
      child: Text(length.toString()),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.yellow[800], borderRadius: BorderRadius.circular(50.0)),
    ),
  );
}

class CategoryListItem extends StatefulWidget {
  final IconData categoryIcon;
  final String categoryName;
  final int availability;

  CategoryListItem({
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
  });

  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: Colors.grey[200], width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: Colors.black45,
                width: 1.5,
              ),
            ),
            child: Icon(
              widget.categoryIcon,
              color: Colors.black,
              size: 30.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            widget.categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15.0,
            color: Colors.black26,
          ),
          Text(
            widget.availability.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
