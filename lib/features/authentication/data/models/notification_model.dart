class NotificationModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Notifications>? notifications;

  NotificationModel({this.status, this.errNum, this.msg, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  String? title;
  String? text;
  int? userId;
  String? link;
  String? createdAt;
  String? updatedAt;
  String? type;
  dynamic deletedAt;

  Notifications(
      {this.id,
        this.title,
        this.text,
        this.userId,
        this.link,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.deletedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    userId = json['user_id'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['user_id'] = this.userId;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
