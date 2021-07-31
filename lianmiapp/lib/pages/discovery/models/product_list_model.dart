// class ProductListModel {
//   String? productId;
//   String? productName;
//   int? productType;
//   String? productDesc;
//   List<ProductPicModel>? productPics;
//   int? price;
//   List<String>? descPics;
//   int? createAt;
//   int? modifyAt;
//   bool? allowCancel;

//   ProductListModel(
//       {this.productId,
//       this.productName,
//       this.productType,
//       this.productDesc,
//       this.productPics,
//       this.price,
//       this.descPics,
//       this.createAt,
//       this.modifyAt,
//       this.allowCancel});

//   ProductListModel.fromJson(Map<String, dynamic> json) {
//     productId = json['productId'];
//     productName = json['productName'];
//     productType = json['productType'];
//     productDesc = json['ProductDesc'];
//     if (json['productPics'] != null) {
//       productPics = [];
//       json['productPics'].forEach((v) {
//         productPics!.add(new ProductPicModel.fromJson(v));
//       });
//     }
//     price = json['price'];
//     descPics = json['descPics'].cast<String>();
//     createAt = json['ceateAt'];
//     modifyAt = json['modifyAt'];
//     allowCancel = json['allowCancel'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['productId'] = this.productId;
//     data['productName'] = this.productName;
//     data['productType'] = this.productType;
//     data['ProductDesc'] = this.productDesc;
//     if (this.productPics != null) {
//       data['productPics'] =
//           this.productPics!.map((v) => v.toJson()).toList();
//     }
//     data['price'] = this.price;
//     data['descPics'] = this.descPics;
//     data['createAt'] = this.createAt;
//     data['modifyAt'] = this.modifyAt;
//     data['allowCancel'] = this.allowCancel;
//     return data;
//   }

//   static List<ProductListModel> modelListFromJson(json) {
//     List<ProductListModel> results = [];
//     if (json != null) {
//       json.forEach((v) {
//         results.add(new ProductListModel.fromJson(v));
//       });
//     }
//     return results;
//   }
// }

// class ProductPicModel {
//   String? small;
//   String? middle;
//   String? large;

//   ProductPicModel({this.small, this.middle, this.large});

//   ProductPicModel.fromJson(Map<String, dynamic> json) {
//     small = json['small'];
//     middle = json['middle'];
//     large = json['large'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['small'] = this.small;
//     data['middle'] = this.middle;
//     data['large'] = this.large;
//     return data;
//   }
// }

