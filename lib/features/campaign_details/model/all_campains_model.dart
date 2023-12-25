import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class AllCampainsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Campains>? allCurrentCampaigns;
  List<Campains>? allPastCampaigns;
  List<Campains>? allNextCampaigns;

  AllCampainsModel(
      {this.status,
        this.errNum,
        this.msg,
        this.allCurrentCampaigns,
        this.allPastCampaigns,
        this.allNextCampaigns});

  AllCampainsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['all_current_campaigns'] != null) {
      allCurrentCampaigns = <Campains>[];
      json['all_current_campaigns'].forEach((v) {
        allCurrentCampaigns!.add(new Campains.fromJson(v));
      });
    }
    if (json['all_past_campaigns'] != null) {
      allPastCampaigns = <Campains>[];
      json['all_past_campaigns'].forEach((v) {
        allPastCampaigns!.add(new Campains.fromJson(v));
      });
    }
    if (json['all_next_campaigns'] != null) {
      allNextCampaigns = <Campains>[];
      json['all_next_campaigns'].forEach((v) {
        allNextCampaigns!.add(new Campains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.allCurrentCampaigns != null) {
      data['all_current_campaigns'] =
          this.allCurrentCampaigns!.map((v) => v.toJson()).toList();
    }
    if (this.allPastCampaigns != null) {
      data['all_past_campaigns'] =
          this.allPastCampaigns!.map((v) => v.toJson()).toList();
    }
    if (this.allNextCampaigns != null) {
      data['all_next_campaigns'] =
          this.allNextCampaigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCurrentCampaigns {
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
  dynamic followBy;
  bool? userJoined;
  List<Tasks>? tasks;

  AllCurrentCampaigns(
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
        this.userJoined,
        this.tasks});

  AllCurrentCampaigns.fromJson(Map<String, dynamic> json) {
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
  var count;
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

class AllNextCampaigns {
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
  bool? userJoined;
  List<Tasks>? tasks;

  AllNextCampaigns(
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
        this.userJoined,
        this.tasks});

  AllNextCampaigns.fromJson(Map<String, dynamic> json) {
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
    data['user_joined'] = this.userJoined;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
