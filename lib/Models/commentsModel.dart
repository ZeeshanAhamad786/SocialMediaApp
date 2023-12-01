class commentModel1 {
  final String commentId;
  final String userId;
  final String comment;
  final int timestamp;  // Change the type to int
  final String userProfileImage;
  final String userName;
  final String postId;

  commentModel1({
    required this.commentId,
    required this.userId,
    required this.comment,
    required this.timestamp,
    required this.userProfileImage,
    required this.userName,
    required this.postId,
  });
  factory commentModel1.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      // Handle the case where map is null
      return commentModel1(
        commentId: '',
        userId: '',
        comment: '',
        timestamp: 0,
        userProfileImage: '',
        userName: '',
        postId: '',
      );
    }

    return commentModel1(
      commentId: map['commentId'] ?? '',
      userId: map['userId'] ?? '',
      comment: map['comment'] ?? '',
      timestamp: map['timestamp'] != null ? map['timestamp'] : 0,
      userProfileImage: map['userProfileImage'] ?? '',
      userName: map['userName'] ?? '',
      postId: map['postId'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'userId': userId,
      'comment': comment,
      'timestamp': timestamp,
      'userProfileImage': userProfileImage,
      'userName': userName,
      'postId': postId,
    };
  }

}
