

class NotificationModel {
  final String profilepic;
  final String name;
  final String notification;
  final bool isRequestAccepted;
  final bool hasstoryLiked;
  final bool hasMentioned;
  final String? time; // Make the time property nullable

  NotificationModel({
    required this.profilepic,

    required this.name,
    required this.notification,
    this.isRequestAccepted = false,
    this.hasstoryLiked = false,
    this.hasMentioned = false,
    this.time, // Update the constructor parameter to match
  });
}

