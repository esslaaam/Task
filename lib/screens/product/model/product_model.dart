class ProductDetailsModel {
  bool? success;
  String? message;
  Data? data;

  ProductDetailsModel({this.success, this.message, this.data});

  ProductDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? name;
  String? category;
  String? description;
  String? image;
  int? price;
  int? oldprice;
  int? favourite;
  int? discount;
  int? priceAfterDiscount;
  List<MoreImage>? moreImage;
  List<Color>? color;

  Data(
      {this.id,
        this.name,
        this.category,
        this.description,
        this.image,
        this.price,
        this.oldprice,
        this.favourite,
        this.discount,
        this.priceAfterDiscount,
        this.moreImage,
        this.color});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    oldprice = json['oldprice'];
    favourite = json['favourite'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    if (json['MoreImage'] != null) {
      moreImage = <MoreImage>[];
      json['MoreImage'].forEach((v) {
        moreImage!.add( MoreImage.fromJson(v));
      });
    }
    if (json['Color'] != null) {
      color = <Color>[];
      json['Color'].forEach((v) {
        color!.add( Color.fromJson(v));
      });
    }
  }

}

class MoreImage {
  int? id;
  String? image;
  String? hex;

  MoreImage({this.id, this.image, this.hex});

  MoreImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    hex = json['hex'];
  }

}

class Color {
  int? id;
  String? name;
  String? hex;
  List<Size>? size;

  Color({this.id, this.name, this.hex, this.size});

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hex = json['hex'];
    if (json['Size'] != null) {
      size = <Size>[];
      json['Size'].forEach((v) {
        size!.add( Size.fromJson(v));
      });
    }
  }

}

class Size {
  int? id;
  String? name;

  Size({this.id, this.name});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
