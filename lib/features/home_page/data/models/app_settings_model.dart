class AppSettingsModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  AppSettingsModel({this.status, this.errNum, this.msg, this.data});

  AppSettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? vonageKey;
  String? vonageSecret;
  String? smsMessage;
  String? smsTitle;
  dynamic createdAt;
  String? updatedAt;
  String? logo;
  String? title;
  int? lightDark;
  int? isAdminLoader;
  String? adminLoader;
  int? isElections;
  String? logoWhite;
  String? electionsStartDate;
  String? electionsEndDate;
  String? excelContentMsg;
  String? excelEmailSubject;

  Data(
      {this.id,
        this.vonageKey,
        this.vonageSecret,
        this.smsMessage,
        this.smsTitle,
        this.createdAt,
        this.updatedAt,
        this.logo,
        this.title,
        this.lightDark,
        this.isAdminLoader,
        this.adminLoader,
        this.isElections,
        this.logoWhite,
        this.electionsStartDate,
        this.electionsEndDate,
        this.excelContentMsg,
        this.excelEmailSubject});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vonageKey = json['vonage_key'];
    vonageSecret = json['vonage_secret'];
    smsMessage = json['sms_message'];
    smsTitle = json['sms_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logo = json['logo'];
    title = json['title'];
    lightDark = json['light_dark'];
    isAdminLoader = json['is_admin_loader'];
    adminLoader = json['admin_loader'];
    isElections = json['is_elections'];
    logoWhite = json['logo_white'];
    electionsStartDate = json['elections_start_date'];
    electionsEndDate = json['elections_end_date'];
    excelContentMsg = json['excel_content_msg'];
    excelEmailSubject = json['excel_email_subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vonage_key'] = this.vonageKey;
    data['vonage_secret'] = this.vonageSecret;
    data['sms_message'] = this.smsMessage;
    data['sms_title'] = this.smsTitle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['logo'] = this.logo;
    data['title'] = this.title;
    data['light_dark'] = this.lightDark;
    data['is_admin_loader'] = this.isAdminLoader;
    data['admin_loader'] = this.adminLoader;
    data['is_elections'] = this.isElections;
    data['logo_white'] = this.logoWhite;
    data['elections_start_date'] = this.electionsStartDate;
    data['elections_end_date'] = this.electionsEndDate;
    data['excel_content_msg'] = this.excelContentMsg;
    data['excel_email_subject'] = this.excelEmailSubject;
    return data;
  }
}
