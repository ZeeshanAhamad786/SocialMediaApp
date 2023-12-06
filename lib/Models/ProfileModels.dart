class ProfileModel {
  final String profileimage;
  late String name;
  final String dob;
  final location;
 final String backgroundImage;
  final String bio;
  final String userId;
  final String numberOfPosts;
  final String numberOfFollowers;
  final String numberOfFollowings;
  final List<String> posts;
  final List <String> activeChatUsers;
  final String followers;

  ProfileModel({
    required this.profileimage,
    required this.name,
    required this.dob,
    required this.userId,
    required this.location,
    required this.bio,
    required this.numberOfPosts,
    required this.numberOfFollowers,
    required this.numberOfFollowings,
    required this.posts,
    required this.activeChatUsers,
    required this.followers,
    required this.backgroundImage
  });

  // Create a factory method to deserialize from a Map
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profileimage: json['photoUrl'] ?? '',
      name: json['name'] ?? '',
      dob: json['dob'] ?? '',
      userId: json['userId'] ?? '',
      location: json['userLocation'] ?? '',
      bio: json['userBio'] ?? '',
      numberOfPosts: json['numberOfPosts'] ?? '',
      numberOfFollowers: json['numberOfFollowers'] ?? '',
      numberOfFollowings: json['numberOfFollowings'] ?? '',
      posts: List<String>.from(json['posts'] ?? []),
      activeChatUsers: List<String>.from(json['activeChatUsers'] ?? []),
      followers: json['followers'] ?? '',
      backgroundImage: json['backgroundImage'] ?? '',

    );
  }


  // Create a method to serialize to a Map
  Map<String, dynamic> toJson() {
    return {
      'photoUrl': profileimage,
      'name': name,
      'dob': dob,
      'numberOfPosts': numberOfPosts,
      'numberOfFollowers': numberOfFollowers,
      'numberOfFollowings': numberOfFollowings,
      'posts': posts,
      'activeChatUsers': activeChatUsers,
      'followers': followers,
      if (backgroundImage.isNotEmpty) 'backgroundImage': backgroundImage,
      if (location.isNotEmpty) 'userLocation': location,
      if (bio.isNotEmpty) 'userBio': bio,
      // Add other fields
    };
  }

}
