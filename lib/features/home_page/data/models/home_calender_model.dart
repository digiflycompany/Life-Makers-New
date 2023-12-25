class HomeCalenderModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Calender>? calender;

  HomeCalenderModel({this.status, this.errNum, this.msg, this.calender});

  HomeCalenderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['calender'] != null) {
      calender = <Calender>[];
      json['calender'].forEach((v) {
        calender!.add(new Calender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.calender != null) {
      data['calender'] = this.calender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Calender {
  String? name;
  String? date;
  String? url;

  Calender({this.name, this.date, this.url});

  Calender.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['url'] = this.url;
    return data;
  }
}
