class LikeModel {
  final bool error;
  final bool success;
  final int likes;
  final int code;
  final String message;

  LikeModel({
    required this.error,
    required this.success,
    required this.likes,
    required this.code,
    required this.message,
  });

  // Factory constructor to create a LikeModel from JSON map
  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      error: json['error'] as bool,
      success: json['success'] as bool,
      likes: json['data']['likes'] as int,
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  // Method to convert LikeModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'data': {'likes': likes},
      'code': code,
      'message': message,
    };
  }
}
