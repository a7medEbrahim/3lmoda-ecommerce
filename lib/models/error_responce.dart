class Error404 {
  String statusMsg;
  String message;

  Error404({required this.statusMsg, required this.message});

  factory Error404.fromJson(Map<String, dynamic> json) {
    return Error404(
      statusMsg: json['statusMsg'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusMsg': statusMsg,
      'message': message,
    };
  }
}

class ErrorDetails {
  String value;
  String msg;
  String param;
  String location;

  ErrorDetails({
    required this.value,
    required this.msg,
    required this.param,
    required this.location,
  });

  factory ErrorDetails.fromJson(Map<String, dynamic> json) {
    return ErrorDetails(
      value: json['value'],
      msg: json['msg'],
      param: json['param'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'msg': msg,
      'param': param,
      'location': location,
    };
  }
}

class Error400 {
  String message;
  ErrorDetails errors;

  Error400({
    required this.message,
    required this.errors,
  });

  factory Error400.fromJson(Map<String, dynamic> json) {
    return Error400(
      message: json['message'],
      errors: ErrorDetails.fromJson(json['errors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'errors': errors.toJson(),
    };
  }
}
