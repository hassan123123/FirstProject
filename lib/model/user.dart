class User {
  String uid;
  String phone;
  String email;
  String username;
  String address;

  User({
    this.uid,
    this.phone,
    this.email,
    this.username,
    this.address
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['phone'] = user.phone;
    data['email'] = user.email;
    data['username'] = user.username;
    data['address'] = user.address;
    return data;
  }
  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.phone = mapData['phone'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.address = mapData['address'];
  }

}