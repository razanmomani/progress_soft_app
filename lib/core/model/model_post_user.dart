class ModelPostUser {
  dynamic createdDate;
  String? post;
  String? postId;
  String? userId;
  String?title;

  ModelPostUser({
    this.post,
    this.createdDate,
    this.userId,
    this.postId,
    this.title,
  });

  ModelPostUser.fromJson(Map<String, dynamic>? json) {
    createdDate = json?["createdDate"];
    postId = json?["postId"];
    userId = json?["userId"];
    post = json?["post"];
    title = json?["title"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdDate'] = createdDate;
    data['postId'] = postId;
    data['userId'] = userId;
    data['post'] = post;
    data['title'] = title;

    return data;
  }
}
