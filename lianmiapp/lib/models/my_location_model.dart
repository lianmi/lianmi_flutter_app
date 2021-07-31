class MyLocationModel {
  double? longitude;
  double? latitude;
  String? province;
  String? city;
  String? area;

  MyLocationModel(
      {this.longitude, this.latitude, this.province, this.city, this.area});

  MyLocationModel.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    province = json['province'];
    city = json['city'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['province'] = this.province;
    data['city'] = this.city;
    data['area'] = this.area;
    return data;
  }
}

