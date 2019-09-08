import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class FooditemList {
  List<FoodItem> foodItems;
  FooditemList({this.foodItems});
}

class FoodItem {
  int id;
  String title;
  double price;

  FoodItem(
      {@required this.id,
      @required this.title,
      @required this.price,
});

  Map toMap(FoodItem foodItem) {
    var data = Map<String, dynamic>();
    data['id'] =foodItem.id;
    data['title'] =foodItem.title;
    data['price'] =foodItem.price;
    return data;
  }
  FoodItem.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['id'];
    this.title = mapData['title'];
    this.price = mapData['price'];
  }

}