AdminModel? AdminUser;

class AdminModel {
  String? name;
  String? id;
  bool? verified;
  bool? delete;
  // String? phone;
  String? email;
  int? status;
  String? photo;
  DateTime? createdTime;



  AdminModel({
    this.status,
    this.name,
    this.id,
    this.delete,
    this.verified,
    this.email,
    this.createdTime,
    this.photo,



  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json["display_name"];
    id = json["uid"];
    email = json["email"];
    delete = json["delete"];
    verified = json["verified"];
    status = json["status"];
    photo = json["photo_url"];
    createdTime  = json["created_time"].toDate();
  }



}
