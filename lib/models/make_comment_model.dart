class MakeCommentModel {
  final bool error;
  final bool success;
  final dynamic data;
  final int code;
  final String message;

  MakeCommentModel({
    required this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory MakeCommentModel.fromJson(Map<String, dynamic> json) {

    return MakeCommentModel(
      error: json['error'] as bool,
      success: json['success'] as bool,
      data: json['data'],
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'success': success,
    'data': data,
    'code': code,
    'message': message,
  };
}

