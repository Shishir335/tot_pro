class AboutUs {
  String? companyLogo;
  String? address1;
  String? phone1;
  String? email1;

  AboutUs({this.companyLogo, this.address1, this.phone1, this.email1});

  AboutUs.fromJson(Map<String, dynamic> json) {
    companyLogo = json['company_logo'];
    address1 = json['address1'];
    phone1 = json['phone1'];
    email1 = json['email1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_logo'] = companyLogo;
    data['address1'] = address1;
    data['phone1'] = phone1;
    data['email1'] = email1;
    return data;
  }
}
