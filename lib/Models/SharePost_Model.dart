class SharePost_Model {
   final String? userId;
  final String image;
  final String name;
   bool wantSend;

  SharePost_Model({
    this.userId,
    required this.image,
    required this.name,
    this.wantSend=false,
  });
}
