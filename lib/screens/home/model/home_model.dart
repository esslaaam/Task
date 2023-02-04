class ProductsModel {
  bool? success;
  String? message;
  Data? data;

  ProductsModel({this.success, this.message, this.data});

  ProductsModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? name;
  List<Product>? product;

  Data({this.id, this.name, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

}

class Product {
  int? id;
  String? name;
  String? image;
  int? price;
  int? oldprice;

  Product({this.id, this.name, this.image, this.price, this.oldprice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    oldprice = json['oldprice'];
  }

}
