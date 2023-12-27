class ChangePasswordMessage {
  bool? status;
  String? message;
  List<String>? errors;

  ChangePasswordMessage({this.status, this.message, this.errors});

  ChangePasswordMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errors'] = this.errors;
    return data;
  }
}
