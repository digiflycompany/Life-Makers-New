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
        voters!.add(Voters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errNum'] = errNum;
    data['msg'] = msg;
    if (voters != null) {
      data['Voters'] = voters!.map((v) => v.toJson()).toList();
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
  String? city;
  String? birthDate;
  List<dynamic>? achievements; // Use dynamic instead of Null
  int? candidate;
  List<dynamic>? users; // Use dynamic instead of Null

  Voters({
    this.id,
    this.name,
    this.imageUrl,
    this.vote,
    this.details,
    this.candidateFor,
    this.city,
    this.birthDate,
    this.achievements,
    this.candidate,
    this.users,
  });

  Voters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    vote = json['vote'];
    details = json['details'];
    candidateFor = json['candidate_for'];
    city = json['city'];
    birthDate = json['birth_date'];
    achievements = json['achievements'];
    candidate = json['candidate'];
    users = json['users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['vote'] = vote;
    data['details'] = details;
    data['candidate_for'] = candidateFor;
    data['city'] = city;
    data['birth_date'] = birthDate;
    data['achievements'] = achievements;
    data['candidate'] = candidate;
    data['users'] = users;
    return data;
  }
}
