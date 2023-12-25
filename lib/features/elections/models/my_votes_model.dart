class MyVotesModel {
  bool? status;
  String? errNum;
  String? msg;
  List<MyVote>? myVote;

  MyVotesModel({this.status, this.errNum, this.msg, this.myVote});

  MyVotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['my_vote'] != null) {
      myVote = <MyVote>[];
      json['my_vote'].forEach((v) {
        myVote!.add(new MyVote.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.myVote != null) {
      data['my_vote'] = this.myVote!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyVote {
  int? id;
  String? name;
  String? imageUrl;
  int? vote;
  String? details;
  Pivot? pivot;

  MyVote(
      {this.id, this.name, this.imageUrl, this.vote, this.details, this.pivot});

  MyVote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    vote = json['vote'];
    details = json['details'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['vote'] = this.vote;
    data['details'] = this.details;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? votersId;

  Pivot({this.userId, this.votersId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    votersId = json['voters_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['voters_id'] = this.votersId;
    return data;
  }
}
