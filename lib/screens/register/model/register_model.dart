class RegisterModel {
  bool? success;
  String? message;
  Data? data;

  RegisterModel({this.success, this.message, this.data});

  RegisterModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? token;

  Data({this.id, this.name, this.mobile, this.email, this.image, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
  }

}
