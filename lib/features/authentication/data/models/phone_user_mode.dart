class PhoneUserModel {
  bool? status;
  String? message;
  User? user;
  int? code;

  PhoneUserModel({this.status, this.message, this.user, this.code});

  PhoneUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? name;
  String? phone;
  String? whatsappNumber;
  String? idCardNumber;
  String? theJob;
  String? theAddress;
  String? governorate;
  String? cityCenter;
  String? previousExperience;
  int? code;
  String? expireAt;
  int? isAdmin;
  int? isActive;
  int? ban;
  int? old;
  String? username;
  bool? voted;
  String? gender;
  String? education;

  User(
      {this.id,
        this.email,
        this.name,
        this.phone,
        this.whatsappNumber,
        this.idCardNumber,
        this.theJob,
        this.theAddress,
        this.governorate,
        this.cityCenter,
        this.previousExperience,
        this.code,
        this.expireAt,
        this.isAdmin,
        this.isActive,
        this.ban,
        this.old,
        this.username,
        this.voted,
        this.gender,
        this.education});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    whatsappNumber = json['whatsapp_number'];
    idCardNumber = json['id_card_number'];
    theJob = json['the_job'];
    theAddress = json['the_address'];
    governorate = json['governorate'];
    cityCenter = json['city_center'];
    previousExperience = json['previous_experience'];
    code = json['code'];
    expireAt = json['expire_at'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    ban = json['ban'];
    old = json['old'];
    username = json['username'];
    voted = json['voted'];
    gender = json['gender'];
    education = json['education'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['whatsapp_number'] = this.whatsappNumber;
    data['id_card_number'] = this.idCardNumber;
    data['the_job'] = this.theJob;
    data['the_address'] = this.theAddress;
    data['governorate'] = this.governorate;
    data['city_center'] = this.cityCenter;
    data['previous_experience'] = this.previousExperience;
    data['code'] = this.code;
    data['expire_at'] = this.expireAt;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['ban'] = this.ban;
    data['old'] = this.old;
    data['username'] = this.username;
    data['voted'] = this.voted;
    data['gender'] = this.gender;
    data['education'] = this.education;
    return data;
  }
}
