class VolunteerPracticalTrainingModel {
  bool? status;
  String? errNum;
  String? msg;
  List<VolunteerOpportunities>? volunteerOpportunities;

  VolunteerPracticalTrainingModel(
      {this.status, this.errNum, this.msg, this.volunteerOpportunities});

  VolunteerPracticalTrainingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['volunteer_opportunities'] != null) {
      volunteerOpportunities = <VolunteerOpportunities>[];
      json['volunteer_opportunities'].forEach((v) {
        volunteerOpportunities!.add(new VolunteerOpportunities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.volunteerOpportunities != null) {
      data['volunteer_opportunities'] =
          this.volunteerOpportunities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VolunteerOpportunities {
  int? id;
  String? name;
  String? details;
  String? startAt;
  dynamic endAt;
  String? type;
  String? createdAt;
  String? updatedAt;
  dynamic city;
  String? photo;
  int? isActive;
  String? shortDetails;
  bool? userJoined;
  List<Volunteers>? volunteers;

  VolunteerOpportunities(
      {this.id,
        this.name,
        this.details,
        this.startAt,
        this.endAt,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.city,
        this.photo,
        this.isActive,
        this.shortDetails,
        this.userJoined,
        this.volunteers});

  VolunteerOpportunities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'];
    photo = json['photo'];
    isActive = json['is_active'];
    shortDetails = json['short_details'];
    userJoined = json['user_joined'];
    if (json['volunteers'] != null) {
      volunteers = <Volunteers>[];
      json['volunteers'].forEach((v) {
        volunteers!.add(new Volunteers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['city'] = this.city;
    data['photo'] = this.photo;
    data['is_active'] = this.isActive;
    data['short_details'] = this.shortDetails;
    data['user_joined'] = this.userJoined;
    if (this.volunteers != null) {
      data['volunteers'] = this.volunteers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Volunteers {
  int? id;
  int? userId;
  int? volunteerOpportunityId;
  String? createdAt;
  String? updatedAt;
  dynamic details;
  String? status;
  dynamic photo;

  Volunteers(
      {this.id,
        this.userId,
        this.volunteerOpportunityId,
        this.createdAt,
        this.updatedAt,
        this.details,
        this.status,
        this.photo});

  Volunteers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    volunteerOpportunityId = json['volunteer_opportunity_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    details = json['details'];
    status = json['status'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['volunteer_opportunity_id'] = this.volunteerOpportunityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['details'] = this.details;
    data['status'] = this.status;
    data['photo'] = this.photo;
    return data;
  }
}
