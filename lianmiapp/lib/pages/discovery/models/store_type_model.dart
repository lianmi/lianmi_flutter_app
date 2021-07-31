class StoreTypeModel {
  int? storeType;
  String? name;

  StoreTypeModel({this.storeType, this.name});

  StoreTypeModel.fromJson(Map<String, dynamic> json) {
    storeType = json['StoreType'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StoreType'] = this.storeType;
    data['Name'] = this.name;
    return data;
  }

  static List<StoreTypeModel> modelListFromJson(json) {
    List<StoreTypeModel> results = [];
    if (json != null) {
      json.forEach((v) {
        results.add(new StoreTypeModel.fromJson(v));
      });
    }
    return results;
  }
}
