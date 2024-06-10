class CalendarCampaignsModel {
  bool? status;
  String? errNum;
  String? msg;
  Campaign? campaign;

  CalendarCampaignsModel({this.status, this.errNum, this.msg, this.campaign});

  CalendarCampaignsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    campaign = json['campaign'] != null
        ? new Campaign.fromJson(json['campaign'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.campaign != null) {
      data['campaign'] = this.campaign!.toJson();
    }
    return data;
  }
}

class Campaign {
  int? id;
  String? name;
  String? details;
  String? startAt;
  String? endAt;
  String? type;
  String? createdAt;
  String? updatedAt;
  Null city;
  String? photo;
  int? isActive;
  Null followBy;
  Null shortDetails;
  int? campaignPoints;
  int? campaignHours;
  bool? checkIn;
  bool? checkOut;
  String? userJoined;
  List<Tasks>? tasks;

  Campaign(
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
        this.followBy,
        this.shortDetails,
        this.campaignPoints,
        this.campaignHours,
        this.checkIn,
        this.checkOut,
        this.userJoined,
        this.tasks});

  Campaign.fromJson(Map<String, dynamic> json) {
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
    followBy = json['follow_by'];
    shortDetails = json['short_details'];
    campaignPoints = json['campaign_points'];
    campaignHours = json['campaign_hours'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    userJoined = json['user_joined'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
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
    data['follow_by'] = this.followBy;
    data['short_details'] = this.shortDetails;
    data['campaign_points'] = this.campaignPoints;
    data['campaign_hours'] = this.campaignHours;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['user_joined'] = this.userJoined;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  int? taskId;
  int? campaignId;
  String? createdAt;
  String? updatedAt;
  List<String>? details;
  Null count;
  Task? task;

  Tasks(
      {this.id,
        this.taskId,
        this.campaignId,
        this.createdAt,
        this.updatedAt,
        this.details,
        this.count,
        this.task});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    campaignId = json['campaign_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    details = json['details'].cast<String>();
    count = json['count'];
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_id'] = this.taskId;
    data['campaign_id'] = this.campaignId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['details'] = this.details;
    data['count'] = this.count;
    if (this.task != null) {
      data['task'] = this.task!.toJson();
    }
    return data;
  }
}

class Task {
  int? id;
  String? name;
  Null details;
  String? createdAt;
  String? updatedAt;

  Task({this.id, this.name, this.details, this.createdAt, this.updatedAt});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
