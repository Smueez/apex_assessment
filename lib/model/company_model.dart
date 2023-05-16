class CompanyModel {
  int? id;
  String? companyName;
  String? email;
  String? password;
  String? phone;
  String? createdAt;
  String? updatedAt;

  CompanyModel(
      {this.id,
        this.companyName,
        this.email,
        this.password,
        this.phone,
        this.createdAt,
        this.updatedAt});

  CompanyModel.fromJson(Map json) {
    id = json['id'];
    companyName = json['company_name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
