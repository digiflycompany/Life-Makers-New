import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class EmergencyCampaignModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Campaigns>? campaigns=[];

  EmergencyCampaignModel({this.status, this.errNum, this.msg, this.campaigns});

  EmergencyCampaignModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['campaigns'] != null) {
      campaigns = <Campaigns>[];
      json['campaigns'].forEach((v) {
        campaigns!.add(new Campaigns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.campaigns != null) {
      data['campaigns'] = this.campaigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
