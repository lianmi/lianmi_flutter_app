class ReportDataModel {
  String userName;
  int type;
  String description;
  String image1; //附件图片1
  String image2; //附件图片2

  ReportDataModel({
    this.userName = '',
    this.type = 0,
    this.description = '',
    this.image1 = '',
    this.image2 = '',
  });
}
