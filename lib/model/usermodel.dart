 UserModel? currentUser;

class UserModel {
  String? Fullname;
  String? id;
  String? phone;
  String? email;
  int? status;
  Map? bankDetails;
  Map? companyInformation;

  UserModel({
    this.Fullname,
    this.id,
    this.phone,
    this.email,
    this.status,
    this.bankDetails,
    this.companyInformation,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    Fullname = json["name"];
    id = json["id"];
    phone = json["phone"];
    email = json["email"];
    companyInformation = json["companyInformation"];
    status = json["status"];
    bankDetails = json["bankDetails"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = Fullname ?? "";
    data["id"] = id ?? "";
    data["phone"] = phone ?? "";
    data["email"] = email ?? "";
    data["companyAddress"] = companyInformation ?? {};
    data["bankDetails"] = bankDetails ?? {};
    data["status"] = status ?? 0;
    return data;
  }

}
