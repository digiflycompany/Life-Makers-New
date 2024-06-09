// class UserModel {
//   bool? status;
//   String? message;
//   User? user;
//   String? token;
//
//   UserModel({this.status, this.message, this.user, this.token});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     token = json['token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['token'] = this.token;
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? email;
//   String? name;
//   String? phone;
//   String? photo;
//   String? whatsappNumber;
//   String? idCardNumber;
//   String? theJob;
//   String? theAddress;
//   String? governorate;
//   String? cityCenter;
//   String? previousExperience;
//   dynamic code;
//   dynamic expireAt;
//   int? isAdmin;
//   int? isActive;
//   int? ban;
//   int? old;
//   String? username;
//   bool? voted;
//   String? gender;
//   dynamic education;
//   String? qrCode;
//   List<Voters>? voters;
//
//   User(
//       {this.id,
//         this.email,
//         this.name,
//         this.phone,
//         this.whatsappNumber,
//         this.idCardNumber,
//         this.theJob,
//         this.photo,
//         this.theAddress,
//         this.governorate,
//         this.cityCenter,
//         this.previousExperience,
//         this.code,
//         this.expireAt,
//         this.isAdmin,
//         this.isActive,
//         this.ban,
//         this.old,
//         this.username,
//         this.voted,
//         this.gender,
//         this.education,
//         this.qrCode,
//         this.voters});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     photo = json['photo'];
//     email = json['email'];
//     name = json['name'];
//     phone = json['phone'];
//     whatsappNumber = json['whatsapp_number'];
//     idCardNumber = json['id_card_number'];
//     theJob = json['the_job'];
//     theAddress = json['the_address'];
//     governorate = json['governorate'];
//     cityCenter = json['city_center'];
//     previousExperience = json['previous_experience'];
//     code = json['code'];
//     expireAt = json['expire_at'];
//     isAdmin = json['is_admin'];
//     isActive = json['is_active'];
//     ban = json['ban'];
//     old = json['old'];
//     username = json['username'];
//     voted = json['voted'];
//     gender = json['gender'];
//     education = json['education'];
//     qrCode = json['qr_code'];
//     if (json['voters'] != null) {
//       voters = <Voters>[];
//       json['voters'].forEach((v) {
//         voters!.add(new Voters.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['email'] = this.email;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['whatsapp_number'] = this.whatsappNumber;
//     data['id_card_number'] = this.idCardNumber;
//     data['the_job'] = this.theJob;
//     data['photo'] = this.photo;
//     data['the_address'] = this.theAddress;
//     data['governorate'] = this.governorate;
//     data['city_center'] = this.cityCenter;
//     data['previous_experience'] = this.previousExperience;
//     data['code'] = this.code;
//     data['expire_at'] = this.expireAt;
//     data['is_admin'] = this.isAdmin;
//     data['is_active'] = this.isActive;
//     data['ban'] = this.ban;
//     data['old'] = this.old;
//     data['username'] = this.username;
//     data['voted'] = this.voted;
//     data['gender'] = this.gender;
//     data['education'] = this.education;
//     data['qr_code'] = this.qrCode;
//     if (this.voters != null) {
//       data['voters'] = this.voters!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Voters {
//   int? id;
//   String? name;
//   String? imageUrl;
//   int? vote;
//   String? details;
//   dynamic candidateFor;
//   Pivot? pivot;
//
//   Voters(
//       {this.id,
//         this.name,
//         this.imageUrl,
//         this.vote,
//         this.details,
//         this.candidateFor,
//         this.pivot});
//
//   Voters.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     imageUrl = json['image_url'];
//     vote = json['vote'];
//     details = json['details'];
//     candidateFor = json['candidate_for'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image_url'] = this.imageUrl;
//     data['vote'] = this.vote;
//     data['details'] = this.details;
//     data['candidate_for'] = this.candidateFor;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
// class Pivot {
//   int? userId;
//   int? votersId;
//
//   Pivot({this.userId, this.votersId});
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     votersId = json['voters_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['voters_id'] = this.votersId;
//     return data;
//   }
// }
class UserModel {
  final bool status;
  final String message;
  final User user;
  final String token;

  UserModel({
    required this.status,
    required this.message,
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'user': user.toJson(),
      'token': token,
    };
  }
}

class User {
  final int id;
  final String email;
  final String name;
  final String phone;
  final String whatsappNumber;
  final String idCardNumber;
  final String job;
  final String address;
  final String governorate;
  final String cityCenter;
  final String previousExperience;
  final String code;
  final String expireAt;
  final int isAdmin;
  final int isActive;
  final int ban;
  final int old;
  final String username;
  final bool voted;
  final String gender;
  final String? education;
  final String qrCode;
  final String? photo;
  final String? deviceToken;
  final String lastLogin;
  final String? randomCode;
  final double? lat;
  final double? long;
  final String apiToken;
  final int points;
  final List<dynamic> voters;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.whatsappNumber,
    required this.idCardNumber,
    required this.job,
    required this.address,
    required this.governorate,
    required this.cityCenter,
    required this.previousExperience,
    required this.code,
    required this.expireAt,
    required this.isAdmin,
    required this.isActive,
    required this.ban,
    required this.old,
    required this.username,
    required this.voted,
    required this.gender,
    this.education,
    required this.qrCode,
    this.photo,
    this.deviceToken,
    required this.lastLogin,
    this.randomCode,
    this.lat,
    this.long,
    required this.apiToken,
    required this.points,
    required this.voters,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      whatsappNumber: json['whatsapp_number'],
      idCardNumber: json['id_card_number'],
      job: json['the_job'],
      address: json['the_address'],
      governorate: json['governorate'],
      cityCenter: json['city_center'],
      previousExperience: json['previous_experience'],
      code: json['code'],
      expireAt: json['expire_at'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
      ban: json['ban'],
      old: json['old'],
      username: json['username'],
      voted: json['voted'],
      gender: json['gender'],
      education: json['education'],
      qrCode: json['qr_code'],
      photo: json['photo'],
      deviceToken: json['device_token'],
      lastLogin: json['last_login'],
      randomCode: json['random_code'],
      lat: json['lat'],
      long: json['long'],
      apiToken: json['api_token'],
      points: json['points'],
      voters: List<dynamic>.from(json['voters']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'whatsapp_number': whatsappNumber,
      'id_card_number': idCardNumber,
      'the_job': job,
      'the_address': address,
      'governorate': governorate,
      'city_center': cityCenter,
      'previous_experience': previousExperience,
      'code': code,
      'expire_at': expireAt,
      'is_admin': isAdmin,
      'is_active': isActive,
      'ban': ban,
      'old': old,
      'username': username,
      'voted': voted,
      'gender': gender,
      'education': education,
      'qr_code': qrCode,
      'photo': photo,
      'device_token': deviceToken,
      'last_login': lastLogin,
      'random_code': randomCode,
      'lat': lat,
      'long': long,
      'api_token': apiToken,
      'points': points,
      'voters': voters,
    };
  }
}