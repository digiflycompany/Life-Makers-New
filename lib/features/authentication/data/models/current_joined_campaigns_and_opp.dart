class CurrentJoinedCampaignsAndOpp {
  bool? status;
  String? errNum;
  String? msg;
  List<CurrentCampaigns>? currentCampaigns;
  List<CurrentVolunteerOpportunities>? currentVolunteerOpportunities;

  CurrentJoinedCampaignsAndOpp(
      {this.status,
        this.errNum,
        this.msg,
        this.currentCampaigns,
        this.currentVolunteerOpportunities});

  CurrentJoinedCampaignsAndOpp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['current_campaigns'] != null) {
      currentCampaigns = <CurrentCampaigns>[];
      json['current_campaigns'].forEach((v) {
        currentCampaigns!.add(new CurrentCampaigns.fromJson(v));
      });
    }
    if (json['current_volunteer_opportunities'] != null) {
      currentVolunteerOpportunities = <CurrentVolunteerOpportunities>[];
      json['current_volunteer_opportunities'].forEach((v) {
        currentVolunteerOpportunities!
            .add(new CurrentVolunteerOpportunities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.currentCampaigns != null) {
      data['current_campaigns'] =
          this.currentCampaigns!.map((v) => v.toJson()).toList();
    }
    if (this.currentVolunteerOpportunities != null) {
      data['current_volunteer_opportunities'] =
          this.currentVolunteerOpportunities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentCampaigns {
  int? id;
  String? name;
  String? details;
  String? startAt;
  String? endAt;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? city;
  String? photo;
  int? isActive;
  int? followBy;
  dynamic shortDetails;
  String? userJoined;
  List<Tasks>? tasks;

  CurrentCampaigns(
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
        this.userJoined,
        this.tasks});

  CurrentCampaigns.fromJson(Map<String, dynamic> json) {
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
  dynamic count;
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
  String? details;
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

class CurrentVolunteerOpportunities {
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
  int? followBy;
  String? userJoined;

  CurrentVolunteerOpportunities(
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
        this.followBy,
        this.userJoined});

  CurrentVolunteerOpportunities.fromJson(Map<String, dynamic> json) {
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
    followBy = json['follow_by'];
    userJoined = json['user_joined'];
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
    data['follow_by'] = this.followBy;
    data['user_joined'] = this.userJoined;
    return data;
  }
}
