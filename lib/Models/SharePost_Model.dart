class SharePost_Model {
  final String image;
  final String name;
   bool wantSend;

  SharePost_Model({
    required this.image,
    required this.name,
    this.wantSend=false,
  });
}
