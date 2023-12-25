class RegisterErrorModel {
  bool? status;
  int? errNum;
  String? message;
  String? msg;
  List<String>? errors;

  RegisterErrorModel(
      {this.status, this.errNum, this.message, this.msg, this.errors});

  RegisterErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    msg = json['msg'];
    errors = json['errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['message'] = this.message;
    data['msg'] = this.msg;
    data['errors'] = this.errors;
    return data;
  }
}
