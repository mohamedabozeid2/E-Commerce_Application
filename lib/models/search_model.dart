
class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<products>? data;
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
      data = <products>[];
      json['data'].forEach((element) {
        data!.add(products.fromJson(element));
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

class products {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  products.fromJson(Map<String, dynamic> json){
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
//   String? message;
//   Data? data;
//
//   FavoriteModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
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
//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <FavoriteData>[];
//       json['data'].forEach((element) {
//         data!.add(FavoriteData.fromJson(element));
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
// }
//
// class FavoriteData {
//   int? id;
//   Product? product;
//
//   FavoriteData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product = json['product'] != null ? Product.fromJson(json['product']) : null;
//   }
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
//
