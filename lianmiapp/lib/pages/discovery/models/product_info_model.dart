// class ProductInfoModel {
//   String? productId;
//   String? productName;
//   int? productType;
//   int? subType;
//   String? productDesc;
//   List<ProductPicModel>? productPics;
//   int? price;
//   List<String>? descPics;
//   // int? createAt;
//   // int? modifyAt;
//   // bool? allowCancel;

//   ProductInfoModel({
//     this.productId,
//     this.productName,
//     this.productType,
//     this.subType,
//     this.productDesc,
//     this.productPics,
//     this.price,
//     this.descPics,
//     // this.createAt,
//     // this.modifyAt,
//     // this.allowCancel,
//   });

//   ProductInfoModel.fromMap(Map<String, dynamic> json) {
//     productId = json['productId'];
//     productName = json['productName'];
//     productType = json['productType'];
//     subType = json['subType'];
//     productDesc = json['productDesc'];
//     if (json['productPics'] != null) {
//       productPics = [];
//       json['productPics'].forEach((v) {
//         productPics!.add(new ProductPicModel.fromMap(v));
//       });
//     }
//     price = json['price'];
//     descPics = json['descPics'].cast<String>();
//     // createAt = json['createAt'];
//     // modifyAt = json['modifyAt'];
//     // allowCancel = json['allowCancel'];
//   }

//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['productId'] = this.productId;
//     data['productName'] = this.productName;
//     data['productType'] = this.productType;
//     data['subType'] = this.subType;
//     data['productDesc'] = this.productDesc;
//     if (this.productPics != null) {
//       data['productPics'] = this.productPics!.map((v) => v.toMap()).toList();
//     }
//     data['price'] = this.price;
//     data['descPics'] = this.descPics;
//     // data['createAt'] = this.createAt;
//     // data['modifyAt'] = this.modifyAt;
//     // data['allowCancel'] = this.allowCancel;
//     return data;
//   }
// }

// class ProductPicModel {
//   String? small;
//   String? middle;
//   String? large;

//   ProductPicModel({this.small, this.middle, this.large});

//   ProductPicModel.fromMap(Map<String, dynamic> json) {
//     small = json['small'];
//     middle = json['middle'];
//     large = json['large'];
//   }

//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['small'] = this.small;
//     data['middle'] = this.middle;
//     data['large'] = this.large;
//     return data;
//   }
// }
