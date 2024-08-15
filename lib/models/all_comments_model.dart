class CommentsResponseModel {
  // final bool? error;
  final bool success;
  final List<CommentModel>? data;
  final int code;
  final String message;

  CommentsResponseModel({
    // this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory CommentsResponseModel.fromJson(Map<String, dynamic> json) {

       return CommentsResponseModel(
      // error: json['error']!= null ? CommentsResponseModel.fromJson(json['error']):null,
      success: json['success'] as bool,
      data:
          (json['data'] as List).map((e) => CommentModel.fromJson(e)).toList().isNotEmpty ?  (json['data'] as List).map((e) => CommentModel.fromJson(e)).toList() : null,
      code: json['code'] as int,
      message: json['message'] as String ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        // 'error': error,
        'success': success,
        'data': data?.map((e) => e.toJson()).toList(),
        'code': code,
        'message': message,
      };
}

class CommentModel {
  final String id;
  final String userId;
  final String postId;
  final String userName;
  final String thumbnailUrl;
  final bool isProducer;
  final String comment;
  final int likes;
  final List<String> likedBy;
  final bool isLikedByYou;
  final List<ReplyModel> replies;
  final DateTime createdAt;
  // final DateTime updatedAt;
  final DateTime? editedAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.userName,
    required this.thumbnailUrl,
    required this.isProducer,
    required this.comment,
    required this.likes,
    required this.likedBy,
    required this.isLikedByYou,
    required this.replies,
    required this.createdAt,
    // required this.updatedAt,
    this.editedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'] as String ?? '',
      userId: json['user_id'] as String ?? '',
      postId: json['post_id'] as String ?? '',
      userName: json['user_name'] as String ?? '',
      thumbnailUrl: json['thumbnail_url'] as String ?? '',
      isProducer: json['is_producer'] as bool,
      comment: json['comment'] as String ?? '',
      likes: json['likes'] as int,
      likedBy: (json['liked_by'] as List).cast<String>(),
      isLikedByYou: json['is_liked_by_you'] as bool,
      replies:
          (json['replies'] as List).map((e) => ReplyModel.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['created_at'] as String ?? ''),
      // updatedAt: DateTime.parse(json['updatedAt'] as String ?? ''),
      editedAt: json['edited_at'] != null
          ? DateTime.parse(json['edited_at'] as String ?? '')
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user_id': userId,
        'post_id': postId,
        'user_name': userName,
        'thumbnail_url': thumbnailUrl,
        'is_producer': isProducer,
        'comment': comment,
        'likes': likes,
        'liked_by': likedBy,
    'is_liked_by_you': isLikedByYou,
        'replies': replies.map((e) => e.toJson()).toList(),
        'created_at': createdAt.toIso8601String(),
        // 'updatedAt': updatedAt.toIso8601String(),
        'edited_at': editedAt?.toIso8601String(),
      };
}

class ReplyModel {
  final userId;
  final String userName;
  final int likes;
  final String reply;
  final bool isProducer;
  final List<String> likedBy;
  final String thumbnailUrl;
  final bool isLikedByYou;
  final DateTime createdAt;
  final DateTime editedAt;
  final String id;

  ReplyModel({
    required this.userId,
    required this.userName,
    required this.likes,
    required this.reply,
    required this.isProducer,
    required this.likedBy,
    required this.thumbnailUrl,
    required this.isLikedByYou,
    required this.createdAt,
    required this.editedAt,
    required this.id,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String ?? '',
      likes: json['likes'] as int,
      reply: json['reply'] as String ?? '',
      isProducer: json['is_producer'] as bool,
      likedBy: (json['liked_by'] as List).cast<String>(),
      thumbnailUrl: json['thumbnail_url'] as String ?? '',
      isLikedByYou: json['is_liked_by_you'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String ?? ''),
      editedAt: DateTime.parse(json['edited_at'] as String ?? ''),
      id: json['_id'] as String ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
        'user_name': userName,
        'likes': likes,
        'reply': reply,
        'is_producer': isProducer,
        'liked_by': likedBy,
        'thumbnail_url': thumbnailUrl,
    'is_liked_by_you': isLikedByYou,
        'created_at': createdAt.toIso8601String(),
        'edited_at': editedAt.toIso8601String(),
        '_id': id,
      };
}
