class MessageModel {
  final bool error;
  final bool success;
  final dynamic data;
  final int code;
  final String message;

  MessageModel({
    required this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      error: json['error'] ?? false,
      success: json['success'] ?? false,
      data: json['data'],
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'data': data,
      'code': code,
      'message': message,
    };
  }
}
