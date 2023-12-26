class UserJoinedVolunteerOpportunities {
  bool? status;
  String? errNum;
  String? msg;
  List<ProgramVolunteerOpportunities>? programVolunteerOpportunities;
  List<ActivityVolunteerOpportunities>? activityVolunteerOpportunities;
  List<TasksVolunteerOpportunities>? tasksVolunteerOpportunities;

  UserJoinedVolunteerOpportunities(
      {this.status,
        this.errNum,
        this.msg,
        this.programVolunteerOpportunities,
        this.activityVolunteerOpportunities,
        this.tasksVolunteerOpportunities});

  UserJoinedVolunteerOpportunities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['program_volunteer_opportunities'] != null) {
      programVolunteerOpportunities = <ProgramVolunteerOpportunities>[];
      json['program_volunteer_opportunities'].forEach((v) {
        programVolunteerOpportunities!
            .add(new ProgramVolunteerOpportunities.fromJson(v));
      });
    }
    if (json['activity_volunteer_opportunities'] != null) {
      activityVolunteerOpportunities = <ActivityVolunteerOpportunities>[];
      json['activity_volunteer_opportunities'].forEach((v) {
        activityVolunteerOpportunities!
            .add(new ActivityVolunteerOpportunities.fromJson(v));
      });
    }
    if (json['tasks_volunteer_opportunities'] != null) {
      tasksVolunteerOpportunities = <TasksVolunteerOpportunities>[];
      json['tasks_volunteer_opportunities'].forEach((v) {
        tasksVolunteerOpportunities!
            .add(new TasksVolunteerOpportunities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.programVolunteerOpportunities != null) {
      data['program_volunteer_opportunities'] =
          this.programVolunteerOpportunities!.map((v) => v.toJson()).toList();
    }
    if (this.activityVolunteerOpportunities != null) {
      data['activity_volunteer_opportunities'] =
          this.activityVolunteerOpportunities!.map((v) => v.toJson()).toList();
    }
    if (this.tasksVolunteerOpportunities != null) {
      data['tasks_volunteer_opportunities'] =
          this.tasksVolunteerOpportunities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgramVolunteerOpportunities {
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

  ProgramVolunteerOpportunities(
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
        this.followBy});

  ProgramVolunteerOpportunities.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class ActivityVolunteerOpportunities {
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
  dynamic followBy;

  ActivityVolunteerOpportunities(
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
        this.followBy});

  ActivityVolunteerOpportunities.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class TasksVolunteerOpportunities {
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
  dynamic followBy;

  TasksVolunteerOpportunities({
    this.id,
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
  });

  TasksVolunteerOpportunities.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

