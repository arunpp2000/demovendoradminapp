UserModel? currentUser;

class UserModel {
  String? Fullname;
  String? id;
  String? phone;
  String? email;
  String? city;
  String? state;
  String? pincode;
  String? Soleproprietor;
  String? Organization;
  String? CompanyAddress;
  String? photoUrl;
  dynamic? gstNo;
  int? status;

  UserModel({
    this.Fullname,
    this.id,
    this.phone,
    this.email,
    this.city,
    this.state,
    this.pincode,
    this.Soleproprietor,
    this.Organization,
    this.CompanyAddress,
    this.photoUrl,
    this.gstNo,
    this.status,
    
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    Fullname = json["name"];
    id = json["id"];
    phone = json["phone"];
    email = json["email"];
    city = json["city"];
    state = json["state"];
    pincode = json["pincode"];
    Soleproprietor = json["soleproprietor"];
    Organization = json["organization"];
    CompanyAddress = json["companyAddress"];
    photoUrl = json["photoUrl"];
    gstNo = json["gstNo"];
    status = json["status"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = Fullname ?? "";
    data["id"] = id ?? "";
    data["phone"] = phone ?? "";
    data["email"] = email ?? "";
    data["city"] = city ?? "";
    data["state"] = state ?? "";
    data["pincode"] = pincode ?? "";
    data["soleproprietor"] = Soleproprietor ?? "";
    data["organization"] = Organization ?? "";
    data["companyAddress"] = CompanyAddress ?? "";
    data["photoUrl"] = photoUrl ?? "";
    data["gstNo"] = gstNo ?? "";
    data["status"] = status ?? 0;
    return data;
  }

  UserModel copyWith({
    String? Fullname,
    String? id,
    String? phone,
    String? email,
    String? city,
    String? state,
    String? pincode,
    String? Soleproprietor,
    String? Organization,
    String? CompanyAddress,
    String? photoUrl,
    dynamic gstNo,
    int?status,

  }) {
    return UserModel(
        Fullname: Fullname ?? this.Fullname,
        id: id ?? this.id,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        Soleproprietor: Soleproprietor ?? this.Soleproprietor,
        Organization: Organization ?? this.Organization,
        CompanyAddress: CompanyAddress ?? this.CompanyAddress,
        photoUrl: photoUrl ?? this.photoUrl,
        gstNo: gstNo ?? this.gstNo,
        status: status??this.status,
        );
  }
}
