class AllCandidatesModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Voters>? voters;

  AllCandidatesModel({this.status, this.errNum, this.msg, this.voters});

  AllCandidatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['Voters'] != null) {
      voters = <Voters>[];
      json['Voters'].forEach((v) {
        voters!.add(new Voters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.voters != null) {
      data['Voters'] = this.voters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Voters {
  int? id;
  String? name;
  String? imageUrl;
  int? vote;
  String? details;
  String? candidateFor;
  int? candidate;
  List<Users>? users;

  Voters(
      {this.id,
        this.name,
        this.imageUrl,
        this.vote,
        this.details,
        this.candidateFor,
        this.candidate,
        this.users});

  Voters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    vote = json['vote'];
    details = json['details'];
    candidateFor = json['candidate_for'];
    candidate = json['candidate'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['vote'] = this.vote;
    data['details'] = this.details;
    data['candidate_for'] = this.candidateFor;
    data['candidate'] = this.candidate;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
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
  dynamic code;
  dynamic expireAt;
  int? isAdmin;
  int? isActive;
  int? ban;
  int? old;
  String? username;
  bool? voted;
  String? gender;
  String? education;
  String? qrCode;
  Pivot? pivot;

  Users(
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
        this.education,
        this.qrCode,
        this.pivot});

  Users.fromJson(Map<String, dynamic> json) {
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
    qrCode = json['qr_code'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['qr_code'] = this.qrCode;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? votersId;
  int? userId;

  Pivot({this.votersId, this.userId});

  Pivot.fromJson(Map<String, dynamic> json) {
    votersId = json['voters_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voters_id'] = this.votersId;
    data['user_id'] = this.userId;
    return data;
  }
}
