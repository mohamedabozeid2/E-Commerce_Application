// class FavoriteModel{
//   bool? status;
//   Data? data;
//
//   FavoriteModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     data = json['data'] ? Data.fromJson(json['data']) : null ;
//   }
//
// }
// class Data{
//     int? currentPage;
//     List<InnerData>? data;
//     String? firstPageUrl;
//     int? from;
//     int? lastPage;
//     String? lastPageUrl;
//     Null? nextPageUrl;
//     String? path;
//     int? perPage;
//     Null? prevPageUrl;
//     int? to;
//     int? total;
//
//     Data.fromJson(Map<String, dynamic> json){
//       currentPage = json['current_page'];
//       if(json['data'] != null){
//         data = <InnerData>[];
//         json['data'].forEach((element){
//           data!.add(InnerData.fromJson(element));
//         });
//       }
//       firstPageUrl = json['first_page_url'];
//       from = json['from'];
//       lastPage = json['last_page'];
//       lastPageUrl = json['last_page_url'];
//       nextPageUrl = json['next_page_url'];
//       path = json['path'];
//       perPage = json['per_page'];
//       prevPageUrl = json['prev_page_url'];
//       to = json['to'];
//       total = json['total'];
//     }
// }
//
// class InnerData{
//   int? id;
//   Product? product;
//   InnerData.fromJson(Map<String,dynamic> json){
//     id = json['id'];
//     product =json['product'] != null ? Product.fromJson(json['product']) : null;
//   }
// }
//
// class Product{
//   int? id;
//   dynamic? price;
//   dynamic? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//
//   Product.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
// }
//
//

class FavoriteModel {
  bool? status;
  String? message;
  Data? data;

  FavoriteModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<FavoriteData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoriteData>[];
      json['data'].forEach((element) {
        data!.add(FavoriteData.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoriteData {
  int? id;
  Product? product;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}

// class FavoriteModel {
//   bool? status;
//   Null? message;
//   Data? data;
//
//
//   FavoriteModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
// }
//
// class Data {
//   int? currentPage;
//   List<FavoriteData>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;
//
//
//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <FavoriteData>[];
//       json['data'].forEach((v) {
//         data!.add(new FavoriteData.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
// }
//
// class FavoriteData {
//   int? id;
//   Product? product;
//
//
//   FavoriteData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }
//
// }
//
// class Product {
//   int? id;
//   dynamic? price;
//   dynamic? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
//
// }
